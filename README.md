# packer-container
Packer execution environment.

## Requirement
- DockerDesktop

We use GitHub Codespaces.

## Setup
We have to create an IAM user "packer" profile with appropriate access.

After creating IAM user via aws management console, execute the following command.

```
# Initial setting for awscli. Input your key info.
$ aws configure --profile packer

# You can check the credential.
$ cat ~/.aws/credentials

# The result of the command above is like following.
> [packer]
> aws_access_key_id = ${Your access key}
> aws_secret_access_key = ${Your secret key}
```

## How to use
Reference to each project's README @projects/${each project}

## Appendix
### Packer
```
# Install dependencies
$ packer init ${file name}

# Validation
$ packer validate ${file name}

# Build images
$ packer build ${file name}

$ Usr packer console
$ packer console --config-type=hcl2
```