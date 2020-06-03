module Obfuscation
  class EndorsementObfuscator < Obfuscator

   class << self
     def obfuscate user, endorsement
       if friends_with_both? user, endorsee, endorser
         do_partial endorsement
       else
         do_total endorsement
       end
     end

     def do_partial endorsement
       Endorsement::Extract.new(endorser: endorsement.endorser, endorsee: endorsement.endorsee, description:endorsement.description)
     end

     def do_total endorsement
       Endorsement::Extract.new(endorser: endorsement.endorser, endorsee: endorsement.endorsee, description: HIDDEN)
     end
   end

   def friends_with_both? user, endorsee, endorser
     user.friends_with? endorsee and user.friends_with? endorser 
   end
  end
end
