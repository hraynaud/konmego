class PersonSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :id, :first_name, :last_name, :bio, :avatar_url, :profile_image_url
  
  attribute :endorsees do |p, _params|
    get_data(p.endorsees(:friend,:rel)) #.pluck(:friend,:rel),"out")
  end
  attribute :endorsers do |p, _params|
      get_data(p.endorsers(:friend,:rel)) #.pluck(:friend,:rel),"in")
  end


  class << self 
    def get_data(group) 
 
      group.pluck(:friend, :rel).map do |friend, rel|
        {
          firstName: friend.first_name, 
          lastName: friend.last_name,
          endorserAvatarUrl: friend.avatar_url,
          ndorseeAvatarUrl: rel.from_node.avatar_url,
          endorseeId: rel.to_node.id,
          endorserId: rel.from_node.id,
          topic: rel.topic,
          description: rel.description
        }
      end
      end
  end
end
