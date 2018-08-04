# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.needs_reminder' do
    subject { described_class.needs_reminder }

    let(:frozen_time) { Time.zone.parse('2016-01-05 12:00') }
    around do |example|
      Timecop.freeze(frozen_time) { example.run }
    end

    let!(:user_without_record) { FactoryBot.create(:user) }
    let!(:user_with_record_yesterday) { FactoryBot.create(:user) }
    let!(:user_with_record_today) { FactoryBot.create(:user) }

    let(:pendant_1) { FactoryBot.create(:glass_art_piece) }
    let(:pendant_2) { FactoryBot.create(:glass_art_piece) }

    let!(:yesterday_record) { FactoryBot.create :pendant_record, user: user_with_record_yesterday, worn_on: Date.parse('2016-01-04'), pendant: pendant_1 }
    let!(:today_record) { FactoryBot.create :pendant_record, user: user_with_record_today, worn_on: Date.parse('2016-01-05'), pendant: pendant_2 }

    it 'returns the Users who do not have a pendant record today' do
      expect(subject).to contain_exactly user_with_record_yesterday, user_without_record
    end
  end

  describe '#recorded_pendant_today?' do
    subject { FactoryBot.create(:user) }

    let!(:old_pendant_record) { FactoryBot.create(:pendant_record, user: subject, worn_on: 2.days.ago) }

    context 'when there are NO pendant records today' do
      it 'returns false' do
        expect(subject.recorded_pendant_today?).to eq false
      end
    end

    context 'when there are pendant records today' do
      let!(:today_pendant_record) { FactoryBot.create(:pendant_record, user: subject, worn_on: 2.hours.ago) }

      it 'returns true' do
        expect(subject.recorded_pendant_today?).to eq true
      end
    end
  end

  describe '#display_name' do
    subject { FactoryBot.create :user, email: '1@example.org', name: name }

    let(:name) { nil }

    context 'when no name exists for the User' do
      it 'returns the email' do
        expect(subject.display_name).to eq '1@example.org'
      end
    end

    context 'when a name is present on the User' do
      let(:name) { 'Somebody' }

      it 'returns the email' do
        expect(subject.display_name).to eq 'Somebody'
      end
    end
  end
end
