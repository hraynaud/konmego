module Api
  module V1
    class ProjectSearchController < ApplicationController
      def index
        projects = search_results
        # Cache associations
        cache_project_associations(projects)
        # Get current user's contact IDs for permission checks in serializer
        current_user_contact_ids = current_user&.contacts&.pluck(:id) || []

        options = {
          params: {
            current_user: current_user,
            current_user_contact_ids: current_user_contact_ids
          }
        }

        render json: ProjectSerializer.new(projects, options).serializable_hash.to_json
      end

      def random
        projects = ProjectSearchService.random
        # Cache associations for random projects too
        cache_project_associations(projects)

        current_user_contact_ids = current_user&.contacts&.pluck(:id) || []

        options = {
          params: {
            current_user: current_user,
            current_user_contact_ids: current_user_contact_ids
          }
        }

        render json: ProjectSerializer.new(projects, options).serializable_hash.to_json
      end

      private

      def cache_project_associations(projects)
        Rails.logger.info "=== CACHING #{projects.size} PROJECT ASSOCIATIONS ==="

        projects.each_with_index do |project, index|
          Rails.logger.info "=== Caching project #{index + 1}: #{project.id} ==="

          # Load the associations
          project.topic
          project.owner

        end

        Rails.logger.info '=== DONE CACHING ASSOCIATIONS ==='
      end

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
