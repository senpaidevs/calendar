require 'standalone_migrations'

StandaloneMigrations::Tasks.load_tasks

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end
