FROM alpine:3.16.2

RUN apk update && apk upgrade && apk add --no-cache \
  curl \
  git \
  python3 \
  python3-dev \
  py3-pip \
  g++ \
  gcc \
  make \
  bash \
  perl

RUN curl -s https://releases.hashicorp.com/terraform/1.2.5/terraform_1.2.5_linux_amd64.zip -o /tmp/terraform_1.2.5_linux_amd64.zip && \
  unzip /tmp/terraform_1.2.5_linux_amd64.zip -d /tmp/ && \
  chmod +x /tmp/terraform && mv /tmp/terraform /usr/bin/ && \
  rm -rf /tmp/terraform_1.2.5_linux_amd64.zip

RUN curl -s -Lo ./terraform-docs.tar.gz "https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz" && \
  tar -xzf terraform-docs.tar.gz && \
  chmod +x terraform-docs && \
  mv terraform-docs /usr/bin/terraform-docs

RUN pip install --no-cache-dir pre-commit==2.20.0

WORKDIR /app
CMD [ "pre-commit", "run", "-a" ]