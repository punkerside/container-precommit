FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  make \
  g++ \
  gcc \
  curl \
  unzip \
  python3 \
  python3-dev \
  python3-pip \
  git

RUN pip3 install pre-commit

RUN curl https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip -o terraform_0.12.29_linux_amd64.zip
RUN unzip terraform_0.12.29_linux_amd64.zip && chmod +x terraform && mv terraform /usr/bin/
RUN curl -L "$(curl -s https://api.github.com/repositories/60978152/releases/latest | grep -o -E "https://.+?-linux-amd64")" > terraform-docs && chmod +x terraform-docs && mv terraform-docs /usr/bin/

WORKDIR /app
CMD ["pre-commit", "run", "-a"]