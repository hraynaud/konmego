class TopicSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :neo_id, :name, :default_image_file
end
