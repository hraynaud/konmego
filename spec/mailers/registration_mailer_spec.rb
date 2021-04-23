require "rails_helper"
require 'spec_helper'
include TestDataHelper::Utils

RSpec.describe RegistrationMailer, type: :mailer do
  before do 
    clear_db
  end

  describe 'welcome_email' do
    let(:reg) { FactoryBot.create(:identity) } 
    let(:mail) { RegistrationMailer.with(id: reg.id).welcome_email.deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eql(RegistrationMailer::REG_WELCOME_MSG)
      expect(mail.to).to eql([reg.email])
      expect(mail.from).to eql(['notifications@example.com'])
    end
  end
end
