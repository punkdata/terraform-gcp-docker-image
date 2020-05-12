
FROM alpine

RUN apk add --update wget zip python3 && rm -rf /var/cache/apk/*
RUN wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip \
	&& unzip terraform_0.12.24_linux_amd64.zip && mv terraform /usr/local/bin/ && rm -rf terraform_0.12.24_linux_amd64.zip
RUN wget -c https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.tar.gz -O gcp-cli.tar.gz
RUN tar -xzvf gcp-cli.tar.gz && mv google-cloud-sdk/ /usr/local/bin && ./usr/local/bin/google-cloud-sdk/install.sh  --quiet \
	&& rm -rf gcp-cli.tar.gz
RUN addgroup -S terraform && adduser -S terraform -G terraform
ENV PATH="/usr/local/bin/google-cloud-sdk/bin:$PATH"
USER terraform
WORKDIR /home/terraform