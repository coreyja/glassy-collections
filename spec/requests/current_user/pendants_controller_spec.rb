# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CurrentUser::PendantsController, type: :request do
  describe 'GET /my/pendants' do
    it_behaves_like 'authenticated GET controller', '/my/pendants'
  end

  describe 'GET /my/pendants/new' do
    it_behaves_like 'authenticated GET controller', '/my/pendants/new'
  end
end
