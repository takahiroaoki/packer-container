FROM amazonlinux:2

RUN yum update -y \
    && yum install -y \
        git-2.40.1-1.amzn2.0.3 \
        unzip-6.0-57.amzn2.0.1 \
        sudo-1.8.23-10.amzn2.3.7 \
    && rm -rf /var/cache/yum/* \
    && yum clean all

# install awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install

# useradd
RUN useradd "dev-user" && echo "dev-user ALL=NOPASSWD: ALL" >> /etc/sudoers
USER dev-user
