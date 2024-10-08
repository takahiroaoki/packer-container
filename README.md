# packer-container
Packer execution environment.

## Requirement
- Docker Desktop
- VSCode & Dev Container Extension

※The maintainer uses codespaces.

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

## Build
Build can be achieved by ./github/workflows/build_XXX.yml via GitHub Actions.

That workflow needs the following info (of profile "packer") to secrets.
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

## Appendix
### Packer
```
# Install dependencies
$ packer init ${file name}

# Format
$ packer fmt ${file name}

# Validation
$ packer validate ${file name}

# Build images
$ packer build [-debug] [-on-error=ask] [-var ${var name}=${value}] [-var-file=${pkrvars.hcl file name}] ${file name}

$ Use packer console
$ packer console --config-type=hcl2 [-var-file=${pkrvars.hcl file name}] [${pkr.hcl file name you want to include}]
```
