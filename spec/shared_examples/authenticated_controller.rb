# frozen_string_literal: true

RSpec.shared_examples 'authenticated GET controller' do |url|
  context 'when a User is NOT logged in' do
    it 'redirects to the login page' do
      get url
      expect(response).to redirect_to sign_in_path
    end
  end

  context 'when a user is logged in' do
    let(:user) { FactoryBot.create(:user) }

    it 'responds with a 200' do
      get url, params: { as: user.id }
      expect(response).to have_http_status(200)
    end
  end
end
