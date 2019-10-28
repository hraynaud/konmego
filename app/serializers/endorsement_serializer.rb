class EndorsementSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :uuid, :neo_id, :description, :status
end
