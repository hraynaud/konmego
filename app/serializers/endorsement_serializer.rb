class EndorsementSerializer
  include ::JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :description, :status,:topic_id,:topic, :topic_image
 
 
  attribute :endorsee_id do |endorsement, params| 
    can_show?(params[:current_user],endorsement.endorsee) ? endorsement.endorsee_id : "Anonymous"
  end

  attribute :endorser_id do |endorsement, params| 
  
  end

  attribute :endorser_name do |endorsement, params| 
    can_show?(params[:current_user],endorsement.endorser) ? endorsement.endorser_name : "Anonymous"
  end

  attribute :endorsee_name do |endorsement, params| 
    can_show?(params[:current_user],endorsement.endorsee) ? endorsement.endorsee_name : "Anonymous"
  end

  attribute :endorser_avatar_url do |endorsement, params| 
    can_show?(params[:current_user],endorsement.endorser) ? endorsement.endorser_avatar_url : "anonymous.png"
  end

  attribute :endorsee_avatar_url do |endorsement, params| 
    can_show?(params[:current_user],endorsement.endorsee) ? endorsement.endorsee_avatar_url : "anonymous.png"
  end

  class << self
    private

    def can_show? current_user, contact
      if current_user 
        if current_user.friends_with?(contact) or current_user == contact
          true
        end 
      
      else
          false
      end
    end

  end
end
