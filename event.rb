require 'activerecord'
require 'geocoder'

class Event < ActiveRecord::Base
  before_save :geolocalize

  private
    def geolocalize
      results = Geocoder.search(address)

      if results.size > 0
        self.lat = results.first.latitude
        self.long = results.first.longitude
      end
    end
end
