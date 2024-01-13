class EndorsementPathSerializer
  include ::JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :topic, :path

  attribute :endorser_name do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorser) ? endorsement.endorser.name : 'Anonymous'
  end

  attribute :endorsee_name do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee) ? endorsement.endorsee.name : 'Anonymous'
  end

  attribute :endorser_profile_image_url do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorser) ? endorsement.endorser.profile_image_url : 'anonymous.png'
  end

  attribute :endorsee_profile_image_url do |endorsement, params|
    can_show?(params[:current_user], endorsement.endorsee) ? endorsement.endorsee.profile_image_url : 'anonymous.png'
  end

  # attribute :description do |endorsement, params|
  #   if can_show?(params[:current_user],
  #                endorsement.endorsee)
  #     endorsement.description
  #   else
  #     "This person in your network has been endorsed for their knowledge of #{endorsement.topic} by someone in your immediate network. You cannot access any details about this endorsement until you are connected to this person directly"
  #   end
  # end

  attribute :description do |endorsement, params|
    if can_show?(params[:current_user],
                 endorsement.endorsee) && can_show?(params[:current_user], endorsement.endorser)
      endorsement.description
    elsif can_show?(params[:current_user], endorsement.endorsee)
      "Someone has endorsed #{endorsement.endorsee.first_name} for #{endorsement.topic}"
    elsif can_show?(params[:current_user], endorsement.endorser)
      "#{endorsement.endorser.name} has endorsed somonee for #{endorsement.topic}"
    else
      "You are closely connected to somone who has been endorsed for knowledge of #{endorsement.topic}"
    end
  end

  attribute :endorser_id do |endorsement, _params|
    endorsement.endorser.id
  end

  attribute :endorsee_id do |endorsement, _params|
    endorsement.endorsee.id
  end

  class << self
    private

    def can_show?(current_user, contact)
      if current_user
        true if current_user.friends_with?(contact) || (current_user == contact)
      else
        false
      end
    end
  end
end
