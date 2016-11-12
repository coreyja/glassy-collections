# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ArtistGroup, type: :model do
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
end
