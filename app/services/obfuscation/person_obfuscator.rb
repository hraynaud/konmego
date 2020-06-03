module Obfuscation
  class PersonObfuscator < Obfuscator

    WrappedPerson = Struct.new(:first_name, :last_name, :avatar_url, :profile_image_url, :role , keyword_init: true) do
      def name 
        "#{first_name} #{last_name}"
      end
    end

    def role person
      case 
      when person == @endorser
        "endorser"
      when person == @endorsee
        "endorsee"
      else
        "contact"
      end
    end

    def self.do_partial node, role
      WrappedPerson.new(first_name: node.first_name, last_name: node.last_name,
                        avatar_url: node.avatar_url, profile_image_url: node.profile_image_url, role: role)
    end

    def self.do_total role
      WrappedPerson.new(first_name: HIDDEN, last_name: HIDDEN, avatar_url: nil, profile_image_url: nil, role: role)
    end

  end
end
