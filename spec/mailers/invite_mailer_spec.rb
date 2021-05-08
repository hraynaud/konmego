require "rails_helper"
require 'spec_helper'
include TestDataHelper::Utils

RSpec.describe InviteMailer, type: :mailer do
  before do 
    clear_db
  end

  describe 'invite_email' do
    let(:invite) { FactoryBot.create(:invite) } 
    let(:mail) { InviteMailer.with(id: invite.id).invite_email.deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eql(InviteMailer::INVITE_MSG)
      expect(mail.to).to eql([invite.email])
      expect(mail.from).to eql(['notifications@example.com'])
    end
  end

  describe 'topic_invite_email' do
    let(:invite) { FactoryBot.create(:invite) } 
    let(:mail) { InviteMailer.with(id: invite.id).topic_invite_email.deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eql(InviteMailer::TOPIC_INVITE_MSG)
      expect(mail.to).to eql([invite.email])
      expect(mail.from).to eql(['notifications@example.com'])
    end
  end
end
