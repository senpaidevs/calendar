require 'sinatra'
require 'slim'

require_relative 'event'

get '/' do
  @events = Event.all(:date.gte => Date.today)

  slim :index, locals: {:events => @events}
end
