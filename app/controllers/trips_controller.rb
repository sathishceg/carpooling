require 'date'

class TripsController < ApplicationController
  before_filter :not_authenticated, :except => [:index, :show]
  before_filter :correct_user, :only => [:edit, :update, :destroy]

  helper_method :filter_number_of_seats
  helper_method :seats_free?
  helper_method :can_book?
  helper_method :has_created_trip?

  # GET /trips
  # GET /trips.json
  def index
    @found = false

    if (params[:search_start].present? && params[:search_end].present?)
      #@trips = Trip.search(params)
      @trips = search_trips
      @map_start_point = params[:search_start]
      @map_end_point = params[:search_end]
    else
      #@trips = Trip.all
      @trips = Trip.where('start_time >= ?', DateTime.now)
    end

    if (params[:search_start].present? && params[:search_end].present?)
      if @found
        flash[:notice] = "Successful! Here some trips we found for you."
      else
        flash[:notice] = "Sorry, we couldn't find any trips for you."
      end
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @trip = Trip.find(params[:id])
    @user = User.find(@trip.created_by)
    @booking = @user.bookings.build
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    @trip = Trip.new
    @trip.build_start_location
    @trip.build_end_location

      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
  end

  # POST /trips
  # POST /trips.json
  def create
      @trip =Trip.new(params[:trip])
      respond_to do |format|

      bool = true

      if (@trip.taxi_type == 1 && @trip.number_of_free_seats>5) || @trip.number_of_free_seats<0
        format.html { render action: "new"}
        format.json { render json: @trip.errors, status: :unprocessable_entity }
        flash[:alert] = "The chosen number of free seats is not valid with your taxi!"
        bool = false
      elsif (@trip.taxi_type == 2 && @trip.number_of_free_seats>7) || @trip.number_of_free_seats<0
        format.html { render action: "new"}
        format.json { render json: @trip.errors, status: :unprocessable_entity }
        flash[:alert] = "The chosen number of free seats is not valid with your taxi!"
        bool = false
      elsif (@trip.taxi_type == 0 && @trip.number_of_free_seats>3) || @trip.number_of_free_seats<0
        format.html { render action: "new"}
        format.json { render json: @trip.errors, status: :unprocessable_entity }
        flash[:alert] = "The chosen number of free seats is not valid with your taxi!"
        bool = false
      end

      @trip.created_by=current_user.id

      if bool && @trip.save
         fare = Geocoder::Calculations.to_kilometers(@trip.start_location.distance_to(@trip.end_location.address))*1.54+3.2;
         fare =fare.to_f.round(2).to_f;

         if @trip.taxi_type == 1
          fare =fare+3
         elsif @trip.taxi_type == 2
          fare =fare+6
         end

         @trip.update_attribute(:fare,fare)

         @booking = current_user.bookings.build
         @booking.trip = @trip
         @booking.save

        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { render action: "new" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.json
  def update
    @trip = Trip.find(params[:id])

    respond_to do |format|

     if @trip.update_attributes(params[:trip])
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :ok }
    end
  end

  def correct_user
    @trip = Trip.find(params[:id])
    unless correct_user?(@trip)
      redirect_to root_url, :alert => "You need to be logged in to view this page"
      false
    end
  end

  def filter_number_of_seats
    @trip = Trip.find(params[:id])
    filter_number_of_seats = Hash.new("1")
    for i in 1..@trip.number_of_free_seats
      filter_number_of_seats[i] = i
    end
  end

  def can_book?
    bool = true
    @trip = Trip.find(params[:id])
    bookings = Booking.find_all_by_user_id(current_user.id)
    bookings.each do |booking|
      if booking.trip_id == @trip.id
        bool = false
      end
    end

    return bool
  end

  def has_created_trip?
    bool = false
    @trip = Trip.find(params[:id])
    trips = Trip.find_all_by_created_by(current_user.id)
    trips.each do |t|
      if t.id == @trip.id
        bool = true
      end
    end

    return bool
  end

  def seats_free?
    @trip = Trip.find(params[:id])
    if @trip.number_of_free_seats > 0
      true
    end
  end

  def search_trips
    #@found = false

    radius_start = params[:radius_start]
    radius_end = params[:radius_end]
    start_locations = Location.near(params[:search_start], radius_start, :order => :distance)
    end_locations = Location.near(params[:search_end], radius_end, :order => :distance)
    trips_by_start_location = Trip.find_all_by_start_location_id(start_locations.to_a)
    trips_by_end_location = Trip.find_all_by_end_location_id(end_locations.to_a)
    trips_by_free_seats = Trip.where('number_of_free_seats >= ?', params[:free_seats])

    datetime_start = DateTime.new(params[:datetime_start]["datetime_start(1i)"].to_i,
                    params[:datetime_start]["datetime_start(2i)"].to_i,
                    params[:datetime_start]["datetime_start(3i)"].to_i,
                    params[:datetime_start]["datetime_start(4i)"].to_i,
                    params[:datetime_start]["datetime_start(5i)"].to_i)
    datetime_end = DateTime.new(params[:datetime_end]["datetime_end(1i)"].to_i,
                    params[:datetime_end]["datetime_end(2i)"].to_i,
                    params[:datetime_end]["datetime_end(3i)"].to_i,
                    params[:datetime_end]["datetime_end(4i)"].to_i,
                    params[:datetime_end]["datetime_end(5i)"].to_i)

    datetime_end = datetime_end.advance(:minutes => 1)
    trips_by_time = Trip.where('start_time BETWEEN ? AND ?', datetime_start, datetime_end) &
        Trip.where('start_time >= ?', DateTime.now)

    found_trips = trips_by_start_location & trips_by_end_location & trips_by_free_seats & trips_by_time
    if(found_trips.count > 0)
      @found = true
    end

    return found_trips

  end
end
