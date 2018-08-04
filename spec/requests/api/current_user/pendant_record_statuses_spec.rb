# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User uses api to check status' do
  let(:user) { FactoryBot.create(:user) }
  let(:encoded_token) { JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base) }

  it 'without an auth header and gets an error' do
    get api_my_pendant_record_status_path

    expect(response.body).to eq '{"error":"Not Authorized"}'
  end

  it 'with a valid auth header gets status' do
    get api_my_pendant_record_status_path, headers: { 'Authorization' => encoded_token }

    expect(response.body).to eq '{"pendant_recorded?":false}'
  end

  context 'when the user has recorded a pendant' do
    let!(:pendant_record) { FactoryBot.create :pendant_record, user: user }

    it 'with a valid auth header gets status of true' do
      get api_my_pendant_record_status_path, headers: { 'Authorization' => encoded_token }

      expect(response.body).to eq '{"pendant_recorded?":true}'
    end
  end
end
