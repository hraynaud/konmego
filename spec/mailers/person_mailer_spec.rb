require "rails_helper"
require 'spec_helper'
include TestDataHelper::Utils

RSpec.describe PersonMailer, type: :mailer do
  before do 
    clear_db
  end

  describe 'welcome_email' do
    let(:person) { FactoryBot.create(:member) } 
    let(:mail) { PersonMailer.with(person_id: person.id).welcome_email.deliver_now }
    let(:url) {'http://example.com/login' }

    it 'renders the subject' do
      expect(mail.subject).to eql('Welcome to My Awesome Site')
      expect(mail.to).to eql([person.email])
      expect(mail.from).to eql(['notifications@example.com'])
    end
  end
end
