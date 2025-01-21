require 'rails_helper'
include TestDataHelper::Relationships
include TestDataHelper::Projects
include TestDataHelper::Utils

describe Api::V1::ProjectsController do
  before do
    setup_relationship_data
    setup_projects
  end

  after do
    clear_db
  end

  describe 'post api/v1/projects_search/:topic' do
    it 'finds friend projects associated with this topic' do

      post '/api/v1/projects_search', params: { topic_id: @cooking.uuid },
                                      headers: { Authorization: Authentication.jwt_for(@herby) }
      expect(response.status).to eq 200

      results = extract_project_names(JSON.parse(response.body))

      expect(results.to_set).to eq(['Chef'].to_set)

    end

    def extract_project_names(results)
      results['projects']['data'].map { |d| d['attributes']['name'] }
    end
  end

end
