module Api
  module V1
    class EndorsementSearchController < ApplicationController
      def index
        opts = search_params.slice(:hops, :topic, :query, :tolerance)
        user = for_user
        graph = EndorsementSearchService.search(user, opts)
        data = EndorsementGraphProcessor.process(user, graph)
        options = { params: { current_user: } }

        result = EndorsementPathSerializer.new(data, options).serializable_hash
        result[:data] = result[:data].to_set

        render json: result.to_json
      end

      def search_params
        params.permit(:topic, :hops, :query, :tolerance, :user_id)
      end
    end
  end
end
