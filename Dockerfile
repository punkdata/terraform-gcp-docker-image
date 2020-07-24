
FROM alpine

RUN apk add --update sudo wget curl zip python3 git openssh && rm -rf /var/cache/apk/*
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
	&& chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip \
	&& unzip terraform_0.12.29_linux_amd64.zip && mv terraform /usr/local/bin/ && rm -rf terraform_0.12.29_linux_amd64.zip
RUN wget -c https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.tar.gz -O gcp-cli.tar.gz
RUN tar -xzvf gcp-cli.tar.gz && mv google-cloud-sdk/ /usr/local/bin && ./usr/local/bin/google-cloud-sdk/install.sh  --quiet \
	&& rm -rf gcp-cli.tar.gz
ENV PATH="/usr/local/bin/google-cloud-sdk/bin:$PATH"
WORKDIR /root/
