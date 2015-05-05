def setup_database
  if ENV['DATABASE_URL'].nil?
    ActiveRecord::Base.configurations = YAML::load(IO.read('db/config.yml'))
    ActiveRecord::Base.establish_connection(ENV.fetch('RACK_ENV', 'development').to_sym)
  else
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  end
end
