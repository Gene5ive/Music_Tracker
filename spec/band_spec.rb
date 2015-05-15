require 'spec_helper'

describe(Band) do
  it { should have_and_belong_to_many(:venues) }

  describe('Associations with Venues') do
    it('adds and verifies adding a venue to a band') do
      band = Band.create(name: 'Band')
      venue = band.venues.create(name: 'Arena')
      expect(band.venues.find(venue.id).name).to(eq('Arena'))
    end
  end

  describe('Validations and Callbacks') do
    it('ensures band name is present and unique') do
      Band.create(name: 'Warpaint')
      Band.create(name: 'Warpaint')
      Band.create(name: '')
      expect(Band.all.length).to(eq(1))
    end
  end

    it('ensures words in band name are capitalized') do
      band = Band.create(name: 'tame impala')
      expect(band.name).to(eq('Tame Impala'))
    end

end
