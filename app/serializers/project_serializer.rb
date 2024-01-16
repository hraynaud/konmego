class ProjectSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :name, :description, :status, :topic_name, :topic_image, :hero_image_url
  attribute :owner_avatar_url do |o, _params|
    o.owner.avatar_url
  end
  attribute :obstacles
end
