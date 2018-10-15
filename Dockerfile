FROM pawurb/ruby-jemalloc-node-yarn:latest

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && apt-get clean

COPY Gemfile* /tmp/
COPY package.json /tmp/
COPY yarn.lock /tmp/
WORKDIR /tmp
RUN bundle install --jobs 5 --retry 5 --without development test
RUN yarn install

RUN mkdir /app
WORKDIR /app
COPY . /app
ENV RAILS_ENV production
ENV RACK_ENV production
CMD ["bin/run-dev.sh"]
