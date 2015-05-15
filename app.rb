require 'bundler/setup'
Bundler.require(:default, :prodction)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

#TEST
get('/test') do
  @test_var = 'Sinatra OK'
  @db = "ActiveRecord Using: #{ActiveRecord::Base.connection_config[:database].upcase}"
  erb(:test)
  redirect to('/')
end
