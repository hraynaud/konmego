require "rails_helper"
include TestDataHelper::Utils

describe "Signup and registration" do
  after do
    clear_db
  end

  it "creates  registration" do
    expect{post "/register", params: {
      person: {
        first_name: "New", 
        last_name: "Person", 
        email: "new@person.com", 
        password: "testme", 
        password_confirmation: "testme"
      }
    }
    }.to change{Person.count}.by(1)
  end


  it "fails on missing email" do
    post "/register", params: {
      person: {
        first_name: "New", 
        last_name: "Person", 
        password: "testme", 
        password_confirmation: "testme"
      }
    }

    aggregate_failures "testing response" do
      expect(response.status).to eq 422
      expect(response.headers["X-Message"]).to eq "Email can't be blank"
      expect(Person.count).to eq(0)
    end

  end

  it "fails on duplicate email" do
    FactoryBot.create(:person, first_name: "New", last_name: "Person", email: "new@person.com")

    post "/register", params: {
      person: {
        first_name: "New", 
        last_name: "Person", 
        email: "new@person.com", 
        password: "testme", 
        password_confirmation: "testme"
      }
    }
    aggregate_failures "testing response" do
      expect(response.status).to eq 422
      expect(response.headers["X-Message"]).to eq "Email has already been taken"
      expect(Person.count).to eq(1)
    end
  end

end
