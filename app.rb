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
#READ ALL
get('/bands_venues') do
  erb(:bands_venues)
end
#----------------------

#READ DEPENDENTS
get('/bands/:band_id/venues') do |band_id|
  @band = band.find(band_id)
  erb(:band)
end
#-------------------------------

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

#READ ONE
get('/bands/:band_id') do |band_id|
  @band = Band.find(band_id)
  erb(:band)
end
#------------------------

#UPDATE FORM
get('/bands/:band_id/edit') do |band_id|
  @band = Band.find(band_id)
  erb(:band_update_form)
end

#UPDATE
patch('/bands/:band_id/edit') do |band_id|
  update_hash = Hash.new
  if params.has_key?('name')
    update_hash.store(:name, params['name'])
  end
  if params.has_key?('venue_name')
    update_hash.store(:venue_name, params['venue_name'])
  end
  if !update_hash.empty?
    Band.find(band_id).update(update_hash)
  end
  redirect to("/bands/#{band_id}")
end
#--------------------------------

#DELETE BAND
get('/bands/:band_id/delete') do |band_id|
  Band.find(band_id).destroy
  redirect to('/bands_venues')
end

############
##VENUE
#READ ALL
get('/venues') do
  erb(:band_venues)
end
#----------------

#READ DEPENDENTS
get('/venues/:venue_id') do |venue_id|
  @venue = Venue.find(venue_id)
  @bands = @venue.bands
  erb(:venue)
end
#--------------------------------

#CREATE FORM
post('/bands/:band_id/venues/create') do |band_id|
  venue = Venue.create(name: params['name'])
  Band.find(band_id).venues.push(venue)
  redirect to("/bands/#{band_id}/edit")
end

#CREATE JOIN
post('/bands/:band_id/add_venue') do |band_id|
  band = Band.find(band_id)
  venue = Venue.find(params['venue_id'])
  band.venues.push(venue)
  redirect to("/bands/#{band_id}/edit")
end
#----------------------------------

#DELETE VENUE
get('/venues/:venue_id/delete') do |venue_id|
  Venue.find(venue_id).destroy
  redirect to('/bands_venues')
end

#DELETE JOIN
get('/bands/:band_id/remove_venue/:venue_id') do |band_id, venue_id|
  band = Band.find(band_id)
  venue = Venue.find(venue_id)
  band.venues.destroy(venue)
  redirect to("/bands/#{band_id}/edit")
end
#-----------------------------------------------
