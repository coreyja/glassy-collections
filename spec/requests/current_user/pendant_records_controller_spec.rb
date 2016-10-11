# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CurrentUser::PendantRecordsController, type: :request do
  describe 'GET /my/pendant_records' do
    it_behaves_like 'authenticated GET controller', '/my/pendant_records'
  end

  describe 'GET /my/pendant_records/new' do
    it_behaves_like 'authenticated GET controller', '/my/pendant_records/new'
  end
end
