## Architectural Overview

| Component         | Implementation | Description  |
|-------------------|----------------|--------------|
| Something FastAPI | Cloud Run      | FastAPI demo |

## Environments

### Playground

| Component         | Details                                           |
|-------------------|---------------------------------------------------|
| GCP Project       | `org-playground`                                  |
| Something FastAPI | https://something-fastapi-klebh6iewq-uc.a.run.app |

### Production

| Component         | Details                                           |
|-------------------|---------------------------------------------------|
| GCP Project       | `something-fastapi-405711`                        |
| Something FastAPI | https://something-fastapi-mdoidjfrga-uc.a.run.app |

## Secrets

You can find these in a given GCP project's Cloud Secret Manager:

| Secret   | Type        | Purpose               |
|----------|-------------|-----------------------|
| `secret` | Demo Secret | Demon usage of secret |

## GitHub Action deployment

> **Note**
> We are on GitHub Teams subscription so we do not have access to protected deployment environments and approval gates.
> The below approach was developed as an alternative.

In general, merging into the `main` branch automatically triggers the relevant deployments to non-production
environments. Production deployments need to be explicitly triggered.

For example, [`something-fastapi`](https://github.com/ljx0520/something-fastapi/actions/workflows/something-fastapi.yml)
workflow is triggered automatically when new commits appear in the relevant directories on the `main` branch. It
proceeds to automatically deploy the new changes to the `org-playground` GCP project.

For production deployment,

1. Navigate
   to [`something-fastapi`](https://github.com/ljx0520/something-fastapi/actions/workflows/something-fastapi.yml)
   workflow
2. Click on "Run workflow"
3. Choose the target environment, e.g. Production, and the desired commit SHA to deploy.
    * Review the [commits](https://github.com/ljx0520/something-fastapi/commits/main) and copy the SHA for your desired
      version to deploy
    * If no commit SHA is provided the `HEAD` commit of the currently selected branch/tag will be used, i.e. deploy the
      latest

This process can be used, at any time, to perform ad-hoc deployments to any environments. This is useful for
redeployments of the same version or rollback (i.e. deploy an earlier version).

### Directories of note:

* [something-fastapi](something-fastapi): Python FastAPI API Cloud Function
* [terraform](terraform): Terraform scripts to set up GCP for the above

See each directory's `README.md` file for more information.