# Stage 1: Build Jekyll site
FROM ruby:3.1-slim AS builder
RUN apt-get update && apt-get install -y build-essential git
WORKDIR /srv/jekyll
COPY Gemfile* ./
RUN bundle install
COPY . .
RUN bundle exec jekyll build

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=builder /srv/jekyll/_site /usr/share/nginx/html
EXPOSE 80