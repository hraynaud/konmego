module Obfuscation
  class EndorsementObfuscator < Obfuscator

    WrappedEndorsement = Struct.new(:endorser, :endorsee, :description, keyword_init: true) do
      def name 
        "#{first_name} #{last_name}"
      end
    end

   class << self
     def self.obfuscate endorsement

     end

     def do_partial endorsement
       WrappedEndorsement.new(endorser: endorsement.endorser, endorsee: endorsement.endorsee, description:endorsement.description)
     end

     def do_total endorsement
       WrappedEndorsement.new(endorser: endorsement.endorser, endorsee: endorsement.endorsee, description: HIDDEN)
     end
   end

    def friends_with_both? 
      @user.friends_with? @endorsee and @user.friends_with? @endorser 
    end
  end
end
