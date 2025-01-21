FROM ruby:3.1.2
WORKDIR /rails-app
COPY ./rails-app /rails-app
COPY .env.docker-local /rails-app/.env
RUN apt-get update && apt-get install -y python3 python3-dev
RUN apt-get update && apt-get install -y openjdk-17-jdk && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64
ENV PATH=$JAVA_HOME/bin:$PATH
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
EXPOSE 3000 
EXPOSE 7474     
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
RUN gem install bundler -v '2.3.16'
RUN bundle install
CMD ["rails", "server", "-b", "0.0.0.0"]