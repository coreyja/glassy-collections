# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'ArtistsController', type: :request do
  describe 'GET /artists' do
    it_behaves_like 'authenticated GET controller', '/artists'
  end

  describe 'GET /artists/new' do
    it_behaves_like 'authenticated GET controller', '/artists/new'
  end
end
