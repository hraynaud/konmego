require 'set'
require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

describe RegistrationService do # rubocop:disable Metrics/BlockLength

  before do
    Person.delete_all
    Registration.delete_all
    Invite.delete_all
  end

  describe 'create' do
    context 'successful' do
      it 'creates new identity' do
        expect  do
          reg = RegistrationService.create(
            { first_name: 'firstyFirst', last_name: 'Lastylast', email: 'meellyMel@mail.com', password: 'wordyword999' }
          )
          expect(reg.reg_code).to(be_present)
          expect(reg.status).to eq('pending')
          expect(reg.reg_code_expiration.to_i).to be(1.day.from_now.to_i)
        end.to change { Person.count }.by(1)

      end

    end
  end

  describe 'confirm' do
    context 'successful' do

      it 'updates  confirmed status' do
        @reg = RegistrationService.create(
          { first_name: 'firstyFirst', last_name: 'Lastylast', email: 'meellyMel@mail.com', password: 'wordyword999' }
        )
        RegistrationService.confirm(@reg.id, @reg.reg_code, @reg.password)
        expect(@reg.reload.status).to eq('confirmed')
      end

      it 'updates confirms with inviter' do
        @invite = FactoryBot.create(:invite)
        @reg = RegistrationService.create(
          { first_name: 'firstyFirst', last_name: 'Lastylast', email: 'meellyMel@mail.com', password: 'wordyword999',
            invite_code: @invite.id }
        )

        RegistrationService.confirm(@reg.id, @reg.reg_code, @reg.password, @invite.id)
        @reg.reload
        expect(@reg.status).to eq('confirmed')
        expect(@reg.inviter).to eq(@invite.sender)
      end

    end
  end

end
