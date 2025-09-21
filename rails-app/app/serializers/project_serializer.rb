class ProjectSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :name, :description, :status, :topic_name, :topic_image, :hero_image_url, :progress, :open_items,
             :roadblocks, :tasks, :visibility

  attribute :owner_avatar_url do |p, params|
    Rails.logger.info "=== ACCESSING owner_avatar_url for project #{p.id} ==="
    Rails.logger.info "=== Project owner: #{p.owner.inspect} ==="

    # Handle case where owner might be nil
    if p.owner && can_show?(params[:current_user], p.owner, params)
      p.owner.avatar_url
    else
      'anonymous.png'
    end
  end

  attribute :owner_id do |p, params|
    Rails.logger.info "=== ACCESSING owner_id for project #{p.id} ==="
    Rails.logger.info "=== Project owner: #{p.owner.inspect} ==="

    if p.owner && can_show?(params[:current_user], p.owner, params)
      p.owner.id
    else
      'anonymous'
    end
  end

  attribute :owner_first_name do |p, params|
    Rails.logger.info "=== ACCESSING owner_first_name for project #{p.id} ==="

    if p.owner && can_show?(params[:current_user], p.owner, params)
      p.owner.first_name
    else
      'Anonymous'
    end
  end

  attribute :owner_last_name do |p, params|
    Rails.logger.info "=== ACCESSING owner_last_name for project #{p.id} ==="

    if p.owner && can_show?(params[:current_user], p.owner, params)
      p.owner.last_name
    else
      'User'
    end
  end

  attribute :owner_profile_image_url do |p, params|
    Rails.logger.info "=== ACCESSING owner_profile_image_url for project #{p.id} ==="

    if p.owner && can_show?(params[:current_user], p.owner, params)
      p.owner.profile_image_url
    else
      'anonymous.png'
    end
  end

  class << self
    def can_show?(current_user, contact, params = nil)
      Rails.logger.info "=== PROJECT can_show? DEBUG ==="
      Rails.logger.info "contact: #{contact.inspect}"
      Rails.logger.info "contact_ids present: #{params&.dig(:current_user_contact_ids) ? 'true' : 'false'}"

      # Handle nil contact
      return false unless contact

      if current_user
        return true if current_user == contact

        # Use preloaded contact IDs to avoid N+1 queries
        if params && params[:current_user_contact_ids]
          result = params[:current_user_contact_ids].include?(contact.id)
          Rails.logger.info "using preloaded result: #{result}"
          result
        else
          Rails.logger.warn "=== FALLING BACK TO friends_with? for contact #{contact.id} ==="
          current_user.friends_with?(contact)
        end
      else
        false
      end
    end
  end
end
