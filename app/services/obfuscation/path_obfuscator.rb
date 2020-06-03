module Obfuscation
  class PathObfuscator
    attr_reader :path, :obfuscated_endorsement

    def initialize user, path
      @user = user
      @endorser = path.endorser
      @endorsee = path.endorsee
      @endorsement = path.e
      obfuscate path.full_path
    end

    def obfuscate full_path
      @path =  full_path.map do |node|
        for_person(node)
      end
      @obfuscated_endorsement = EndorsementObfuscator.do_partial(@endorsement)
    end

    def for_person node
      if node === @user
        return PersonObfuscator.do_partial(node,role(node))
      else
        return @user.friends_with?(node) ? PersonObfuscator.do_partial(node,role(node)) : PersonObfuscator.do_total(role(node))
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

    def friends_with_both? 
      @user.friends_with? @endorsee and @user.friends_with? @endorser 
    end

  end
end
