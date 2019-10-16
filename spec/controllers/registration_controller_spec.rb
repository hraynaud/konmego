require 'rails_helper'

describe RegistrationController do
  before do
    Person.delete_all
  end

  describe ".create" do
    context "success" do
      let(:params){build_params(:valid)}

      it "creates user and returns ok" do
        post :create,  params: build_params
        expect(response).to have_http_status(:ok)
        expect(Person.count).to eq 1
      end
    end


    context "failures" do

      it "fails when emails is missing" do
        post :create,  params: build_invalid_params(:email_nil)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "fails when email is invalid" do
        post :create,  params: build_invalid_params(:email_invalid)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "fails when password is invalid" do
        post :create,  params: build_invalid_params(:password_too_short)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "fails when password is nil" do
        post :create,  params: build_invalid_params(:password_nil)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "fails when email is not unique" do
        p = FactoryBot.create(:person)
        post :create,  params: build_params.merge(person: {email: p.email})
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

  end

  def build_params
    {person: FactoryBot.attributes_for(:person)}
  end

  def build_invalid_params err
    {person: FactoryBot.attributes_for(:person, err)}
  end

end
