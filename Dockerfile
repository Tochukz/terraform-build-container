FROM hashicorp/terraform:0.12.29
LABEL maintainer="Colin But"

RUN apk add -U curl

ARG VERSION_TFSEC=1.28.1

# install tflint
RUN curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip tflint.zip && rm tflint.zip
RUN mv tflint /usr/local/bin/

# install tfsec
RUN curl -Lso tfsec https://github.com/tfsec/tfsec/releases/download/v${VERSION_TFSEC}/tfsec-linux-amd64
RUN chmod +x tfsec && mv tfsec /usr/local/bin/
