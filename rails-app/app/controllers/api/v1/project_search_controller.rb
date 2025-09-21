module Api
  module V1
    class ProjectSearchController < ApplicationController
      def index
        Rails.logger.info '=== PROJECTS CONTROLLER DEBUG START ==='
        projects = search_results

        Rails.logger.info "=== Found #{projects.size} projects ==="

        # Cache associations
        cache_project_associations(projects)

        # Get current user's contact IDs for permission checks in serializer
        current_user_contact_ids = current_user&.contacts&.pluck(:id) || []
        Rails.logger.info "=== CURRENT USER CONTACT IDS: #{current_user_contact_ids} ==="

        options = {
          params: {
            current_user: current_user,
            current_user_contact_ids: current_user_contact_ids
          }
        }

        Rails.logger.info '=== STARTING SERIALIZATION ==='
        render json: ProjectSerializer.new(projects, options).serializable_hash.to_json
        Rails.logger.info '=== SERIALIZATION COMPLETE ==='
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
        Rails.logger.info '=== CACHING ASSOCIATIONS ==='

        # Get all unique project IDs
        project_ids = projects.map(&:id).uniq
        Rails.logger.info "=== Project IDs: #{project_ids} ==="

        # Pre-fetch all topics and owners in bulk
        topics_by_project = {}
        owners_by_project = {}

        # Fetch all topics at once
        topic_results = ActiveGraph::Base.query(
          "MATCH (p:Project)-[:CONCERNS]->(t:Topic)
           WHERE ID(p) IN $project_ids
           RETURN ID(p) as project_id, t as topic",
          project_ids: project_ids
        )
        Rails.logger.info "=== Topic results count: #{topic_results.count} ==="
        topic_results.each { |row| topics_by_project[row.project_id] = row.topic }

        # Fetch all owners at once
        owner_results = ActiveGraph::Base.query(
          "MATCH (p:Project)<-[:OWNS]-(o:Person)
           WHERE ID(p) IN $project_ids
           RETURN ID(p) as project_id, o as owner",
          project_ids: project_ids
        )
        Rails.logger.info "=== Owner results count: #{owner_results.count} ==="
        owner_results.each { |row| owners_by_project[row.project_id] = row.owner }

        # Override the association methods on each project
        projects.each do |project|
          topic = topics_by_project[project.id]
          owner = owners_by_project[project.id]

          Rails.logger.info "=== Project #{project.id}: topic=#{topic.inspect}, owner=#{owner.inspect} ==="

          project.define_singleton_method(:topic) { topic }
          project.define_singleton_method(:owner) { owner }
        end

        Rails.logger.info '=== ASSOCIATIONS CACHED ==='
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
