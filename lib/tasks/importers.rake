require_relative '../calendar/importers'
require_relative '../calendar/infrastructure'

namespace :importers do
  desc "Import events from external sources"
  task :ayuntamiento => :environment do
    setup_database
    importer = AZgzImporter.new
    importer.import
    puts 'Finished successfully'
  end
end
