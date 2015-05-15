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
    #READ ALL
    it('lists any added bands') do
      Band.create(name: 'mount kimbie')
      visit('/bands_venues')
      expect(page).to have_content('Mount Kimbie')
    end

    #READ ONE
    it('displays a single band page') do
      band = Band.create(name: 'little dragon')
      visit("/bands/#{band.id}")
      expect(page).to have_content('Little Dragon')
    end
  end

end
