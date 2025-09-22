class ProjectSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :name, :description, :status, :topic_name, :topic_image, :hero_image_url, :progress, :open_items,
             :roadblocks, :tasks, :visibility

  attribute :owner_avatar_url do |p, params|
    # Handle case where owner might be nil
    if p.owner && can_show?(params[:current_user], p.owner, params)
      p.owner.avatar_url
    else
      'anonymous.png'
    end
  end

  attribute :owner_id do |p, params|
    if p.owner && can_show?(params[:current_user], p.owner, params)
      p.owner.id
    else
      'anonymous'
    end
  end

  attribute :owner_first_name do |p, params|
    if p.owner && can_show?(params[:current_user], p.owner, params)
      p.owner.first_name
    else
      'Anonymous'
    end
  end

  attribute :owner_last_name do |p, params|
    if p.owner && can_show?(params[:current_user], p.owner, params)
      p.owner.last_name
    else
      'User'
    end
  end

  attribute :owner_profile_image_url do |p, params|
    if p.owner && can_show?(params[:current_user], p.owner, params)
      p.owner.profile_image_url
    else
      'anonymous.png'
    end
  end

  class << self
    def can_show?(current_user, contact, params = nil)
      # Handle nil contact
      return false unless contact

      if current_user
        return true if current_user == contact

        # Use preloaded contact IDs to avoid N+1 queries
        if params && params[:current_user_contact_ids]
          params[:current_user_contact_ids].include?(contact.id)
        else
          current_user.friends_with?(contact)
        end
      else
        false
      end
    end
  end
end
