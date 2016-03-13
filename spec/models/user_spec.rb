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
end
