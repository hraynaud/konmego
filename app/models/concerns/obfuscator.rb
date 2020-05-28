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
          return ObfuscatedEndorsement.new(node, @user)
        end
      end
    end

    def friends_with_both? endorsement
     @user.friends_with? endorsement.endorsee and @user.friends_with? endorsement.endorser 
    end

  class ObfuscatedPerson
    delegate_missing_to :@person

     HIDDEN = "Hidden"

     def initialize person
      @person  = person
     end

     def first_name
        HIDDEN 
     end

     def last_name
        HIDDEN 
     end

     def name
       "#{first_name} #{last_name}"
     end

     def email
       HIDDEN
     end

     def == other
       other.uuid == @person.uuid
     end
  end


  class ObfuscatedEndorsement

    delegate_missing_to :@endorsement

    attr_reader :endorser, :endorsee

    def initialize(endorsement, user)
      @endorsement = endorsement
      @user = user
      @endorser = @endorsement.endorser
      @endorsee = @endorsement.endorsee
      set_people_nodes
    end

    def set_people_nodes
      if !@user.friends_with? @endorser
        @endorser = ObfuscatedPerson.new(@endorser)
      end

      if !@user.friends_with? @endorsement.endorsee
        @endorsee = ObfuscatedPerson.new(@endorsee)
      end

      def description
        "#{@endorser.name} endorses #{@endorsee.name} for #{@endorsement.topic_name}"
      end

      def == other
        other.uuid == @person.uuid
      end

    end

  end
end
