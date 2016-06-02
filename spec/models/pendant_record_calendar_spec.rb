require 'rails_helper'

RSpec.describe PendantRecordCalendar, type: :model do
  let(:user) { FactoryGirl.create :user }
  let(:pendant) { FactoryGirl.create :pendant, user: user }

  it 'raises ArgumentError if not initialized with a User' do
    expect { PendantRecordCalendar.new }.to raise_error ArgumentError
  end

  it 'raises ArgumentError if not initialized with a from_date or till_date' do
    expect { PendantRecordCalendar.new user: user }.to raise_error ArgumentError
  end

  it 'raises ArgumentError if given a duration smaller than 1 day' do
    expect { PendantRecordCalendar.new duration: 1.second }.to raise_error ArgumentError
  end

  describe '#pendant_records' do
    context 'when given both a from_date and till_date' do
      let(:from_date) { Date.parse('2016-01-01') }
      let(:till_date) { Date.parse('2016-01-15') }

      let!(:pendant_record_before) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2015-12-31') }
      let!(:pendant_record_during1) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2016-01-01') }
      let!(:pendant_record_during2) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2016-01-14') }
      let!(:pendant_record_on_till_date) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2016-01-15') }

      subject { PendantRecordCalendar.new user: user, from_date: from_date, till_date: till_date }

      it 'contains only the PendantRecords within the time frame' do
        expect(subject.pendant_records).to eq [pendant_record_during1, pendant_record_during2]
        expect(subject.pendant_records).to_not include pendant_record_on_till_date
      end
    end

    context 'when given a from_date and a duration' do
      let(:from_date) { Date.parse('2016-01-01') }
      let(:duration) { 14.days }

      let!(:pendant_record_before) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2015-12-31') }
      let!(:pendant_record_during1) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2016-01-01') }
      let!(:pendant_record_during2) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2016-01-14') }
      let!(:pendant_record_on_till_date) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2016-01-15') }

      subject { PendantRecordCalendar.new user: user, from_date: from_date, duration: duration }

      it 'contains only the PendantRecords within the time frame' do
        expect(subject.pendant_records).to eq [pendant_record_during1, pendant_record_during2]
        expect(subject.pendant_records).to_not include pendant_record_on_till_date
      end
    end

    context 'when given just a from_date' do
      let(:from_date) { Date.parse('2016-01-01') }

      let!(:pendant_record_before) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2015-12-31') }
      let!(:pendant_record_during1) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2016-01-01') }
      let!(:pendant_record_during2) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2016-01-30') }
      let!(:pendant_record_on_till_date) { FactoryGirl.create :pendant_record, user: user, pendant: pendant, created_at: Time.zone.parse('2016-02-01') }

      subject { PendantRecordCalendar.new user: user, from_date: from_date }

      it 'contains only the PendantRecords within the time frame' do
        expect(subject.pendant_records).to eq [pendant_record_during1, pendant_record_during2]
        expect(subject.pendant_records).to_not include pendant_record_on_till_date
      end
    end
  end
end
