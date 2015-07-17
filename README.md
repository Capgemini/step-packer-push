# Wercker Packer Push

A step for pushing [packer](https://www.packer.io/) templates into [Atlas](https://atlas.hashicorp.com/).

## Dependencies

This build-step depends on ansible, wget and unzip being installed, if any it's missing, the buildstep wil fail. Please install those in your box wercker.yml

You can do this as follows:

```yaml
build:
  steps:
    - install-packages:
        packages: wget unzip
```

## Usage

```yaml

deploy:
  steps:
    - capgemini/step-packer-push:
        packer_version: 0.8.1
        packer_folder: packer
        packer_templates: 'ubuntu-14.04_amd64-amis.json,ubuntu-14.04_amd64-droplet.json'
```

This will make a "git diff" between the last two merges into the current branch and will "run packer push" for every template in case there is any file changed inside "packer_folder".

## License

The MIT License (MIT)