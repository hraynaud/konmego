class PersonSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower
  attributes :id, :first_name, :last_name, :name, :bio, :avatar_url, :profile_image_url
  
  attribute :endorsees do |p, params|
    get_data(p.endorsees, "endorsees",params)
  end

  attribute :endorsers do |p, params|
    get_data(p.endorsers, "endorsers",params)
  end


  class << self 
    def get_data(group,dir,params) 
  
      relationships = group.each_rel{|r|}
      serializer = EndorsementSerializer.new(relationships,params: params)
      serialized_result = serializer.serializable_hash 

      serialized_result[:data].map{|d| 
 
        attrs = filter_out_current_user(d, params, dir)
        d.slice(:id).merge(attrs)
        
      }
      
    end

    def filter_out_current_user d, params, dir
      if(dir=="endorsers")
        do_filter params[:current_user], d,[:endorseeAvatarUrl,:endorseeName,:endorseeId] 
      else
        do_filter params[:current_user], d, [:endorserAvatarUrl,:endorserName,:endorserId]
      end
    end

    def do_filter is_current_user, d, fields
      is_current_user ? d[:attributes].except(*fields) : d[:attributes]
    end
  end
end
