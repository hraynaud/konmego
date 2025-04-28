FROM ollama/ollama:latest
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
EXPOSE 11434
COPY init-ollama.sh /init-ollama.sh
RUN chmod +x /init-ollama.sh
ENTRYPOINT ["/init-ollama.sh"]
CMD []