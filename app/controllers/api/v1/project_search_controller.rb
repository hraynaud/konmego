module Api
  module V1
    class ProjectSearchController < ApplicationController
      def index
        render json: projects
      end

      private

      def projects_and_topics
        projects.merge(friends_and_topics)
      end

      def projects
        {
          projects: ProjectSerializer.new(search_results)
        }
      end

      def search_results
        user_scope = params[:scope] || current_user.uuid
        ProjectSearchService.search(user_scope, topic: filter_params[:topic], friend: filter_params[:friend])
      end

      def friends_and_topics
        {
          friends: PersonSerializer.new(current_user.contacts, { fields: { person: %i[name id avatarUrl] } }),
          topics: TopicSerializer.new(Topic.all)
        }
      end

      def filter_params
        params.permit(:topic, :friend)
      end
    end
  end
end
