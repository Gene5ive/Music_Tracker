ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

puts "*******************"
puts "RACK_ENV: #{ENV['RACK_ENV']}"
puts "ActiveRecord Using: #{ActiveRecord::Base.connection_config[:database].upcase}"
puts "*******************"

RSpec.configure do |config|
  config.before(:each) do
    #
  end
  config.after(:each) do
    Band.all.each do |band|
      band.destroy
    end
    Venue.all.each do |venue|
      venue.destroy
    end
  end
end
