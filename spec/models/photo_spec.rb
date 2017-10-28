# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe '#data_uri' do
    subject { FactoryBot.create(:photo, photo_content_type: 'image/jpeg') }

    let(:io_adapters) { double(for: double(read: 'CONTENT')) }
    before do
      allow(Paperclip).to receive(:io_adapters).and_return(io_adapters)
    end

    it 'returns the correct data uri' do
      expect(subject.data_uri).to eq 'data:image/jpeg;base64,Q09OVEVOVA%3D%3D'
    end
  end
end
