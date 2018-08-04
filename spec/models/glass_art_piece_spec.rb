# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GlassArtPiece, type: :model do
  describe '.search' do
    subject { described_class.search(term) }

    let(:artist_group_1) { FactoryBot.create(:artist_group, artists: [artist_1, artist_3]) }
    let(:artist_group_2) { FactoryBot.create(:artist_group, artists: [artist_2]) }
    let(:artist_1) { FactoryBot.create(:artist, name: 'Aiuto') }
    let(:artist_2) { FactoryBot.create(:artist, name: 'RyanKane') }
    let(:artist_3) { FactoryBot.create(:artist, name: 'Keepsake') }
    let!(:glass_art_piece_1) { FactoryBot.create(:glass_art_piece, :wearable, artist_group: artist_group_1, name: 'Lizard on a Shroom') }
    let!(:glass_art_piece_2) { FactoryBot.create(:glass_art_piece, :wearable, artist_group: artist_group_1, name: 'Fumicello') }
    let!(:glass_art_piece_3) { FactoryBot.create(:glass_art_piece, :wearable, artist_group: artist_group_2, name: 'Wolf Head') }

    context 'when the search term is in the artist name' do
      let(:term) { 'keep' }

      it 'finds the correct glass_art_pieces' do
        expect(subject).to contain_exactly glass_art_piece_1, glass_art_piece_2
      end
    end

    context 'when the search term is in the glass_art_piece name' do
      let(:term) { 'wolf' }

      it 'finds the correct glass_art_pieces' do
        expect(subject).to contain_exactly glass_art_piece_3
      end
    end

    context 'when the search term is in the artist name and glass_art_piece name' do
      let!(:glass_art_piece_3) { FactoryBot.create(:glass_art_piece, :wearable, artist_group: artist_group_2, name: 'ryan wolf head') }
      let(:term) { 'ryan' }

      it 'only returns the matching glass_art_piece once' do
        expect(subject).to contain_exactly glass_art_piece_3
      end
    end

    context 'when the search term is not in any of the glass_art_pieces' do
      let(:term) { 'eye' }

      it 'returns an empty collection' do
        expect(subject).to be_empty
      end
    end
  end

  describe '#to_s' do
    subject { FactoryBot.create(:glass_art_piece, name: name) }

    let(:name) { 'PendantName' }

    it 'returns the name of the glass_art_piece' do
      expect(subject.name).to eq 'PendantName'
    end
  end

  describe '#artist_name' do
    subject { FactoryBot.create(:glass_art_piece, artist_group: artist_group) }

    let(:artist_group) { FactoryBot.create(:artist_group, artists: FactoryBot.create_list(:artist, 2, name: 'Joe')) }

    it 'uses the names of the artists in the artist group' do
      expect(subject.artist_name).to eq 'Joe & Joe'
    end
  end

  describe '#artist_ids=' do
    subject { FactoryBot.create(:glass_art_piece) }

    let(:artist_ids) { [artist_1.id, artist_2.id] }
    let(:artist_1) { FactoryBot.create(:artist) }
    let(:artist_2) { FactoryBot.create(:artist) }

    context 'when an ArtistGroup with the artists does not exist' do
      let(:other_artist) { FactoryBot.create(:artist) }
      let!(:other_artist_group) { FactoryBot.create(:artist_group, artists: [artist_1, other_artist]) }

      it 'inits a new artist group and assigns it' do
        subject.artist_ids = artist_ids
        expect(subject.artist_group.persisted?).to eq false
        expect(subject.artist_group.artists).to eq [artist_1, artist_2]
      end
    end

    context 'when an ArtistGroup with the artists does exist' do
      let!(:existing_artist_group) { FactoryBot.create(:artist_group, artists: [artist_1, artist_2]) }

      it 'assigns the existing artist group' do
        subject.artist_ids = artist_ids
        expect(subject.artist_group).to eq existing_artist_group
        expect(subject.artist_group.artists).to eq [artist_1, artist_2]
      end
    end
  end

  describe '::Params' do
    subject { described_class::Params::Pendant.new params }

    describe '#attrs' do
      context 'when provided with an artist_ids array' do
        let(:params) do
          {
            artist_ids: artist_ids
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
            name: 'Pendnat Name'
          }
        end

        it 'returns the params, plus some defaults' do
          expect(subject.attrs).to include params
        end
      end
    end
  end
end
