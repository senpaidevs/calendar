require_relative '../calendar/importers'

namespace :importers do
  desc "Import events from external sources"
  task :ayuntamiento => :environment do
    importer = AZgzImporter.new
    importer.import
    puts 'Finished successfully'
  end
end