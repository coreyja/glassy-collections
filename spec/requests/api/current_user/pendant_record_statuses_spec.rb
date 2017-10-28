require 'rails_helper'

RSpec.describe 'User uses api to check status' do
  let(:user) { FactoryBot.create(:user) }
  let(:encoded_token) { JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base) }

  scenario 'without an auth header and gets an error' do
    get api_my_pendant_record_status_path

    json = JSON.parse(response.body).to_hash
    expect(json).to include({"error" => "Not Authorized"})
  end

  scenario 'with a valid auth header gets status' do
    get api_my_pendant_record_status_path, headers: { 'Authorization' => encoded_token }

    json = JSON.parse(response.body).to_hash
    expect(json).to include('pendant_recorded?' => false)
  end

  context 'when the user has recorded a pendant' do
    let(:pendant) { FactoryBot.create :glass_art_piece, :wearable, name: 'Awesome Pendant' }
    let!(:pendant_record) { FactoryBot.create :pendant_record, user: user, pendant: pendant }

    scenario 'with a valid auth header gets status of true' do
      get api_my_pendant_record_status_path, headers: { 'Authorization' => encoded_token }

      json = JSON.parse(response.body).to_hash
      expect(json).to include('pendant_recorded?' => true, 'pendant_name' => 'Awesome Pendant')
    end
  end
end
