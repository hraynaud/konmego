class Obfuscator

    def initialize user, endorser, endorsee
      @user = user
      @endorser = endorser
      @endorsee = endorsee
    end

    def obfuscate node

      if node.is_a? Person
        if node === @user
          return WrappedPerson.new(node, role(node))
        else
          
          return @user.friends_with?(node) ? WrappedPerson.new(node, role(node)) : ObfuscatedPerson.new(node, role(node))
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

    def friends_with_both? endorsement
     @user.friends_with? endorsement.endorsee and @user.friends_with? endorsement.endorser 
    end

  class WrappedPerson
   attr_reader :name, :avatar_url, :profile_image_url, :role
    def initialize person, role="contact"
      @avatar_url  = person.avatar_url
      @profile_image_url  = person.profile_image_url
      @name  = person.name
      @first_name  = person.avatar_url
      @last_name  = person.avatar_url
      @role = role
    end

  end

   
  class ObfuscatedPerson < WrappedPerson

    HIDDEN = "Hidden"

     def first_name
        HIDDEN 
     end

     def last_name
        HIDDEN 
     end

     def email
       HIDDEN
     end

     def avatar_url

     end 

     def profile_image_url

     end

    def name 
      "#{HIDDEN} #{HIDDEN}"
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

    end

  end
end
