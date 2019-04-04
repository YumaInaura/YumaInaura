# https://cloud.google.com/sdk/docs/quickstart-redhat-centos

FROM centos

COPY . ./

RUN yum install -y vim sudo && \
  sudo yum install google-cloud-sdk

ENTRYPOINT /bin/bash
