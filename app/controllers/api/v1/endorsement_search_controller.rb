class Api::V1::EndorsementSearchController< ApplicationController

    def index
        graph = EndorsementSearchService.search(for_user,search_params[:topic], search_params[:hops] )
        data = EndorsementGraphProcessor.process(for_user, graph)
        render json: EndorsementPathSerializer.new(data).serializable_hash.to_json

    end
     

    def search_params
        params.permit(:topic,:hops,:user_id)
      end
end
