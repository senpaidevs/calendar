require 'faker'
require_relative 'event'

DataMapper.auto_migrate!

20.times do
  Event.create(title: Faker::App.name, description: Faker::Lorem.paragraph, date: Faker::Date.forward(60))
end
