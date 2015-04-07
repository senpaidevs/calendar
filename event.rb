require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")


class Event
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :description, Text
  property :date, DateTime
  property :url, String
end

DataMapper.finalize
