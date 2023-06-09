# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


if Rails.env.production?
   Rails.logger.info "Not seeding in production"
   return puts "Not seeding in production"
end

Rails.logger.info "Seeding database"
# --------------------------------------------------
# Create users
# --------------------------------------------------

# later
user = User.create(email: "user@example.com", password: "password", name:"User")
user = User.create(email: "test@example.com", password: "password", name:"test")



# --------------------------------------------------
# Create planes
# --------------------------------------------------


planes = [
  {
    name: "Boeing 747",
    plane_type: "Commercial",
    description: "The Boeing 747 is a large, long-range wide-body airliner.",
    image: "https://plus.unsplash.com/premium_photo-1661957173884-901e33146e92?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFzc2VuZ2VyJTIwcGxhbmV8ZW58MHx8MHx8&w=1000&q=80",
    price: 1000000,
    model: "747-400",
    year_of_manufacture: Date.new(1999, 1, 1),
    life_span: Time.now + 10.years,
    fees: 1000.0,
    user_id: 1
    },
  {
    name: "Cessna 172",
    plane_type: "Private",
    description: "The Cessna 172 is a four-seat, single-engine, high-wing aircraft.",
    image: "https://plus.unsplash.com/premium_photo-1661957173884-901e33146e92?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFzc2VuZ2VyJTIwcGxhbmV8ZW58MHx8MHx8&w=1000&q=80",
    price: 50000,
    model: "172N",
    year_of_manufacture: Date.new(1985, 1, 1),
    life_span: Time.now + 5.years,
    fees: 500.0,
    user_id: 1
  },
  {
    name: "KOKOK",
    plane_type: "Private",
    description: "The Piper PA-28 Cherokee is a family of light aircraft built by Piper Aircraft.",
    image: "https://plus.unsplash.com/premium_photo-1661957173884-901e33146e92?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFzc2VuZ2VyJTIwcGxhbmV8ZW58MHx8MHx8&w=1000&q=80",
    price: 50000,
    model: "PA-28-181 Archer III",
    year_of_manufacture: Date.new(2019, 1, 1),
    life_span: Time.now + 5.years,
    fees: 500.0,
    user_id: 1
  },
  {
    name: "Piper PA-28",
    plane_type: "Private",
    description: "The Piper PA-28 Cherokee is a family of light aircraft built by Piper Aircraft.",
    image: "https://plus.unsplash.com/premium_photo-1661957173884-901e33146e92?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFzc2VuZ2VyJTIwcGxhbmV8ZW58MHx8MHx8&w=1000&q=80",
    price: 50000,
    model: "PA-28-181 Archer III",
    year_of_manufacture: Date.new(2022, 1, 1),
    life_span: Time.now + 5.years,
    fees: 500.0,
    user_id: 1
  },
  {
    name: "Piper PA-28",
    plane_type: "Private",
    description: "The Piper PA-28 Cherokee is a family of light aircraft built by Piper Aircraft.",
    image: "https://plus.unsplash.com/premium_photo-1661957173884-901e33146e92?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFzc2VuZ2VyJTIwcGxhbmV8ZW58MHx8MHx8&w=1000&q=80",
    price: 50000,
    model: "PA-28-181 Archer III",
    year_of_manufacture: Date.new(2023, 1, 1),
    life_span: Time.now + 5.years,
    fees: 500.0,
    user_id: 1
  },
  {
    name: "Piper PA-28",
    plane_type: "Private",
    description: "The Piper PA-28 Cherokee is a family of light aircraft built by Piper Aircraft.",
    image: "https://plus.unsplash.com/premium_photo-1661957173884-901e33146e92?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFzc2VuZ2VyJTIwcGxhbmV8ZW58MHx8MHx8&w=1000&q=80",
    price: 50000,
    model: "PA-28-181 Archer III",
    year_of_manufacture: Date.new(2009, 1, 1),
    life_span: Time.now + 5.years,
    fees: 500.0,
    user_id: 1
  }
]
planes.each do |plane|
  Plane.create(plane)
end


6.times do |i|
  PlaneReservation.create({ date: Date.today,
  start_time: Time.now,
  end_time: Time.now + 2.hours, user_id: 2,
  duration: 10,
  plane_id: i })
end

puts "Done seeding database"

