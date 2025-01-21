class EndorsementPathSerializer
  include ::JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :path

  attributes :topic do |endorsement, _params|
    endorsement.topic.name
  end
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

  attribute :description do |endorsement, params|
    if can_show?(params[:current_user],
                 endorsement.endorsee) && can_show?(params[:current_user], endorsement.endorser)
      endorsement.description
    elsif can_show?(params[:current_user], endorsement.endorsee)
      "Someone has endorsed #{endorsement.endorsee.first_name} for #{endorsement.topic.name}"
    elsif can_show?(params[:current_user], endorsement.endorser)
      "#{endorsement.endorser.name} has endorsed someone for #{endorsement.topic.name}"
    else
      "You are closely connected to somone who has been endorsed for knowledge of #{endorsement.topic.name}"
    end
  end

  attribute :endorser_id do |endorsement, params|
    endorsement.endorser.id if can_show?(params[:current_user], endorsement.endorser)
  end

  attribute :endorsee_id do |endorsement, params|
    endorsement.endorsee.id if can_show?(params[:current_user], endorsement.endorser)
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
