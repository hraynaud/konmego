# AI Providers Documentation

This application now supports multiple AI providers, allowing you to switch between self-hosted LLMs (Ollama), OpenAI, and Google Gemini.

## Supported Providers

### 1. Ollama (Self-hosted LLMs)
- **Use case**: When you want to run LLMs locally or on your own infrastructure
- **Models**: Any model supported by Ollama (llama3, mistral, codellama, etc.)
- **Features**: Full support for embeddings, completions, and chat
- **Cost**: Free (only infrastructure costs)

### 2. OpenAI
- **Use case**: When you need high-quality, reliable AI services
- **Models**: GPT-4, GPT-3.5-turbo, text-embedding-3-small, etc.
- **Features**: Full support for embeddings, completions, and chat
- **Cost**: Pay-per-token

### 3. Google Gemini
- **Use case**: When you prefer Google's AI services
- **Models**: Gemini 1.5 Pro, Gemini 1.0 Pro, etc.
- **Features**: Completions and chat (no embedding support)
- **Cost**: Pay-per-token

## Configuration

### Environment Variables

Set the following environment variables to configure your preferred provider:

```bash
# Choose your AI provider
AI_PROVIDER=ollama  # or 'openai' or 'gemini'

# Ollama Configuration
OLLAMA_SERVER_ADDRESS=http://ollama:11434
EMBEDDING_MODEL=mxbai-embed-large
LLM=llama3

# OpenAI Configuration
OPENAI_API_KEY=your_api_key_here
OPENAI_URI_BASE=https://api.openai.com/
OPENAI_EMBEDDING_MODEL=text-embedding-3-small
OPENAI_LLM=gpt-4

# Gemini Configuration
GEMINI_API_KEY=your_api_key_here
GEMINI_LLM=gemini-1.5-pro
```

## Usage

### Basic Usage

The `AiService` module provides a unified interface:

```ruby
# Get embeddings
embeddings = AiService.embedding("Your text here")

# Get completions
response = AiService.completion("Your prompt here")

# Chat
messages = [{ role: 'user', content: 'Hello!' }]
chat_response = AiService.chat(messages)

# Parse completions
parsed = AiService.parse_completion(response)
```

### Provider-Specific Usage

You can also use providers directly:

```ruby
# Use Ollama
embeddings = OllamaService.embedding("Your text here")

# Use OpenAI
embeddings = OpenaiProvider.embedding("Your text here")

# Use Gemini
response = GeminiProvider.completion("Your prompt here")
```

### Dynamic Provider Switching

```ruby
# Switch to OpenAI
AiService.switch_provider('openai')

# Check current provider
current = AiService.current_provider # => 'openai'

# Switch back to Ollama
AiService.switch_provider('ollama')
```

### Using the Factory

```ruby
# Get a specific provider
provider = AiStackFactory.create_ai_stack('openai')

# Use the provider
response = provider.completion("Your prompt here")
```

## Migration from Old Code

If you were using `OllamaService` directly, you can now use `AiService` instead:

```ruby
# Old way
embeddings = OllamaService.embedding("text")

# New way (same interface, but can switch providers)
embeddings = AiService.embedding("text")
```

## Important Notes

1. **Gemini Embeddings**: Gemini doesn't support embeddings directly. If you need embeddings and are using Gemini, consider using OpenAI or Ollama for embeddings while using Gemini for completions.

2. **Model Compatibility**: Different providers support different models. Make sure to use appropriate model names for each provider.

3. **API Keys**: Keep your API keys secure and never commit them to version control.

4. **Fallback**: If no provider is specified, the system defaults to Ollama.

## Error Handling

The system includes proper error handling for each provider:

```ruby
begin
  response = AiService.completion("Your prompt")
rescue => e
  Rails.logger.error "AI Service error: #{e.message}"
  # Handle error appropriately
end
```
