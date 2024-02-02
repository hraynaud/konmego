class PersonSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :id, :first_name, :last_name, :name, :bio, :avatar_url, :profile_image_url

  attribute :first_name do |person, params|
    can_show?(params[:current_user], person) ? person.first_name : 'Hidden'
  end

  attribute :last_name do |person, params|
    can_show?(params[:current_user], person) ? person.last_name : 'Hidden'
  end

  attribute :bio do |person, params|
    can_show?(params[:current_user], person) ? person.bio : 'This users Bio is not private'
  end

  attribute :avatar_url do |person, params|
    can_show?(params[:current_user], person) ? person.avatar_url : 'anonymous.png'
  end

  attribute :profile_image_url do |person, params|
    can_show?(params[:current_user], person) ? person.profile_image_url : 'anonymous.png'
  end

  attribute :endorsees do |person, params|
    can_show?(params[:current_user], person) ? get_data(person.endorsees, 'endorsees', params) : []
  end

  attribute :endorsers do |person, params|
    can_show?(params[:current_user], person) ? get_data(person.endorsers, 'endorsers', params) : []
  end

  class << self
    def can_show?(current_user, contact)
      if current_user
        true if current_user.friends_with?(contact) || (current_user == contact)
      else
        false
      end
    end

    def get_data(group, dir, params)
      relationships = group.each_rel { |r| } # rubocop:disable Lint/EmptyBlock
      serializer = EndorsementSerializer.new(relationships, params: params)
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
