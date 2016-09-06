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
end
