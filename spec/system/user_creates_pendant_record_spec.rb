require 'rails_helper'

RSpec.describe 'User creates Pendant Record', js: true do
  let(:user) { FactoryGirl.create(:user, :with_personal_collection) }
  let!(:pendant) { FactoryGirl.create(:glass_art_piece, :wearable, name: 'Awesome Pendant', collection: user.collections.first) }

  let(:frozen_time) { Time.zone.parse('2017-09-17 12:00') }
  around do |example|
    Timecop.freeze(frozen_time) { example.run }
  end

  scenario 'with required info from home page' do
    visit root_path(as: user)

    click_link 'Pendant Records'
    click_link 'Record Pendant'
    fill_select_and_take_first_result 'Select Pendant...', 'Awesome Pendant'
    attach_file('Photo', Rails.root + 'spec/fixtures/sample_upload_image.png')
    click_button 'Create Pendant record'

    expect(page.find('.day[data-date="2017-09-17"]')).to have_content 'Awesome Pendant'
  end

  scenario 'for forgotten record' do
    visit root_path(as: user)

    click_link 'Pendant Records'
    click_link 'Record Pendant'
    click_link 'Fake an old one :-('

    select_option '[name="pendant_record[pendant_id]"]', "#{pendant} - #{pendant.artist_group.name}"

    select_option '[name="pendant_record[worn_on(1i)]"]', '2017'
    select_option '[name="pendant_record[worn_on(2i)]"]', 'September'
    select_option '[name="pendant_record[worn_on(3i)]"]', '13'

    click_button 'Create Pendant record'

    expect(page.find('.day[data-date="2017-09-13"]')).to have_content 'Awesome Pendant'
  end

  private

  def select_option(css_selector, value)
    find(:css, css_selector).find(:option, value).select_option
  end
end
