# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Pendant, type: :model do
  describe '.search' do
    let(:artist_1) { FactoryGirl.create(:artist, name: 'Aiuto') }
    let(:artist_2) { FactoryGirl.create(:artist, name: 'RyanKane') }
    let!(:pendant_1) { FactoryGirl.create(:pendant, artist: artist_1, name: 'Lizard on a Shroom') }
    let!(:pendant_2) { FactoryGirl.create(:pendant, artist: artist_1, name: 'Fumicello') }
    let!(:pendant_3) { FactoryGirl.create(:pendant, artist: artist_2, name: 'Wolf Head') }

    subject { described_class.search(term) }

    context 'when the search term is in the artist name' do
      let(:term) { 'aiuto' }

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
      let!(:pendant_3) { FactoryGirl.create(:pendant, artist: artist_2, name: 'ryan wolf head') }
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
    subject { FactoryGirl.create(:pendant, artist: artist, artist_group: artist_group) }

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
end
