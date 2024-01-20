FROM ruby:3.2.3

RUN apt-get update -qq && apt-get install -y build-essential

RUN gem update --system

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN apt-get install -y nodejs

ENV BUNDLE_PATH /box

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME

CMD script/server
