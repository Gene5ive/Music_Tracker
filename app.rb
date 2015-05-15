require 'bundler/setup'
Bundler.require(:default, :production)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

#TEST
get('/test') do
  @test_var = 'Sinatra OK'
  @db = "ActiveRecord Using: #{ActiveRecord::Base.connection_config[:database].upcase}"
  erb(:test)
  # redirect to('/')
end
#--------------

#INDEX
get('/') do
  redirect to('/bands_venues')
end
#----------

############
##BAND
#READ (list all)
get('/bands_venues') do
  erb(:bands_venues)
end
#----------------------

#CREATE FORM
get('/bands/add') do
  erb(:band_add_form)
end

#CREATE
post('/bands/add') do
  @band = Band.create(name: params.fetch('name'))
  redirect to("/bands/#{@band.id}/edit")
end
#--------------------

#READ (list a single band)
get('/bands/:band_id') do |band_id|
  @band = Band.find(band_id)
  erb(:band)
end
#------------------------

#UPDATE FORM
patch('/bands/:band_id/edit') do |recipe_id|
  @band = Band.find(band_id)
  erb(:band_update_form)
end
#--------------------------------

#DELETE
get('/bands/:band_id/delete') do |band_id|
  Band.find(band_id).destroy
  redirect to('/bands_venues')
end
