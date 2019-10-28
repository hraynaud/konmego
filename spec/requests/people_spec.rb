require "rails_helper"
include TestDataHelper::Relationships
include TestDataHelper::Utils
include TestDataHelper::SampleResults

describe Api::V1::PeopleController do
  before do 
    clear_db
    setup_relationship_data
  end


  describe "/friends" do 
    it "finds friends" do

      get "/api/v1/friends", headers:{'Authorization': Authentication.jwt_for(@tisha)}

      data = parse_body(response)["data"]

      aggregate_failures "testing friends" do
        expect(response).to have_http_status :ok
        expect(data.size).to eq @tisha.contacts.size
        expect(result_contact_names(data)).to eq expected_friends(@tisha.contacts)
      end
    end

  end

  def result_contact_names data
    data.map do |p|
      full_name p
    end.to_set
  end

  def expected_friends contacts
    contacts.map{|c| c.name}.to_set
  end

  def full_name p
    "#{p['attributes']['firstName']} #{p['attributes']['lastName']}"
  end
end
