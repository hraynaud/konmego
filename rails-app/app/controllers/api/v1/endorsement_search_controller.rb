module Api
  module V1
    class EndorsementSearchController < ApplicationController
      def index
        user = for_user
        if search_params[:project_id]
          project = Project.find(params[:project_id])
          graph = EndorsementSearchService.by_project(user, project, **search_params.to_h)
        else
          graph = EndorsementSearchService.search(user, **search_params.to_h)
        end

        data = EndorsementGraphProcessor.process(user, graph)

        result = EndorsementPathSerializer.new(data, { params: { current_user: } }).serializable_hash
        result[:data] = result[:data].to_set
        render json: result.to_json
      end

      def search_params
        params.permit(:user_id, :query, :topic_name, :topic_id, :hops, :tolerance, :page, :project_id)
      end

      def find_topic(name)
        TopicService.find_or_create(name)
      end
    end
  end
end
