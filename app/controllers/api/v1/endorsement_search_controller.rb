module Api
  module V1
    class EndorsementSearchController < ApplicationController
      def index
        graph = EndorsementSearchService.search(for_user, search_params[:topic], search_params[:hops])
        data = EndorsementGraphProcessor.process(for_user, graph)
        options = { params: { current_user: current_user } }
        render json: EndorsementPathSerializer.new(data, options).serializable_hash.to_json
      end

      def search_params
        params.permit(:topic, :hops, :user_id)
      end
    end
  end
end
