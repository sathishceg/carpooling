class BookingsController < ApplicationController

  def create
    hash = params[:booking]
    number_seats = (params[:number_of_seats])

    @booking = Booking.new(params[:booking])
    @booking.trip = Trip.find(hash[:trip_id])
    @booking.user = User.find(current_user.id)
    @booking.number_of_seats = number_seats

    @booking.trip.update_attribute("number_of_free_seats",@booking.trip.number_of_free_seats-number_seats.to_i)

    if @booking.save
        UserMailer.contact_info_for_creator_email(User.find(@booking.trip.created_by), @booking.user, @booking.trip).deliver
        UserMailer.contact_info_for_booker_email(User.find(@booking.trip.created_by), @booking.user, @booking.trip).deliver
        redirect_to root_url, :notice => "Great! You have booked a trip with #{number_seats} seat."
    end
  end
end
