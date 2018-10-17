FROM pawurb/ruby-jemalloc-node-yarn:latest

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && apt-get clean

RUN mkdir /app
COPY Gemfile* /app/
COPY package.json /app/
COPY yarn.lock /app/
WORKDIR /app
RUN bundle install --jobs 5 --retry 5 --without development test
RUN yarn install

COPY . /app
ENV RAILS_ENV production
ENV RACK_ENV production
CMD ["bin/run-dev.sh"]
