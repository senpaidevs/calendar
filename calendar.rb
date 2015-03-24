require 'sinatra'
require 'slim'

require_relative 'event'

get '/' do
  @events = Event.all

  slim :index, locals: {:events => @events}
end
