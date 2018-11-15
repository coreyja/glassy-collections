# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User signs out' do
  it 'signs out' do
    sign_in
    sign_out

    expect_user_to_be_signed_out
  end
end
