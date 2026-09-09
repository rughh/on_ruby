FROM ruby:3.2.11

RUN apt-get update -qq && apt-get install -y build-essential

RUN gem update --system

# for postgres (client included for convenient psql access)
RUN apt-get install -y libpq-dev postgresql-client

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN apt-get install -y nodejs

# for yarn / asset compilation (npm isn't bundled with the nodejs package
# here, but corepack is, so use it to activate yarn)
RUN corepack enable && corepack prepare yarn@stable --activate

# for git integration (e.g. source control inside dev containers)
RUN apt-get install -y git

ENV BUNDLE_PATH /box

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME

CMD script/server
