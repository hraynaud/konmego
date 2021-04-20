require "rails_helper"
require 'spec_helper'
include TestDataHelper::Utils

RSpec.describe RegistrationMailer, type: :mailer do
  before do 
    clear_db
  end


  #TODO fix this test since it's broken due to refactor from PersonMailer to RegistrationMailer
  describe 'welcome_email' do
    let(:person) { FactoryBot.create(:member) } 
    let(:mail) { RegistrationMailer.with(person_id: person.id).welcome_email.deliver_now }
    let(:url) {'http://example.com/login' }

    it 'renders the subject' do
      expect(mail.subject).to eql('Welcome to My Awesome Site')
      expect(mail.to).to eql([person.email])
      expect(mail.from).to eql(['notifications@example.com'])
    end
  end
end
