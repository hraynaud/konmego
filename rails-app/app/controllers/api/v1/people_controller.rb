module Api
  module V1
    class PeopleController < ApplicationController
      def create; end

      def show
        p = Person.find_by(uuid: params[:id])

        # Pre-load all associations
        p.contacts.to_a
        outgoing_endorsements = p.outgoing_endorsements.to_a
        incoming_endorsements = p.incoming_endorsements.to_a
        p.projects.to_a

        (outgoing_endorsements + incoming_endorsements).each do |endorsement|
          endorsement.topic
          endorsement.endorser
          endorsement.endorsee
        end

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
