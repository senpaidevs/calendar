require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'

require_relative '../lib/calendar'

setup_database
set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  @events = Event.where(date: (Date.today .. Date.today + 30)).order(:date)
  slim :index, locals: {:events => @events}
end

get '/event/:id' do
  event = Event.find(params['id'])
  slim :detail, locals: {:event => event}
end

get '/events/new' do
  slim :new
end

post '/events' do
  Event.create(
    title: params[:title],
    address: params[:address],
    place: params[:place],
    description: params[:description],
    date: params[:date],
    url: params[:url],
  )

  redirect '/'
end
