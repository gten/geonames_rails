require 'geonames_rails'

namespace :geonames_rails do
  desc 'pull down the geonames data from the server'
  task :pull => :environment do
    GeonamesRails::Puller.new.pull
  end
  
  desc 'pull geonames data, load into db, then clean up after itself'
  task :run => :environment do
    puller = GeonamesRails::Puller.new
    writer = ENV['DRY_RUN'] ? GeonamesRails::Writers::DryRun.new : GeonamesRails::Writers::ActiveRecord.new
    GeonamesRails::Loader.new(puller, writer).load_data
  end
  
  desc 'load the data from files you already have laying about'
  task :load => :environment do
    writer = ENV['DRY_RUN'] ? GeonamesRails::Writers::DryRun.new : GeonamesRails::Writers::ActiveRecord.new
    GeonamesRails::Loader.new(nil, writer).load_data
  end
  
end