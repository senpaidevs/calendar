require_relative '../calendar/importers'
require_relative '../calendar/infrastructure'

namespace :importers do
  desc "Import events from zaragoza.es"
  task :ayuntamiento => :environment do
    setup_database
    importer = AZgzImporter.new
    importer.import
    puts 'Finished successfully'
  end

  desc "Import events from meetup"
  task :meetup => :environment do
    setup_database
    importer = MeetupImporter.new(ENV['MEETUP_MEMBER'],ENV['MEETUP_KEY'])
    importer.import
    puts 'Finished successfully'
  end
end
