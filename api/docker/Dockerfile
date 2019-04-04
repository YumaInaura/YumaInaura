# https://cloud.google.com/sdk/docs/quickstart-redhat-centos

FROM centos

COPY . ./

RUN yum install -y vim sudo && \
  cp ./google-cloud-sdk.repo /etc/yum.repos.d/ && \
  sudo yum install -y google-cloud-sdk

ENTRYPOINT /bin/bash
