require 'rails_helper'

RSpec.feature 'User creates Artist' do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'from home page with valid information' do
    visit root_path(as: user)
    click_link 'Artists'
    click_link 'New Artist'
    fill_in 'artist_name', with: 'Some Artist'
    fill_in 'artist_instagram_username', with: 'some_artist'
    click_button 'Create Artist'
    expect(page).to have_content 'Some Artist'
    expect(page).to have_content 'some_artist'
  end
end

