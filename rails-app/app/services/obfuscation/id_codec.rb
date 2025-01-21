require 'base64'
module Obfuscation::IdCodec
   class << self
    def urlsafe_encode64 raw_id
        Base64.urlsafe_encode64(raw_id)
    end

    def urlsafe_decode64 encoded_id
    Base64.urlsafe_decode64(encoded_id)
    end
    
    def encode(uuid)     
    [uuid.tr('-', '').scan(/../).map(&:hex).pack('c*')].pack('m*').tr('+/', '-_').slice(0..21)                                                   
    end

    def decode(short_id)
    (short_id.tr('-_', '+/') + '==').unpack('m0').first.unpack('H8H4H4H4H12').join('-')                                                                                                                                                                                                                                                           
    end
end
end