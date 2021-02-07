class ProjectSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :name, :description, :status, :topic_name
  #has_one :topic
end
