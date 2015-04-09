require 'sinatra'
require 'slim'

require_relative 'event'

get '/' do
  @events = Event.all(:date.gte => Date.today, :date.lt => Date.today + 31, :order => [:date.asc])

  slim :index, locals: {:events => @events}
end

get '/events/new' do
  slim :new
end

post '/events' do
  Event.create(title:params[:title], description:params[:description])
end