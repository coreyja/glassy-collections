# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PendantRecordCalendar, type: :model do
  let(:user) { FactoryGirl.create :user }
  let(:pendant) { FactoryGirl.create :pendant, user: user }

  it 'raises ArgumentError if not initialized with a User' do
    expect { PendantRecordCalendar.new date: Date.today }.to raise_error ArgumentError
  end

  it 'raises ArgumentError if not initialized with a date' do
    expect { PendantRecordCalendar.new user: user }.to raise_error ArgumentError
  end

  describe '#calendar_weeks' do
    let(:date) { Date.parse('2016-01-05') }

    subject { PendantRecordCalendar.new user: user, date: date }

    it 'returns an array arrays each with exactly 7 days' do
      expect(subject.weeks.map(&:count).uniq).to eq [7]
    end

    it 'sets dates outside the date range as disabled' do
      expect(subject.weeks.first.first.date).to be < date
      expect(subject.weeks.first.first.disabled?).to eq true
    end
  end
end
