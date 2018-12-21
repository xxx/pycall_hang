FROM library/ruby:2.5.3-slim
MAINTAINER Michael Dungan <mpd@catchandrelease.tv>

ARG dir="/srv/classifier"

EXPOSE 5000

RUN gem update bundler && \
    echo "deb http://ftp.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/backports.list && \
    apt-get update && \
    apt-get install -y \
      build-essential \
      git \
      python3 \
      python3-pip && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
    useradd -lm -u 1000 candr && \
    mkdir $dir && \
    chown candr:candr $dir

WORKDIR $dir

COPY Pipfile Pipfile.lock $dir/

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN pip3 install --system pipenv && \
    pipenv install --system && \
    python -m spacy download en

COPY Gemfile Gemfile.lock $dir/

RUN gem install rake && \
    bundle config github.https true && \
    bundle install && \
    apt-get remove -y \
      build-essential \
      wget && \
    apt-get purge -y && \
    apt-get autoremove -y

COPY . $dir

USER candr

# Run in a shell because of Heroku requirement.
CMD puma config.ru -C puma.rb
