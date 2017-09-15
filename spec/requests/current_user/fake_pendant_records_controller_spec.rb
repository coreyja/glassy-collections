# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CurrentUser::FakePendantRecordsController, type: :request do
  describe 'GET /my/pendant_records/new' do
    it_behaves_like 'authenticated GET controller', '/my/fake_pendant_records/new'
  end
end
