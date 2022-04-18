class ProjectSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :name, :description, :status, :topic_name
  attribute :obstacles
end
