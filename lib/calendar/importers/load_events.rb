require 'faker'
require_relative '../event'

20.times do
  Event.create(title: Faker::App.name,url: Faker::Internet.url,address:"Zaragoza",place: Faker::Company.name, description: Faker::Hacker.say_something_smart, date: Faker::Date.forward(60))
end
