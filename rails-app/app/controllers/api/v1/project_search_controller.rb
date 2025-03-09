module Api
  module V1
    class ProjectSearchController < ApplicationController
      def index
        render json: ProjectSerializer.new(search_results)
      end

      def random
        render json: ProjectSerializer.new(ProjectSearchService.random)
      end

      private

      def search_results
        ProjectSearchService.search(filter_params.merge!({ user_scope: current_user.uuid }))
      end

      def filter_params
        project_params = params.fetch(:project, {})
        project_params.permit(:topic_id, :topic, :friend_id, :visibility, :limit, :random)
      end
    end
  end
end
