# Use the official Ruby image as the base image
FROM ruby:3.4-slim

# Set environment variables
ENV RAILS_ENV=production \
    BUNDLE_PATH=/gems

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    imagemagick \
    git \
    curl \
    # Added dependencies based on Gemfile analysis
    libxml2-dev \
    libxslt1-dev \
    jpegoptim \
    optipng \
    gifsicle \
    cmake \
    liblz4-dev \
    libmaxminddb-dev \
    # Added for psych gem
    libyaml-dev

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --without development test

# Copy the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
