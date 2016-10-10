# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Authentication, type: :model do
  describe '.create_with_omniauth!' do
    let(:omniauth_hash) do
      {
        'provider' => 'Instgram',
        'uid' => '1',
        'credentials' => {
          'token' => 'ABC',
        },
        info: {
          nickname: 'Nickname',
        },
      }
    end

    context 'when there was no current user passed in' do
      it 'creates a new Authentication and User' do
        expect { described_class.create_with_omniauth!(omniauth_hash) }.
          to change { Authentication.count }.by(1).
          and change { User.count }.by(1)
      end
    end

    context 'when there is a user passed in' do
      let!(:current_user) { FactoryGirl.create :user }

      it 'creates a new Authentication associated to the given user' do
        expect { described_class.create_with_omniauth!(omniauth_hash, current_user) }.
          to change { Authentication.count }.by(1).
          and change { current_user.authentications.count }.by(1).
          and change { User.count }.by(0)
      end
    end
  end

  describe '#update_token' do
    let(:omniauth_hash) do
      { 'credentials' => { 'token' => 'ABC' } }
    end

    subject { FactoryGirl.create :authentication, token: 'XYZ' }

    it 'updates the token' do
      expect { subject.update_token omniauth_hash }.
        to change { subject.token }.from('XYZ').to('ABC')
    end
  end
end
