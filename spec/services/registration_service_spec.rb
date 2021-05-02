require 'set'
require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

describe RegistrationService do

  before do
    Person.delete_all
    Identity.delete_all
  end

  describe "create" do
    context "successful" do
      it "creates new identity" do
        expect{
          RegistrationService.create(
            {first_name: "firstyFirst", last_name: "Lastylast", email: "meellyMel@mail.com", password: "wordyword999"}
          ).to change{Identity.count}.by(1).and change{Person.count}.by(0)
        }
      end

      it "generates confirmation code" do
        reg =  RegistrationService.create(
          {first_name: "firstyFirst", last_name: "Lastylast", email: "meellyMel@mail.com", password: "wordyword999"}
        )
        expect(reg.reg_code).to(be_present)
        expect(reg.status).to eq("pending")
        expect(reg.reg_code_expiration.to_i).to be(1.day.from_now.to_i)
      end
    end
  end

  describe "confirm" do
    context "successful" do
      before do
        @reg = FactoryBot.create(:registration)
      end
      it "updates identity to confirmed status" do
        RegistrationService.confirm(@reg)
        expect(@reg.status).to eq("confirmed")
      end

    end
  end

end
