class Api::V1::EndorsementSearchController< ApplicationController

    def index
        data = EndorsementSearchService.search(for_user,search_params[:topic], search_params[:hops] )
        render json: data
    end
     

    def search_params
        params.permit(:topic,:hops,:user_id)
      end
end
