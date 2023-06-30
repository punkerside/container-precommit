FROM alpine:3.18.2

RUN apk update && apk upgrade && apk add --no-cache \
  curl=8.1.2-r0 \
  git=2.40.1-r0 \
  python3=3.11.4-r0 \
  python3-dev=3.11.4-r0 \
  py3-pip=23.1.2-r0 \
  g++=12.2.1_git20220924-r10 \
  gcc=12.2.1_git20220924-r10 \
  make=4.4.1-r1 \
  bash=5.2.15-r5 \
  perl=5.36.1-r2 && \
  rm /var/cache/apk/*

RUN curl -s https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip -o /tmp/terraform_1.5.2_linux_amd64.zip && \
  unzip /tmp/terraform_1.5.2_linux_amd64.zip -d /tmp/ && \
  chmod +x /tmp/terraform && mv /tmp/terraform /usr/bin/ && \
  rm -rf /tmp/terraform_1.5.2_linux_amd64.zip

RUN curl -s -Lo ./terraform-docs.tar.gz "https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz" && \
  tar -xzf terraform-docs.tar.gz && \
  chmod +x terraform-docs && \
  mv terraform-docs /usr/bin/terraform-docs

RUN pip install --no-cache-dir pre-commit==3.3.3

WORKDIR /app
CMD [ "pre-commit", "run", "-a" ]