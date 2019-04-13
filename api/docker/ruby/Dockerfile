# https://cloud.google.com/sdk/docs/quickstart-redhat-centos

FROM ruby

COPY . ./

RUN gem install reverse_markdown && gem install redcarpet

ENTRYPOINT /bin/bash

