require 'rails_helper'

RSpec.describe ArtistArtistGroup, type: :model do
  context 'validations' do
    describe 'artist and artist_group uniqueness' do
      let(:artist) { FactoryGirl.create(:artist) }
      let(:artist_group) { FactoryGirl.create(:artist_group) }
      subject { FactoryGirl.build(:artist_artist_group, artist: artist, artist_group: artist_group) }

      context 'with no existing records' do
        it 'is valid' do
          expect(subject.valid?).to eq true
        end
      end

      context 'with an existing duplicate records' do
        let!(:dulicate_record) { FactoryGirl.create(:artist_artist_group, artist: artist, artist_group: artist_group) }

        it 'is invalid' do
          expect(subject.valid?).to eq false
        end
      end
    end
  end
end
