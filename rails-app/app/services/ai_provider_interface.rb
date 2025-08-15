module AiProviderInterface
  def embedding(prompt, model)
    raise NotImplementedError, "#{self.class} must implement embedding method"
  end

  def completion(prompt, model)
    raise NotImplementedError, "#{self.class} must implement completion method"
  end

  def chat(messages, model)
    raise NotImplementedError, "#{self.class} must implement chat method"
  end

  def parse_completion(completion)
    raise NotImplementedError, "#{self.class} must implement parse_completion method"
  end
end
