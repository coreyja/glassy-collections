require 'rails_helper'

RSpec.describe 'User creates Pendant', js: true do
  let!(:artist) { FactoryGirl.create :artist, name: 'Artist Name' }
  let(:user) { FactoryGirl.create(:user, :with_personal_collection) }

  scenario 'with required info from home page' do
    visit root_path(as: user)
    click_link 'Pendants'
    click_link 'New Pendant'
    #    select = page.find('.Select')
    #    select.click
    page.find('div', text: 'Who made this pendant?').click
  end
end
