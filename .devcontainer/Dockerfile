FROM amazonlinux:2023.1.20230809.0

# dnf fixes tool versions
RUN dnf install -y \
     git \
     unzip \
     sudo \
     dnf-utils

# install packer
RUN dnf config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo \
    && dnf install -y packer-1.11.2-1 \
    && rm -rf /var/cache/dnf/* \
    && dnf clean all

# install awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install

# useradd
RUN useradd "dev-user" && echo "dev-user ALL=NOPASSWD: ALL" >> /etc/sudoers
USER dev-user
