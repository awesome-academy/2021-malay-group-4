# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Course.create!(name: "Course 1", description: "Course 1", status: "Opening", total_month: "6")
Course.create!(name: "Course 2", description: "Course 1", status: "Opening", total_month: "6")
Course.create!(name: "Course 3", description: "Course 1", status: "Opening", total_month: "6")
Course.create!(name: "Course 4", description: "Course 1", status: "Opening", total_month: "6")

User.create!(name: "Admin",
             email:  "zak@mail.com",
             password:              "111111",
             password_confirmation: "111111",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

