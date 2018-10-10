# Pull the base image with given version.
ARG BUILD_TERRAFORM_VERSION=0.11.7
FROM microsoft/terraform-test:${BUILD_TERRAFORM_VERSION}

ARG MODULE_NAME="terraform-azurerm-postgresql"

# Declare default build configurations for terraform.
ARG BUILD_ARM_SUBSCRIPTION_ID="2a6b40d9-16cb-4676-8609-d5a1df110803"
ARG BUILD_ARM_CLIENT_ID="047fa392-071b-496a-b318-fcb93d9a5431"
ARG BUILD_ARM_CLIENT_SECRET="cf7936bd-248c-405c-962a-77d50cd9b3d5"
ARG BUILD_ARM_TENANT_ID="72f988bf-86f1-41af-91ab-2d7cd011db47"
ARG BUILD_ARM_TEST_LOCATION="WestEurope"
ARG BUILD_ARM_TEST_LOCATION_ALT="WestUS"

# Set environment variables for terraform runtime.
ENV ARM_SUBSCRIPTION_ID=${BUILD_ARM_SUBSCRIPTION_ID}
ENV ARM_CLIENT_ID=${BUILD_ARM_CLIENT_ID}
ENV ARM_CLIENT_SECRET=${BUILD_ARM_CLIENT_SECRET}
ENV ARM_TENANT_ID=${BUILD_ARM_TENANT_ID}
ENV ARM_TEST_LOCATION=${BUILD_ARM_TEST_LOCATION}
ENV ARM_TEST_LOCATION_ALT=${BUILD_ARM_TEST_LOCATION_ALT}

RUN mkdir /usr/src/${MODULE_NAME}
COPY . /usr/src/${MODULE_NAME}
WORKDIR /usr/src/${MODULE_NAME}

# Set work directory
RUN mkdir /go
RUN mkdir /go/bin
RUN mkdir /go/src
RUN mkdir /go/src/${MODULE_NAME}
COPY . /go/src/${MODULE_NAME}
WORKDIR /go/src/${MODULE_NAME}

# Install required go packages using dep ensure
ENV GOPATH /go
ENV PATH /usr/local/go/bin:$GOPATH/bin:$PATH
RUN /bin/bash -c "curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh"

RUN ["bundle", "install", "--gemfile", "./Gemfile"]
