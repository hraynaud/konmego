module Obfuscation
  class PersonObfuscator < Obfuscator

    def self.do_partial node, role
      Person::Extract.new(first_name: node.first_name, last_name: node.last_name,
                        avatar_url: node.avatar_url, profile_image_url: node.profile_image_url, role: role)
    end

    def self.do_total role
      Person::Extract.new(first_name: HIDDEN, last_name: HIDDEN, avatar_url: nil, profile_image_url: nil, role: role)
    end

  end
end
