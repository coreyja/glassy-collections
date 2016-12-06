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
    let(:artist_group) { FactoryGirl.create(:artist_group, artists: FactoryGirl.create_list(:artist, 2, name: 'Joe')) }
    subject { FactoryGirl.create(:pendant, artist_group: artist_group) }


    it 'uses the names of the artists in the artist group' do
      expect(subject.artist_name).to eq 'Joe & Joe'
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
        expect(subject.artist_group).to eq existing_artist_group
        expect(subject.artist_group.artists).to eq [artist_1, artist_2]
      end
    end
  end

  describe '::Params' do
    subject { described_class::Params.new params }

    describe '#attrs' do
      context 'when provided with an artist_ids array' do
        let(:params) do
          {
            artist_ids: artist_ids,
          }
        end

        context 'when the array is all strings with a empty string' do
          let(:artist_ids) { ['', '1', '2'] }

          it 'removes the empty string and returns integers' do
            expect(subject.attrs).to include(artist_ids: [1, 2])
          end
        end

        context 'when the array is already integers' do
          let(:artist_ids) { [1, 2] }

          it 'does no transformation' do
            expect(subject.attrs).to include(artist_ids: [1, 2])
          end
        end
      end

      context 'when no artist_ids are provided' do
        let(:params) do
          {}
        end

        it 'does not contain artist_ids' do
          expect(subject.attrs.include?(:artist_ids)).to eq false
        end
      end

      context 'when given non-artist_ids params' do
        let(:params) do
          {
            name: 'Pendnat Name',
          }
        end

        it 'returns the params' do
          expect(subject.attrs).to eq params
        end
      end
    end
  end
end
