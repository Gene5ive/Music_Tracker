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
    #READ
    it('lists any added bands') do
      Band.create(name: 'Mount Kimbie')
      visit('/bands_venues')
      expect(page).to have_content('Mount Kimbie')
    end
  end

end
