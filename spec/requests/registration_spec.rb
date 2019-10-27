require "rails_helper"
include TestDataHelper::Utils

describe "Signup and registration" do
  before do
    clear_db
  end

  it "creates  registration" do
    expect{post "/register", params: person_params}
      .to change{Person.count}.by(1)
  end


  it "fails on missing email" do
    post "/register", params: build_invalid_params({email:nil})

    aggregate_failures "testing response" do
      expect_error_response_and_person_created
      expect(extract_errors).to match /#{I18n.t('errors.attributes.email.required')}/
    end

  end

  it "fails on duplicate email" do
    p = FactoryBot.create(:person)

    post "/register", params: build_invalid_params({email: p.email})

    aggregate_failures "testing response" do
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Person.count).to eq(1)
    end
  end


  it "fails when email is invalid" do
    post "/register",  params: build_invalid_params({email: "a@.com"})
    aggregate_failures "testing response" do
      expect( extract_errors).to match /#{I18n.t('errors.attributes.email.invalid')}/
    end
  end

  it "fails when password is invalid" do
    post "/register",  params: build_invalid_params({password: "2shorty"})
    aggregate_failures "testing response" do
      expect_error_response_and_person_created
      expect( extract_errors).to match /#{I18n.t('errors.attributes.password.too_short.other', count: 8)}/
    end
  end

  it "fails when password is nil" do
    aggregate_failures "testing response" do
      post "/register",  params: build_invalid_params({password: nil})
      expect_error_response_and_person_created
      expect(extract_errors).to match /#{I18n.t('errors.attributes.password.required')}/
    end
  end


  def build_invalid_params err
    person_params.merge(err)
  end

  def expect_error_response_and_person_created
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Person.count).to eq(0)
  end

  def person_params
    {
      email: "blah@zay.com", 
      password: "password", firstName: "Firsty", lastName:"lasty"
    }
  end

end
