# image-poc

## Description
Creates an image ready for a TFE installation.

## Ownership
TF:OP

## Build

To run config script locally:

```
$ docker build -t tfebase:image_ci .
$ docker run -d -i tfebase:image_ci
``` 

To run Packer locally:

```
$ packer build ./Packerfile.pkr.hcl
```

## Test

Run InSpec (cinc-auditor) against Docker container.

```
$ bundle install
$ bundle exec cinc-auditor exec ./test/integration/base_config -t docker://<container id>
```

## CI/CD

### Builds
Upon each push, CI will be triggered to run on GitHub Actions.

## Contributing
1. Create a branch off of `main`.
1. Make your change.
1. Add a test for your change (`test/integration/default`).
1. See the CI builds section below and ensure your build is green!
1. Open a PR back into `main`.