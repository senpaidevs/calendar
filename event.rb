require 'dm-core'
require 'dm-migrations'
require 'geocoder'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")


class Event
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :address, String
  property :place, String
  property :description, Text
  property :date, DateTime
  property :url, String
  property :lat, Float
  property :long, Float

  before :save, :geolocalize

  def geolocalize 

  	results = Geocoder.search(address)
  	
  	if results.size > 0
	  self.lat = results.first.latitude
	  self.long = results.first.longitude	  	  	
  	end
  end
end

DataMapper.finalize
