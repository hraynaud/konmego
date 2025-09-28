module Api
  module V1
    class PeopleController < ApplicationController
      def create; end

      def show
        p = PersonService.with_associations(params[:id])

        current_user_contact_ids = current_user&.contacts&.pluck(:id) || []
        options = {
          params: {
            current_user: current_user,
            current_user_contact_ids: current_user_contact_ids
          }
        }

        render json: PersonSerializer.new(p, options).serializable_hash.to_json
      end

      def edit; end

      def update; end

      private

      def person_params
        params.permit(
          :id
        )
      end
    end
  end
end
