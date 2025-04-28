#!/bin/sh
# init-ollama.sh
set -e

# Start Ollama server in the background
echo "Starting Ollama server..."
ollama serve &
OLLAMA_PID=$!

# Wait for Ollama server to start
echo "Waiting for Ollama server to start..."
sleep 5
while ! curl -s http://localhost:11434/api/version > /dev/null; do
  echo "Waiting for Ollama server to start..."
  sleep 2
done

# Pull required models
echo "Pulling required models..."
ollama pull llama3
ollama pull mxbai-embed-large
# Add any other models you need

# Keep the server running in the foreground
echo "Ollama server is ready!"
wait $OLLAMA_PID