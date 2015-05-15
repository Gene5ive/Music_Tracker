require 'spec_helper'

describe(Band) do
  describe('Associations with Venues') do
    it('adds and verifies adding a venue to a band') do
      band = Band.create(name: 'Band')
      venue = band.venues.create(name: 'Arena')
      expect(band.venues.find(venue.id).name).to(eq('Arena'))
    end
  end

end
