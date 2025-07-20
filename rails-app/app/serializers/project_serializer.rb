class ProjectSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :name, :description, :status, :topic_name, :topic_image, :hero_image_url, :progress, :open_items,
             :roadblocks, :tasks, :visibility
  attribute :owner_avatar_url do |p, _params|
    p.owner.avatar_url
  end

  attribute :owner_id do |p, _params|
    p.owner.id
  end

  attribute :owner_first_name do |p, _params|
    p.owner.first_name
  end

  attribute :owner_last_name do |p, _params|
    p.owner.last_name
  end

  attribute :owner_profile_image_url do |p, _params|
    p.owner.profile_image_url
  end
end
