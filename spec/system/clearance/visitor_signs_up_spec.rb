# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Visitor signs up' do
  it 'by navigating to the page' do
    visit sign_in_path

    click_link I18n.t('sessions.form.sign_up')

    expect(current_path).to eq sign_up_path
  end

  it 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password'

    expect_user_to_be_signed_in
  end

  it 'tries with invalid email' do
    sign_up_with 'invalid_email', 'password'

    expect_user_to_be_signed_out
  end

  xit 'tries with blank password' do
    sign_up_with 'valid@example.com', ''

    expect_user_to_be_signed_out
  end
end
