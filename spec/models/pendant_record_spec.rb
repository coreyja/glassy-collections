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
end
