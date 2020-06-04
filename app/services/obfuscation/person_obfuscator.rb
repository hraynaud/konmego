
require 'ostruct'
module Obfuscation
  class PersonObfuscator < Obfuscator

    def self.obfuscate node
       OpenStruct.new(first_name: HIDDEN, last_name: HIDDEN,
                              avatar_url: nil, profile_image_url: nil, name: "#{HIDDEN} #{HIDDEN}")
    end

  end
end
