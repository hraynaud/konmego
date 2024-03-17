module Api
  module V1
    class EndorsementSearchController < ApplicationController
      def index
        user = for_user
        graph = EndorsementSearchService.search(user, search_params, by_vector: true)
        data = EndorsementGraphProcessor.process(user, graph)
        options = { params: { current_user: } }

        result = EndorsementPathSerializer.new(data, options).serializable_hash
        result[:data] = result[:data].to_set

        render json: result.to_json
      end

      def search_params
        params.permit(:topic_id, :topic_name, :hops, :query, :tolerance, :user_id)
      end

      def find_topic(name)
        TopicService.find_or_create(name)
      end
    end
  end
end
