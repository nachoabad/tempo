# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin1 = Admin.create!(email: 'admin1@mail.com', password: 'adminadmin', password_confirmation: 'adminadmin')

user1 = User.create! email: 'user1@mail.com', password: 'useruser', password_confirmation: 'useruser'
user2 = User.create! email: 'user2@mail.com', password: 'useruser', password_confirmation: 'useruser'

service1 =  admin1.services.create! name: 'Service 1', slug: 'service1', time_zone: 'Venezuela',
            payment_instruction: 'Here goes the payment instructions'

service1.slots.create! day: 1, hour: 8,  min:  0, status: 1
service1.slots.create! day: 1, hour: 9,  min: 30, status: 1
service1.slots.create! day: 1, hour: 17, min:  0, status: 1
service1.slots.create! day: 2, hour: 8,  min:  0, status: 1
service1.slots.create! day: 2, hour: 9,  min:  0, status: 1
service1.slots.create! day: 2, hour: 10, min:  0, status: 1
service1.slots.create! day: 3, hour: 8,  min:  0, status: 1
service1.slots.create! day: 4, hour: 8,  min:  0, status: 1
service1.slots.create! day: 5, hour: 8,  min:  0, status: 1
service1.slots.create! day: 6, hour: 8,  min:  0, status: 1
