class TopicSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :neo_id, :name 
end
