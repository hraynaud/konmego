class EndorsementPathSerializer
    include ::JSONAPI::Serializer
    set_key_transform :camel_lower
    attributes :topic, :path
 
end 

