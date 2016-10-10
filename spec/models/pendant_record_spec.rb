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
    let(:pendant) { FactoryGirl.create(:pendant) }
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
end
