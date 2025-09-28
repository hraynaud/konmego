class PersonSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attribute :first_name do |person, params|
    can_show?(params[:current_user], person, params) ? person.first_name : 'Hidden'
  end

  attribute :last_name do |person, params|
    can_show?(params[:current_user], person, params) ? person.last_name : 'Hidden'
  end

  attribute :bio do |person, params|
    can_show?(params[:current_user], person, params) ? person.bio : 'This users Bio is private'
  end

  attribute :avatar_url do |person, params|
    can_show?(params[:current_user], person, params) ? person.avatar_url : 'anonymous.png'
  end

  attribute :profile_image_url do |person, params|
    can_show?(params[:current_user], person, params) ? person.profile_image_url : 'anonymous.png'
  end

  attribute :smart_about do |person, params|
    can_show?(params[:current_user], person, params) ? person.smart_about : []
  end

  attribute :endorsees do |person, params|
    resolve_endorsement_actors(person, person.outgoing_endorsements, params, 'endorsees')
  end

  attribute :endorsers do |person, params|
    resolve_endorsement_actors(person, person.incoming_endorsements, params, 'endorsers')
  end

  attribute :promoted_projects do |person, params|
    ProjectSerializer.new(person.promoted_projects, params:)
  end

  attribute :projects do |person, params|
    ProjectSerializer.new(person.projects, params:)
  end

  class << self
    def can_show?(current_user, contact, params = nil)
      if current_user
        return true if current_user == contact

        # Use preloaded contact IDs to avoid N+1 queries
        if params && params[:current_user_contact_ids]
          params[:current_user_contact_ids].include?(contact.id)
        else
          # Fallback to original method (this should rarely be called now)
          current_user.friends_with?(contact)
        end
      else
        false
      end
    end

    def resolve_endorsement_actors(person, data, params, type)
      if can_show?(params[:current_user],
                   person, params) && !data.empty?
        if params[:current_user] == person
          get_data(data, type, params)
        else
          get_data(data.accepted, type, params)
        end
      else
        []
      end
    end

    def get_data(group, dir, params)
      serializer = EndorsementSerializer.new(group, params:)
      serialized_result = serializer.serializable_hash
      serialized_result[:data].map do |d|
        attrs = filter_out_current_user(d, params, dir)
        d.slice(:id).merge(attrs)
      end
    end

    def filter_out_current_user(d, params, dir)
      if dir == 'endorsers'
        do_filter params[:current_user], d, %i[endorseeAvatarUrl endorseeName endorseeId]
      else
        do_filter params[:current_user], d, %i[endorserAvatarUrl endorserName endorserId]
      end
    end

    def do_filter(is_current_user, d, fields)
      is_current_user ? d[:attributes].except(*fields) : d[:attributes]
    end
  end
end
