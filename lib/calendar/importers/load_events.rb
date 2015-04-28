require 'faker'
require_relative '../event'

ActiveRecord::Base.configurations = YAML::load(IO.read('db/config.yml'))
ActiveRecord::Base.establish_connection(ENV.fetch('RACK_ENV', 'development').to_sym)

20.times do
  Event.create(title: Faker::App.name,url: Faker::Internet.url,address:"Zaragoza",place: Faker::Company.name, description: Faker::Hacker.say_something_smart, date: Faker::Date.forward(60))
end
