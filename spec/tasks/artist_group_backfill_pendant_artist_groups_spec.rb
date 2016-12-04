# frozen_string_literal: true
require 'rails_helper'

describe 'artist_group:backfill_pendant_artist_groups' do
  include_context 'rake'

  context 'when there are pendants without a ArtistGroup' do
    let(:artist) { FactoryGirl.create(:artist) }
    let!(:pendant_without_artist_group) { FactoryGirl.create(:pendant, :ignore_validations, artist_group: nil, artist: artist) }

    context 'when an Artist Group with only the pendant artist exists' do
      let!(:artist_group) { FactoryGirl.create(:artist_group, artists: [artist]) }

      it 'assigns it to the pendant' do
        expect { subject.invoke }.to change { pendant_without_artist_group.reload.artist_group }.from(nil).to(artist_group)
      end
    end

    context 'when an Artist Group with only the pendant artist does NOT already exists' do
      let(:other_artist) { FactoryGirl.create(:artist) }
      let!(:other_artist_group) { FactoryGirl.create(:artist_group, artists: [artist, other_artist]) }

      it 'creates a new artist group and assign it to the pendant' do
        expect { subject.invoke }.to change { ArtistGroup.count }.from(1).to(2).
          and change { pendant_without_artist_group.reload.artist_group }.from(nil)
      end
    end
  end
end
