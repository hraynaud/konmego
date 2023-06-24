class PersonSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :id, :first_name, :last_name, :bio, :avatar_url, :profile_image_url
  
  attribute :endorsees do |p, _params|
    get_data(p.endorsees, "out")
  end
  attribute :endorsers do |p, _params|
    get_data(p.endorsers, "in")
  end


  class << self 
    def get_data(group,dir) 
      res = EndorsementSerializer.new(group.each_rel{|r|}).serializable_hash 
      
      res[:data].map{|d| 
        attrs = if(dir=="in")
          d[:attributes]#.except(:endorseeAvatarUrl,:endorseeId, :endorseeName)
        else
          d[:attributes]#.except(:endorserAvatarUrl,:endorserId, :endorserName)
        end
        d.slice(:id).merge(attrs)
      }
      
    end
  end
end
