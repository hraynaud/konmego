class ProjectSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :name, :description, :status, :topic_name, :topic_image, :hero_image_url, :open_items, :roadblocks
  attribute :owner_avatar_url do |p, _params|
    p.owner.avatar_url
  end
  attribute :owner_profile_image_url do |p, _params|
    p.owner.profile_image_url
  end
end
