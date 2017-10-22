require 'rails_helper'

RSpec.describe 'User uses api to check status' do
  let(:user) { FactoryGirl.create(:user) }
  let(:encoded_token) { JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base) }

  scenario 'without an auth header and gets an error' do
    get api_my_pendant_record_status_path

    expect(response.body).to eq '{"error":"Not Authorized"}'
  end

  scenario 'with a valid auth header gets status' do
    get api_my_pendant_record_status_path, headers: { 'Authorization' => encoded_token }

    expect(response.body).to eq '{"pendant_recorded?":false}'
  end

  context 'when the user has recorded a pendant' do
    let!(:pendant_record) { FactoryGirl.create :pendant_record, user: user }

    scenario 'with a valid auth header gets status of true' do
      get api_my_pendant_record_status_path, headers: { 'Authorization' => encoded_token }

      expect(response.body).to eq '{"pendant_recorded?":true}'
    end
  end
end
