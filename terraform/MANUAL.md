# Manual Steps

The following cannot (or should not) be automated using Terraform.

> **Note**
> Either suffix all commands with `--project <target project>` or run the following before starting:
>
> ```
> gcloud config set core/project <target project>
> ```

# Create Firestore Database

> **For:** _Multiple components_<br/>
> **When:** Before Terraform<br/>
> **Why:** Not supported in Terraform

Configure the Firestore database:

```
gcloud firestore databases create --type=firestore-native --location=nam5
```

> **Note**
> Skip the below step for now, i.e. full retention of data.
> This should be revisited if storage costs become an issue.

~~Configure a time-to-live policy for `transactions` collection group:~~

```
gcloud firestore fields ttls update deleteAt --collection-group=transactions --enable-ttl
```

## Add function secrets

> **For:** `something-fastapi`<br/>
> **When:** After Terraform<br/>
> **Why:** Supported in Terraform but results in the secrets being stored as plaintext in the Terraform state.

The Cloud Function expects certain environment configuration to be provided as secrets.
See `.github/workflows/something-fastapi.yml` for the secrets that are currently expected.

The secrets themselves are created via Terraform but the secret version needs to be added manually:

```bash
# if the secret is a value
printf "some secret" | gcloud secrets versions add <secret name> --data-file=-
# if the secret is from a file
gcloud secrets versions add <secret name> --data-file=<file path>
```

## Deploy functions

> **For:** `something-fastapi`<br/>
> **When:** After Terraform<br/>
> **Why:** Currently this is far more convinient than Terraform, since a single command sets up a bucket, a cloud build,
> a cloud run, artifact registry, etc. Reverse-engineering this all in Terraform is effort we can't afford to spend
> right now.

The deployment is handled by GitHub Actions. Otherwise, refer to each function's README file for the command to deploy
that function manually.