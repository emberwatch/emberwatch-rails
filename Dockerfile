FROM ruby:2.3

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y -qq \
      libpq-dev

# Create app directory
ENV APP_HOME /usr/src/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install bundler
RUN gem install bundler

# Copy Gemfile
COPY Gemfile* $APP_HOME/

# Increase Bundler workers
ENV BUNDLE_JOBS=2

# Install newer version of Bundler and gems
RUN bundle install

# Copy working directory
COPY . $APP_HOME

# Add bin/ folder to PATH
ENV PATH $APP_HOME/bin:$PATH

# Create tmp directory
RUN mkdir -p $APP_HOME/tmp && \
    mkdir -p $APP_HOME/tmp/pids \
    mkdir -p $APP_HOME/log
