require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'

require_relative 'event'

ActiveRecord::Base.configurations = YAML::load(IO.read('db/config.yml'))
ActiveRecord::Base.establish_connection(ENV.fetch('RACK_ENV', 'development').to_sym)

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
  Event.create(title:params[:title], description:params[:description])
end
