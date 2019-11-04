class Obfuscator

    def initialize user
      @user = user
    end

    def obfuscate node

      if node.is_a? Person
        if node === @user
          return node
        else
          return @user.friends_with?(node) ? node : ObfuscatedPerson.new(node)
        end
      end

      if node.is_a? Endorsement
        if friends_with_both? node
          return node
        else
          return ObfuscatedEndorsement.new(node, user)
        end
      end
    end

    def friends_with_both? endorsement
     @user.friends_with? node.endorsee and @user.friends_with? node.endorser 
    end

  class ObfuscatedPerson < Person
     delegate_missing_to :@person

     HIDDEN = "hidden"
     def initialize person
      @person  = person
     end

     def first_name
        HIDDEN 
     end

     def last_name
        HIDDEN 
     end

     def last_name
        HIDDEN 
     end

     def email
       HIDDEN
     end

  end


  class ObfuscatedEndorsement < Endorsement
    delegate_missing_to :@endorsement

    def initialize(endorsement, user)
      @endorsement = endorsement

      if !user.friends_with? endorsement.endorser
        endorsement.endorser = ObfuscatedPerson.new(endorsement.endorser)
      end

      if !user.friends_with? endorsement.endorsee
        endorsement.endorsee = ObfuscatedPerson.new(endorsement.endorsee)
      end
    end
  end
end
