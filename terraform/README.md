# Google Cloud Infrastructure Provisioning

Automates the provisioning of Google Cloud resources using Terraform.

Certain resources cannot (or should not) be automated. See [MANUAL.md](MANUAL.md) for the relevant instructions.

## Use

```sh
# setup playground: org-playground
make apply-play-services
make apply-play

# setup production: something-api
make apply-prod-services
make apply-prod
```

* See `Makefile` for all targets.

## Terraform State

Terraform state is stored in `org-tfstate-*` buckets in each project. These are created using the one-off Terraform
script in `bootstrap/`.

> **Note**
> Ideally, this bucket should not live in the same project it manages but for simplicity, this is sufficient for now.