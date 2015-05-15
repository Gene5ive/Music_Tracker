require 'spec_helper'
require 'capybara/rspec'
require './app'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Sinatra framework check', { :type => :feature }) do
  it('verifies basic routing and view setup') do
    visit('/test')
    expect(page).to have_content('Sinatra OK')
  end
end

describe('Application Testing', { :type => :feature }) do

  #BAND
  describe('Band Methods') do
    #CREATE ONE AND READ ALL
    it('lists any added bands') do
      Band.create(name: 'mount kimbie')
      visit('/bands_venues')
      expect(page).to have_content('Mount Kimbie')
    end

    #CREATE ONE AND READ ONE
    it('displays a single band page') do
      band = Band.create(name: 'little dragon')
      visit("/bands/#{band.id}")
      expect(page).to have_content('Little Dragon')
    end

    #UPDATE ONE
    it('displays edit form with instantaneous results') do
      band = Band.create(name: 'Foo Fighters')
      visit("/bands/#{band.id}/edit")
      find_field('venue_name').value
    end

    #DELETE ONE
    it('removes a band') do
      band = Band.create(name: 'Sons of Huns')
      visit('/bands_venues')
      find(:xpath, "//a[@href='/bands/#{band.id}/delete']").click
      expect(page).to_not have_content('Sons of Huns')
    end
  end

  #VENUE
  describe('Venue Methods') do
    #CREATE ONE AND READ ALL
    it('lists any added venues') do
      Venue.create(name: 'rose garden')
      visit('/bands_venues')
      expect(page).to have_content('Rose Garden')
    end
  end

end
