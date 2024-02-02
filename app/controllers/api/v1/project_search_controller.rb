module Api
  module V1
    class ProjectSearchController < ApplicationController
      def index
        render json: projects
      end

      def random
        render json: ProjectSerializer.new(ProjectSearchService.random)
      end

      private

      def projects
        {
          projects: ProjectSerializer.new(search_results)
        }
      end

      def search_results
        ProjectSearchService.search(filter_params)
      end

      def filter_params
        params.permit(:topic, :friend, :friend, :visibility, :user_scope, :limit, :random)
      end
    end
  end
end
