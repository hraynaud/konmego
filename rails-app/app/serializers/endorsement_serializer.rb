class EndorsementSerializer
  include ::JSONAPI::Serializer
  set_key_transform :camel_lower
  attribute :status
  attribute :topic do |endorsement, _params|
    endorsement.topic.name
  end

  attribute :direction, if: proc { |_o, params|
                              params && params[:ref_user]
                            } do |o, params|
    o.direction_from_person(params[:ref_user])
  end

  attribute :endorsee_id do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee, params) ? endorsement.endorsee_id : 'Anonymous'
  end

  attribute :endorser_id do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorser, params) ? endorsement.endorser_id : 'Anonymous'
  end

  attribute :endorser_name do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorser, params) ? endorsement.endorser.name : 'Anonymous'
  end

  attribute :endorsee_name do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee, params) ? endorsement.endorsee.name : 'Anonymous'
  end

  attribute :endorser_avatar_url do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorser, params) ? endorsement.endorser.avatar_url : 'anonymous.png'
  end

  attribute :endorsee_avatar_url do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee, params) ? endorsement.endorsee.avatar_url : 'anonymous.png'
  end

  attribute :description do |endorsement, params|
    if can_show?(params[:current_user],
                 endorsement.endorsee, params) && can_show?(params[:current_user], endorsement.endorser, params)
      endorsement.description
    elsif can_show?(params[:current_user], endorsement.endorsee, params)
      "Someone has endorsed #{endorsement.endorsee.first_name} for #{endorsement.topic.name}"
    elsif can_show?(params[:current_user], endorsement.endorser, params)
      "#{endorsement.endorser.name} has endorsed someone for #{endorsement.topic.name}"
    else
      ''
    end
  end

  class << self
    private

    def can_show?(current_user, contact, params = nil)
      if current_user
        return true if current_user == contact

        contact_ids = params&.dig(:current_user_contact_ids)
        # Use preloaded contact IDs to avoid N+1 queries
        if contact_ids
          contact_ids.include?(contact.id)
        else
          current_user.friends_with?(contact)
        end
      else
        false
      end
    end
  end
end
