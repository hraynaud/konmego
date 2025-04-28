FROM ruby:3.1.2

WORKDIR /rails-app

# Only copy Gemfile and Gemfile.lock first (to install gems early)
COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v '2.3.16'
RUN bundle install

# Now copy the rest of the app code
COPY . ./

# Copy environment config (optional, if you need it inside container)
COPY .env.local .env

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]