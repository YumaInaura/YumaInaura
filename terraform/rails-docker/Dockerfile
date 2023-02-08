FROM ruby:3.1.2

RUN mkdir /api
WORKDIR /api
COPY Gemfile /api/Gemfile
COPY Gemfile.lock /api/Gemfile.lock

# Bundlerの不具合対策(1)
RUN gem update --system
RUN bundle update --bundler

RUN bundle install --jobs=4
COPY . /api

CMD RAILS_LOG_TO_STDOUT=1 RAILS_ENV=production bundle exec rails server -p 80 -b '0.0.0.0'

# docker build -t rails-ex .
# docker run -it -p 3000:80 rails-ex

# docker tag rails-ex:latest 842696858454.dkr.ecr.ap-northeast-1.amazonaws.com/rails-ex:latest
# docker push 842696858454.dkr.ecr.ap-northeast-1.amazonaws.com/rails-ex:latest


