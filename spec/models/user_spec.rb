# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.create :user }

  describe '#dabable_users' do
    context 'when the user has no crews' do
      it 'returns just the subject' do
        expect(subject.dabable_users).to eq [subject]
      end
    end

    context 'when the user owns a crew' do
      let!(:ownded_crew) { FactoryGirl.create :crew, user: subject }

      context 'when the crew has members' do
        let(:crew_member_1) { FactoryGirl.create :user }
        let!(:crew_membership_1) { FactoryGirl.create :crew_membership, user: crew_member_1, crew: ownded_crew }
        let(:crew_member_2) { FactoryGirl.create :user }
        let!(:crew_membership_2) { FactoryGirl.create :crew_membership, user: crew_member_2, crew: ownded_crew }

        it 'returns the members of the crew and the user' do
          expect(subject.dabable_users).to eq [subject, crew_member_1, crew_member_2]
        end
      end
    end
  end

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
