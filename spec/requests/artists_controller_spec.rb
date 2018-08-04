# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ArtistsController', type: :request do
  describe 'GET /artists' do
    it_behaves_like 'authenticated GET controller', '/artists'
  end

  describe 'GET /artists/new' do
    it_behaves_like 'authenticated GET controller', '/artists/new'
  end

  describe 'POST /artists' do
    context 'when authenticated' do
      let(:user) { FactoryBot.create(:user) }
      let(:authenticated_params) { params.merge(as: user.id) }

      before do
        get '/', params: { as: user.id } # This is weird. I shouldn't need it
      end

      context 'when not given valid params' do
        let(:params) do
          {
            artist: {
              name: nil,
              instagram_name: nil
            }
          }
        end

        it 'does not create a new artist and rerenders' do
          expect { post '/artists', params: authenticated_params }
            .to change(Artist, :count).by(0)

          expect(response).to have_http_status(200)
        end
      end

      context 'when given valid params' do
        let(:params) do
          {
            artist: {
              name: 'Artist Name'
            }
          }
        end

        it 'creates a new artist and redirects to index' do
          expect { post '/artists', params: authenticated_params }
            .to change(Artist, :count).by(1)

          expect(response).to redirect_to artists_path
        end
      end
    end

    context 'when un-authenticated' do
      it 'redirects to the login page' do
        post '/artists'
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
