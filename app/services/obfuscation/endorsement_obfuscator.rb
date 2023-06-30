module Obfuscation
  class EndorsementObfuscator < Obfuscator

   class << self
     def obfuscate user, path, endorsement
       if friends_with_both? user, endorsement
         endorsement.extract
       else
         do_total endorsement
       end
     end


     def do_total endorsement
       OpenStruct.new(endorser:nil, endorsee: nil, description: nil)
     end

     def friends_with_both? user, endorsement
       user.friends_with? endorsement.endorsee and user.friends_with? endorsement.endorser 
     end
   end

  end
end
