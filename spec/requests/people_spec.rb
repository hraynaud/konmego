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

      do_get @tisha, "/api/v1/friends"

      results = parse_body(response)["data"]

      aggregate_failures "testing friends" do
        expect_http response, :ok
        expect(results.size).to eq @tisha.contacts.size
        expect(result_contact_names(results)).to eq expected_friends(@tisha.contacts)
      end
    end

  end

  def result_contact_names contacts
    contacts.map do |p|
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
