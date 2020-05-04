class ProjectSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :neo_id, :name, :description, :status
  has_one :topic
  options = {}
  options[:include] = [:topic, :'topic.name', :'topic.id']
end
