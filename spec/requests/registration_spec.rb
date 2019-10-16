require "rails_helper"
include TestDataHelper::Utils

describe "Signup and registration" do
  before do
    clear_db
  end

  it "creates  registration" do
    expect{post "/register", params: build_params}
      .to change{Person.count}.by(1)
  end


  it "fails on missing email" do
    post "/register", params: build_invalid_params(:email_nil)

    aggregate_failures "testing response" do
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.headers["X-Message"]).to eq "[\"Email can't be blank\"]"
      expect(Person.count).to eq(0)
    end

  end

  it "fails on duplicate email" do
    p = FactoryBot.create(:person)

    post "/register", params: build_params.merge(person: {email: p.email})

    aggregate_failures "testing response" do
      expect(response).to have_http_status(:unprocessable_entity)
      expect( extract_errors).to match (/#{I18n.t('errors.attributes.email.taken')}/)
      expect(Person.count).to eq(1)
    end
  end


  it "fails when email is invalid" do
    post "/register",  params: build_invalid_params(:email_invalid)
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "fails when password is invalid" do
    post "/register",  params: build_invalid_params(:password_too_short)
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "fails when password is nil" do
    post "/register",  params: build_invalid_params(:password_nil)
    expect(response).to have_http_status(:unprocessable_entity)
  end

  def build_params
    {person: FactoryBot.attributes_for(:person)}
  end

  def build_invalid_params err
    {person: FactoryBot.attributes_for(:person, err)}
  end

  def extract_errors
    errors = JSON.parse(response.headers["X-Message"])
    errors.join(",")
  end
end
