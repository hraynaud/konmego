module Obfuscation
  class EndorsementObfuscator < Obfuscator

    WrappedEndorsement = Struct.new(:endorser, :endorsee,  keyword_init: true) do
      def name 
        "#{first_name} #{last_name}"
      end
    end

   class << self
     def do_partial endorsement
       WrappedEndorsement.new(endorser: endorsement.endorser, endorsee: endorsement.endorsee)
     end

     def do_total endorsement
       WrappedEndorsement.new(endorser: endorsement.endorser, endorsee: endorsement.endorsee)
     end
   end

  end
end
