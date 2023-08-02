class EndorsementPath
    attr_reader :id, :topic, :path
    
    def initialize topic, path
        @id = SecureRandom.hex(2)
        @topic = topic
        @path = path
    end
end