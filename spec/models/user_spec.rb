# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.needs_reminder' do
    let(:frozen_time) { Time.zone.parse('2016-01-05 12:00') }
    around do |example|
      Timecop.freeze(frozen_time) { example.run }
    end

    let!(:user_without_record) { FactoryGirl.create(:user) }
    let!(:user_with_record_yesterday) { FactoryGirl.create(:user) }
    let!(:user_with_record_today) { FactoryGirl.create(:user) }

    let(:pendant_1) { FactoryGirl.create(:pendant, user: user_with_record_yesterday) }
    let(:pendant_2) { FactoryGirl.create(:pendant, user: user_with_record_today) }

    let!(:yesterday_record) { FactoryGirl.create :pendant_record, user: user_with_record_yesterday, worn_on: Date.parse('2016-01-04'), pendant: pendant_1 }
    let!(:today_record) { FactoryGirl.create :pendant_record, user: user_with_record_today, worn_on: Date.parse('2016-01-05'), pendant: pendant_2 }

    subject { described_class.needs_reminder }

    it 'returns the Users who do not have a pendant record today' do
      expect(subject).to contain_exactly user_with_record_yesterday, user_without_record
    end
  end
end
