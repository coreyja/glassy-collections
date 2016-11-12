# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe '.artist_group' do
    let!(:artist_1) { FactoryGirl.create(:artist) }
    let!(:artist_2) { FactoryGirl.create(:artist) }

    subject { Artist.all.artist_group }

    context 'when there is not already a persisted ArtistGroup' do
      it 'returns a non-persisted ArtistGroup with the correct artists' do
        expect(subject.artists).to eq [artist_1, artist_2]
        expect(subject.persisted?).to eq false
      end
    end

    context 'when there is not already a persisted ArtistGroup' do
      let!(:existing_record) { FactoryGirl.create(:artist_group, artists: [artist_1, artist_2]) }

      it 'returns the ArtistGroup with the correct artists' do
        expect(subject).to eq existing_record
      end
    end
  end
end
