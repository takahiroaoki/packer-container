FROM amazonlinux:2023.1.20230809.0

#RUN yum update -y \
#    && yum install -y \
#        git-2.40.1-1.amzn2.0.3 \
#        unzip-6.0-57.amzn2.0.1 \
#        sudo-1.8.23-10.amzn2.3.7 \
#        yum-utils-1.1.31-46.amzn2.0.1

# install packer
#RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo \
#    && yum install -y packer-1.11.2-1 \
#    && rm -rf /var/cache/yum/* \
#    && yum clean all

# remove symbolic link to another packer named "cracklib-packer"
#RUN rm /usr/sbin/packer

# install awscli
#RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
#    && unzip awscliv2.zip \
#    && sudo ./aws/install

# useradd
#RUN useradd "dev-user" && echo "dev-user ALL=NOPASSWD: ALL" >> /etc/sudoers
#USER dev-user
