class EndorsementSerializer
  include ::JSONAPI::Serializer
  set_key_transform :camel_lower
   attributes :topic do |endorsement, _params|
    endorsement.topic.name
   end
  attribute :direction, if: proc { |_o, params|
                              params && params[:ref_user]
                            } do |o, params|
    o.direction_from_person(params[:ref_user])
  end

  attribute :endorsee_id do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee) ? endorsement.endorsee_id : 'Anonymous'
  end

  attribute :endorser_name do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorser) ? endorsement.endorser.name : 'Anonymous'
  end

  attribute :endorsee_name do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee) ? endorsement.endorsee.name : 'Anonymous'
  end

  attribute :endorser_avatar_url do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorser) ? endorsement.endorser.avatar_url : 'anonymous.png'
  end

  attribute :endorsee_avatar_url do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee) ? endorsement.endorsee.avatar_url : 'anonymous.png'
  end

  attribute :description do |endorsement, params|
    if can_show?(params[:current_user],
                 endorsement.endorsee) && can_show?(params[:current_user], endorsement.endorser)
      endorsement.description
    elsif can_show?(params[:current_user], endorsement.endorsee)
      "Someone has endorsed #{endorsement.endorsee.first_name} for #{endorsement.topic.name}"
    elsif can_show?(params[:current_user], endorsement.endorser)
      "#{endorsement.endorser.name} has endorsed someone for #{endorsement.topic.name}"
    else
      ''
    end
  end

  class << self
    private

    def can_show?(current_user, contact)
      if current_user
        true if current_user.friends_with?(contact) or current_user == contact

      else
        false
      end
    end
  end
end
