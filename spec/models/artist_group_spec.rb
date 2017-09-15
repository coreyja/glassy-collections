# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArtistGroup, type: :model do
  describe 'artists uniqueness validation' do
    let(:artist_1) { FactoryGirl.create(:artist) }
    let(:artist_2) { FactoryGirl.create(:artist) }

    subject { FactoryGirl.build(:artist_group, artists: [artist_1, artist_2]) }

    context 'when there is not already a persisted ArtistGroup' do
      it 'is valid' do
        expect(subject.valid?).to eq true
      end
    end

    context 'when there is already a persisted ArtistGroup with the same artists' do
      let!(:existing_record) { FactoryGirl.create(:artist_group, artists: [artist_1, artist_2]) }

      it 'is invalid' do
        expect(subject.valid?).to eq false
      end
    end
  end

  describe '#collab?' do
    let(:artists) { FactoryGirl.create_list(:artist, artist_count) }
    subject { FactoryGirl.create(:artist_group, artists: artists) }

    context 'when there is only 1 artist' do
      let(:artist_count) { 1 }

      it 'is false' do
        expect(subject.collab?).to eq false
      end
    end

    context 'when there are 2 artists' do
      let(:artist_count) { 2 }

      it 'is true' do
        expect(subject.collab?).to eq true
      end
    end

    context 'when there are 3 artists' do
      let(:artist_count) { 3 }

      it 'is true' do
        expect(subject.collab?).to eq true
      end
    end
  end

  describe '#name' do
    subject { FactoryGirl.create(:artist_group, artists: artists) }

    context 'when there is only 1 artist' do
      let(:artists) { [FactoryGirl.create(:artist, name: 'Joe')] }

      it 'is the name of the artist' do
        expect(subject.name).to eq 'Joe'
      end
    end

    context 'when there are 3 artists' do
      let(:artist_1) { FactoryGirl.create(:artist, name: 'Joe') }
      let(:artist_2) { FactoryGirl.create(:artist, name: 'Bill') }
      let(:artist_3) { FactoryGirl.create(:artist, name: 'Mark') }
      let(:artists) { [artist_1, artist_2, artist_3] }

      it 'is the name of the artist concatted with a ampersand and spaces' do
        expect(subject.name).to eq 'Joe & Bill & Mark'
      end
    end
  end

  describe '.find_by_artist_ids' do
    let(:artist_ids) { [artist.id] }
    let(:artist) { FactoryGirl.create(:artist) }

    subject { described_class.find_by_artist_ids(artist_ids) }

    context 'when an ArtistGroup with the artists does not exist' do
      let(:other_artist) { FactoryGirl.create(:artist) }
      let!(:other_artist_group) { FactoryGirl.create(:artist_group, artists: [artist, other_artist]) }

      it 'is nil' do
        expect(subject).to eq nil
      end
    end

    context 'when an ArtistGroup with the artists does not exist' do
      let!(:existing_artist_group) { FactoryGirl.create(:artist_group, artists: [artist]) }

      it 'returns the existing_artist_group' do
        expect(subject).to eq existing_artist_group
      end
    end
  end

  describe '.find_or_initialize_by_artist_ids' do
    let(:artist_ids) { [artist.id] }
    let(:artist) { FactoryGirl.create(:artist) }

    subject { described_class.find_or_initialize_by_artist_ids(artist_ids) }

    context 'when an ArtistGroup with the artists does not exist' do
      let(:other_artist) { FactoryGirl.create(:artist) }
      let!(:other_artist_group) { FactoryGirl.create(:artist_group, artists: [artist, other_artist]) }

      it 'is a new record with the correct artists' do
        expect(subject.persisted?).to eq false
        expect(subject.artists).to eq [artist]
      end
    end

    context 'when an ArtistGroup with the artists does not exist' do
      let!(:existing_artist_group) { FactoryGirl.create(:artist_group, artists: [artist]) }

      it 'returns the existing_artist_group' do
        expect(subject).to eq existing_artist_group
      end
    end
  end
end
