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
      @path =  process_path full_path
      @obfuscated_endorsement = EndorsementObfuscator.do_partial(@endorsement)
    end

    private

    def process_path path
      path.map do |node|
        handle_person(node)
      end
    end

    def handle_person node
      role = get_role(node) 

      if is_current_user? node
        return PersonObfuscator.do_partial node,role
      else
        return handle_non_current_user node, role
      end
    end

    def is_current_user? node
      node === @user
    end

    def handle_non_current_user node, role
      return @user.friends_with?(node) ? PersonObfuscator.do_partial(node,role) : PersonObfuscator.do_total(role)
    end

    def get_role person
      case 
      when person == @endorser
        "endorser"
      when person == @endorsee
        "endorsee"
      else
        "contact"
      end
    end


  end
end
