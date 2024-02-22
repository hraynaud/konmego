class EndorsementSerializer
  include ::JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :description, :status, :topic_id, :topic, :topic_image

  # attributes :description, :status, :topic_image, :endorser_avatar_url, :endorsee_avatar_url,:topic_id

  # attribute :direction, if: Proc.new {|o, params|
  #   params && params[:ref_user]} do |o, params|
  #     o.direction_from_person(params[:ref_user])
  #   end

  attribute :endorsee_id do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee) ? endorsement.endorsee_id : 'Anonymous'
  end

  attribute :endorser_name do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorser) ? endorsement.endorser_name : 'Anonymous'
  end

  attribute :endorsee_name do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee) ? endorsement.endorsee_name : 'Anonymous'
  end

  attribute :endorser_avatar_url do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorser) ? endorsement.endorser_avatar_url : 'anonymous.png'
  end

  attribute :endorsee_avatar_url do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee) ? endorsement.endorsee_avatar_url : 'anonymous.png'
  end

  attribute :description do |endorsement, params|
    if can_show?(params[:current_user],
                 endorsement.endorsee) && can_show?(params[:current_user], endorsement.endorser)
      endorsement.description
    elsif can_show?(params[:current_user], endorsement.endorsee)
      "Someone has endorsed #{endorsement.endorsee.first_name} for #{endorsement.topic}"
    elsif can_show?(params[:current_user], endorsement.endorser)
      "#{endorsement.endorser.name} has endorsed somonee for #{endorsement.topic}"
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
