class Api::V1::EndorsementSearchController< ApplicationController

    def index
        graph = EndorsementSearchService.search(for_user,search_params[:topic], search_params[:hops] )
        data = EndorsementGraphProcessor.process(for_user, graph)
        render json: data
    end
     

    def search_params
        params.permit(:topic,:hops,:user_id)
      end
end
