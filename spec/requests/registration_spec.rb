require "rails_helper"
include TestDataHelper::Utils

describe "Signup and registration" do
  before do
    clear_db
  end

  describe "create" do
    it "creates  registration" do
      expect{
        post "/register", params: person_params
      }.to change{Registration.count}.by(1)
        .and change{Identity.count}.by(1)
    end

    it "sends email" do
      post "/register",  params: person_params
      expect {RegistrationMailer.with(id: Registration.last.id).confirm_email.deliver_later}.to have_enqueued_mail(RegistrationMailer, :confirm_email)
        .with(params: {id: Registration.last.id}, args:[])
    end

    it "fails on missing email" do
      post "/register", params: build_invalid_params({email:nil})
      aggregate_failures "missing email" do
        expect_error_response_and_person_not_created
        expect(extract_errors).to match i18n_attributes_error('email.required')
      end

    end


    it "fails on missing first name " do
      post "/register", params: build_invalid_params({firstName:nil, lastName: "Doe"})
      aggregate_failures "missing first_name" do
        expect_error_response_and_person_not_created
        expect(extract_errors).to match i18n_attributes_error('first_name.required')
      end
    end

    it "fails on missing last name" do
      post "/register", params: build_invalid_params({firstName:nil, lastName: nil})
      aggregate_failures "missing last_name" do
        expect_error_response_and_person_not_created
        expect(extract_errors).to match i18n_attributes_error('last_name.required')
      end
    end

    it "fails on duplicate email" do
      i = FactoryBot.create(:identity)

      post "/register", params: build_invalid_params({email: i.email})

      aggregate_failures "testing response" do
        expect_http response, :unprocessable_entity
        expect(Identity.count).to eq(1)
      end
    end


    it "fails when email is invalid" do
      post "/register",  params: build_invalid_params({email: "a@.com"})
      aggregate_failures "testing response" do
        expect( extract_errors).to match i18n_attributes_error('email.invalid')
      end
    end

    it "fails when password is invalid" do
      post "/register",  params: build_invalid_params({password: "2shorty"})
      aggregate_failures "testing response" do
        expect_error_response_and_person_not_created
        expect(extract_errors).to match i18n_attributes_error('password.too_short.other', count: 8)
      end
    end

    it "fails when password is nil" do
      aggregate_failures "testing response" do
        post "/register",  params: build_invalid_params({password: nil})
        expect_error_response_and_person_not_created
        expect(extract_errors).to match i18n_attributes_error('password.required')
      end
    end

  end 


  describe "confirm" do
    let(:reg){FactoryBot.create(:registration)}
    let(:identity){FactoryBot.build(:identity)} #NOTE avoid hard coding the test pwd grabit from a new identity instance since it converted to a digest after sace by has_secure_password.

    it "confirms registration" do
      post "/confirm", params:{id: reg.id, password: identity.password, code: reg.reg_code}
      expect(reg.reload.status).to eq("confirmed")
      expect(Identity.count).to eq(1)
      expect(Person.count).to eq(1)
    end

    it "fails on invalid code" do
      post "/confirm", params:{id: reg.id, password: identity.password, code: '123456'}
      expect_http response, :unprocessable_entity
      expect(Person.count).to eq(0)
      expect(reg.status).to eq("pending")
    end

    it "fails on invalid password" do
      post "/confirm", params:{id: reg.id, password: "   ", code: reg.reg_code}
      expect_http response, :unprocessable_entity
      expect(Person.count).to eq(0)
      expect(reg.status).to eq("pending")
    end
  end

  def build_invalid_params err
    person_params.merge(err)
  end

  def expect_error_response_and_person_not_created
    expect_http response, :unprocessable_entity
    expect(Person.count).to eq(0)
    expect(Identity.count).to eq(0)
  end

  def person_params
    {
      email: "blah@zay.com", 
      password: "passwordyword",
      confirmPassword: "passwordyword",
      firstName: "Someone", 
      lastName: "Special"
    }
  end

end
