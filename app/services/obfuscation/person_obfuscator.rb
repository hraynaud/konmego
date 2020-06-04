
require 'ostruct'
module Obfuscation
  class PersonObfuscator < Obfuscator

    def self.obfuscate role
      person = OpenStruct.new(first_name: HIDDEN, last_name: HIDDEN,
                              avatar_url: nil, profile_image_url: nil, name: "#{HIDDEN} #{HIDDEN}")
      person.role = role
      person
    end

  end
end
