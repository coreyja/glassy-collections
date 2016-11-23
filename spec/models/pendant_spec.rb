# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Pendant, type: :model do
  describe '.search' do
    let(:artist_group_1) { FactoryGirl.create(:artist_group, artists: [artist_1, artist_3]) }
    let(:artist_group_2) { FactoryGirl.create(:artist_group, artists: [artist_2]) }
    let(:artist_1) { FactoryGirl.create(:artist, name: 'Aiuto') }
    let(:artist_2) { FactoryGirl.create(:artist, name: 'RyanKane') }
    let(:artist_3) { FactoryGirl.create(:artist, name: 'Keepsake') }
    let!(:pendant_1) { FactoryGirl.create(:pendant, artist_group: artist_group_1, name: 'Lizard on a Shroom') }
    let!(:pendant_2) { FactoryGirl.create(:pendant, artist_group: artist_group_1, name: 'Fumicello') }
    let!(:pendant_3) { FactoryGirl.create(:pendant, artist_group: artist_group_2, name: 'Wolf Head') }

    subject { described_class.search(term) }

    context 'when the search term is in the artist name' do
      let(:term) { 'keep' }

      it 'finds the correct pendants' do
        expect(subject).to contain_exactly pendant_1, pendant_2
      end
    end

    context 'when the search term is in the pendant name' do
      let(:term) { 'wolf' }

      it 'finds the correct pendants' do
        expect(subject).to contain_exactly pendant_3
      end
    end

    context 'when the search term is in the artist name and pendant name' do
      let!(:pendant_3) { FactoryGirl.create(:pendant, artist_group: artist_group_2, name: 'ryan wolf head') }
      let(:term) { 'ryan' }

      it 'only returns the matching pendant once' do
        expect(subject).to contain_exactly pendant_3
      end
    end

    context 'when the search term is not in any of the pendants' do
      let(:term) { 'eye' }

      it 'returns an empty collection' do
        expect(subject).to be_empty
      end
    end
  end

  describe '#to_s' do
    let(:name) { 'PendantName' }

    subject { FactoryGirl.create(:pendant, name: name) }

    it 'returns the name of the pendant' do
      expect(subject.name).to eq 'PendantName'
    end
  end

  describe '#artist_name' do
    let(:artist) { FactoryGirl.create(:artist, name: 'Bill') }
    subject { FactoryGirl.create(:pendant, artist_id: artist.id, artist_group: artist_group) }

    context 'when the artist group is nil' do
      let(:artist_group) { nil }

      it 'uses the artist name' do
        expect(subject.artist_name).to eq 'Bill'
      end
    end

    context 'when the artist group exists' do
      let(:artist_group) { FactoryGirl.create(:artist_group, artists: FactoryGirl.create_list(:artist, 2, name: 'Joe')) }

      it 'uses the names of the artists in the account group' do
        expect(subject.artist_name).to eq 'Joe & Joe'
      end
    end
  end

  describe '#artist_ids=' do
    let(:artist_ids) { [artist_1.id, artist_2.id] }
    let(:artist_1) { FactoryGirl.create(:artist) }
    let(:artist_2) { FactoryGirl.create(:artist) }

    subject { FactoryGirl.create(:pendant) }

    context 'when an ArtistGroup with the artists does not exist' do
      let(:other_artist) { FactoryGirl.create(:artist) }
      let!(:other_artist_group) { FactoryGirl.create(:artist_group, artists: [artist_1, other_artist]) }

      it 'inits a new artist group and assigns it' do
        subject.artist_ids = artist_ids
        expect(subject.artist_group.persisted?).to eq false
        expect(subject.artist_group.artists).to eq [artist_1, artist_2]
      end
    end

    context 'when an ArtistGroup with the artists does exist' do
      let!(:existing_artist_group) { FactoryGirl.create(:artist_group, artists: [artist_1, artist_2]) }

      it 'assigns the existing artist group' do
        subject.artist_ids = artist_ids
        expect(subject.artist_group.persisted?).to eq true
        expect(subject.artist_group).to eq existing_artist_group
      end
    end
  end
end
