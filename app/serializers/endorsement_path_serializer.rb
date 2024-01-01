class EndorsementPathSerializer
    include ::JSONAPI::Serializer
    set_key_transform :camel_lower
    attributes :topic, :path

    attribute :endorser_name do |endorsement, params| 
        can_show?(params[:current_user],endorsement.endorser) ? endorsement.endorser.name : "Anonymous"
    end
    
    attribute :endorsee_name do |endorsement, params| 
        can_show?(params[:current_user],endorsement.endorsee) ? endorsement.endorsee.name : "Anonymous"
    end

    attribute :endorser_profile_image_url do |endorsement, params| 
        can_show?(params[:current_user],endorsement.endorser) ? endorsement.endorser.profile_image_url : "anonymous.png"
    end

    attribute :endorsee_profile_image_url do |endorsement, params| 
        can_show?(params[:current_user],endorsement.endorsee) ? endorsement.endorsee.profile_image_url : "anonymous.png"
    end

    attribute :endorser_id do |endorsement, params| 
        endorsement.endorser.id
    end

    attribute :endorsee_id do |endorsement, params| 
        endorsement.endorsee.id
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

