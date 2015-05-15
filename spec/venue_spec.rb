require 'spec_helper'

describe(Venue) do
  describe('Associations with Venues') do
    it('adds and verifies adding a band to a venue') do
      venue = Venue.create(name: 'Venue')
      band = venue.bands.create(name: 'Band')
      expect(venue.bands.find(band.id).name).to(eq('Band'))
    end
  end

  # describe('Validations and Callbacks') do
  #   it('ensures band name is present and unique') do
  #     Band.create(name: 'Warpaint')
  #     Band.create(name: 'Warpaint')
  #     Band.create(name: '')
  #     expect(Band.all.length).to(eq(1))
  #   end
  # end
  #
  # it('ensures words in band name are capitalized') do
  #   band = Band.create(name: 'tame impala')
  #   expect(band.name).to(eq('Tame Impala'))
  # end

end
