class PersonMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email 
    @person = Person.find(params[:person_id])
    @url  = 'http://example.com/login'
    mail(to: @person.email, subject: 'Welcome to My Awesome Site')
  end
end
