require "rails_helper"
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

describe "Send Invite" do
  before do
    create_social_graph
  end

  after do
    clear_db
  end
  describe "create" do
    it "creates  Invite" do
      expect{
        do_post @herby, "/api/v1/invite", invite_params
      }.to change{Invite.count}.by(1)
    end

    it "sends email" do
        do_post @herby, "/api/v1/invite", invite_params
      expect(ActionMailer::Parameterized::DeliveryJob).to have_been_enqueued.with('InviteMailer', 'invite_email', 'deliver_now',{id: Invite.last.id})
    end

   it "sends topic email" do
     params = invite_params
     params[:invite][:topicId]=Topic.first.id
     do_post @herby, "/api/v1/invite", params
      expect(ActionMailer::Parameterized::DeliveryJob).to have_been_enqueued.with('InviteMailer', 'topic_invite_email', 'deliver_now',{id: Invite.last.id})
    end

    it "fails on missing email" do
      do_post @herby, "/api/v1/invite", build_invalid_params({email:nil})
      aggregate_failures "missing email" do
        expect_error_response_and_invite_not_created
        expect(extract_errors).to match i18n_attributes_error('email.required')
      end

    end


    it "fails on missing first name " do
      do_post @herby, "/api/v1/invite",  build_invalid_params({firstName:nil, lastName: "Doe"})
      aggregate_failures "missing first_name" do
        expect_error_response_and_invite_not_created
        expect(extract_errors).to match i18n_attributes_error('first_name.required')
      end
    end

    it "fails on missing last name" do
     do_post @herby,"/api/v1/invite", build_invalid_params({firstName:nil, lastName: nil})
      aggregate_failures "missing last_name" do
        expect_error_response_and_invite_not_created
        expect(extract_errors).to match i18n_attributes_error('last_name.required')
      end
    end

    it "fails when email is invalid" do
      do_post @herby, "/api/v1/invite", build_invalid_params({email: "a@.com"})
      aggregate_failures "testing response" do
        expect( extract_errors).to match i18n_attributes_error('email.invalid')
      end
    end

  end 

  def build_invalid_params err
    invite_params.deep_merge({invite: err})
  end

  def expect_error_response_and_invite_not_created
    expect_http response, :unprocessable_entity
    expect(Invite.count).to eq(0)
  end

  def invite_params
    {
      invite: {
        email: "blah@zay.com",
        firstName: "Someone",
        lastName: "Special",
        topicId: nil
      }
    }
  end

end
