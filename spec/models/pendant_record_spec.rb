# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PendantRecord, type: :model do
  describe '#assign_worn_on as before_create hook' do
    subject { FactoryGirl.build(:pendant_record) }

    around do |example|
      Timecop.freeze(Time.parse('1-1-2000 05:00')) { example.run }
    end

    it 'sets the worn_on date correctly' do
      expect { subject.save! }.
        to change { subject.worn_on }.
        from(nil).to(Date.parse('1-1-2000'))
    end
  end

  describe '.worn_on' do
    let(:pendant) { FactoryGirl.create(:glass_art_piece) }
    let(:user) { FactoryGirl.create(:user) }
    let(:date) { Date.parse('2016-01-05') }

    let!(:pendant_record_before) { FactoryGirl.create(:pendant_record, user: user, pendant: pendant, worn_on: Date.parse('2016-01-04')) }
    let!(:pendant_record_on) { FactoryGirl.create(:pendant_record, user: user, pendant: pendant, worn_on: Date.parse('2016-01-05')) }
    let!(:pendant_record_after) { FactoryGirl.create(:pendant_record, user: user, pendant: pendant, worn_on: Date.parse('2016-01-06')) }

    subject { described_class.worn_on date }

    it 'returns only the pendant records on the given date' do
      expect(subject).to contain_exactly pendant_record_on
    end
  end

  describe '.by_worn_on' do
    let(:pendant) { FactoryGirl.create(:glass_art_piece) }
    let(:user) { FactoryGirl.create(:user) }
    let(:date) { Date.parse('2016-01-05') }

    let!(:pendant_record_1) { FactoryGirl.create(:pendant_record, user: user, pendant: pendant, worn_on: Date.parse('2016-01-05'), created_at: Time.parse('2016-01-03 12:00')) }
    let!(:pendant_record_2) { FactoryGirl.create(:pendant_record, user: user, pendant: pendant, worn_on: Date.parse('2016-01-04'), created_at: Time.parse('2016-01-09 12:00')) }
    let!(:pendant_record_3) { FactoryGirl.create(:pendant_record, user: user, pendant: pendant, worn_on: Date.parse('2016-01-04'), created_at: Time.parse('2016-01-04 12:00')) }

    subject { described_class.by_worn_on }

    it 'returns only the pendant records on the given date' do
      expect(subject).to eq [pendant_record_1, pendant_record_2, pendant_record_3]
    end
  end
end
