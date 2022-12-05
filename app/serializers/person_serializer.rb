class PersonSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
 attributes :neo_id, :first_name, :last_name, :bio, :avatar_url, :profile_image_url
 has_many :incoming_endorsements, serializer: :endorsement
 has_many :outgoing_endorsements, serializer: :endorsement
end
