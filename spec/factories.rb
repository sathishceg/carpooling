Factory.define :user do |f|
  f.sequence(:email) { |n| "test#{n}@test.com" }
  f.password "secRet1"
end

Factory.define :trip do |f|
  f.start_time DateTime.now()
  f.number_of_free_seats 3
  f.fare  10.00
  f.created_at DateTime.new(2012,01,1)
  f.start_location_id 0
  f.end_location_id 1
  f.taxi_type 1
  f.created_by "Tobi"
end
