module Api
  module V1
    class UserRelationshipsController < ApplicationController
      def index
        options = { params: { current_user: current_user } }
        render json: PersonSerializer.new(group, options).serializable_hash.to_json
      end

      private

      def group
        current_user.send(params[:group].to_sym)
      end

      def person_params
        params.permit(
          :group
        )
      end
    end
  end
end
