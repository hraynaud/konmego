require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Utils
include TestDataHelper::Projects
include TestDataHelper::SampleResults

describe Api::V1::PostsController, type: :request do
  before do
    clear_db
    setup_relationship_data
    setup_projects
  end

  describe 'creating a post: post api/vi/posts' do
    it 'creates a post' do

      do_post @franky, "/api/v1/projects/#{@dj_project_friends.id}/posts", { content: 'This is a post' }

      # results = parse_body(response)["data"]
      aggregate_failures 'testing friends' do
        expect_http response, :ok
        expect_response_and_model_json_to_match response, Post.last

      end
    end
  end

end
