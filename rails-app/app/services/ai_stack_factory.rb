module AiStackFactory
  def self.create_ai_stack(stack)
    case stack.to_s.downcase
    when 'ollama'
      OllamaService
    when 'openai'
      OpenaiProvider
    when 'gemini'
      GeminiProvider
    else
      # Default to the configured provider in AiService
      AiService.provider
    end
  end

  def self.switch_provider(provider_name)
    AiService.switch_provider(provider_name)
  end

  def self.current_provider
    AiService.current_provider
  end
end
