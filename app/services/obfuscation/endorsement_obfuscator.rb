module Obfuscation
  class EndorsementObfuscator < Obfuscator

    WrappedEndorsement = Struct.new(:endorser, :endorsee,  keyword_init: true) do
      def name 
        "#{first_name} #{last_name}"
      end
    end

    def self.do_partial endorsement
      WrappedEndorsement.new(endorser: endorsement.endorser, endorsee: endorsement.endorsee)
    end

  end
end
