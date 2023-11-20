# something-fastapi

Sample REST API using Python FastAPI

## Project Structure

```shell
├── README.md.md  # introduction
├── envs # environment variables for different environments deployment
├── app
│   ├── __init__.py
│   ├── config  # config
│   │   └── __init__.py
│   ├── constant  # constant
│   │   └── __init__.py
│   ├── dao # data access object
│   │   └── __init__.py
│   ├── dependencies  # dependencies injection
│   │   └── __init__.py
│   ├── main.py # main
│   ├── middleware # middleware
│   │   └── __init__.py
│   ├── models # models for database
│   │   └── __init__.py
│   ├── router # controller
│   │   ├── __init__.py
│   │   ├── default_router.py # default interface
│   │   └── demo_router.py # demo interface
│   ├── parameter # pydantic parameter model
│   │   └── __init__.py
│   ├── service # implement business logic
│   │   ├── __init__.py
│   └── utils # utils
│       ├── __init__.py
├── requirements.txt # dependencies
├── tests # test
    ├── __init__.py
    └── local_test.py
```

## Run the application

### Install dependencies

```shell
➜ pip install -r requirements.txt
```

#### Run Command

```sh
# start with uvicorn
➜ uvicorn main:app --host 0.0.0.0 --port 8080 --workers 1
INFO:     Started server process [36375]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://127.0.0.1:8080 (Press CTRL+C to quit)

# start with python
➜  python main.py
INFO:     Started server process [36468]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8080 (Press CTRL+C to quit)
```

## Run in Docker

```
docker image build -t something-fastapi .
docker container run -i -t --init -p 8080:8080 --env-file .env something-fastapi
```

## Deploy

> **Note**
> This is informational only. The deployment is done via GitHub Actions.

Assuming `gcloud` is logged in and set to the correct project:

```
gcloud run deploy something-fastapi \
  --platform managed \
  --region us-central1 \
  --service-account something-fastapi@org-playground.iam.gserviceaccount.com \
  --env-vars-file=./envs/org-playground.yml
```

## Secrets

Secret environment variables are stored in Google Secret Manager.

To add a new secret, assuming changes to the application code itself is completed:

- Add the secret to `google_secret_manager_secret.something-fastapi_secrets` in `infra/something-fastapi.tf`. 
- Add the secret values as secret versions manually per `infra/MANUAL.md`. 
- Add the mapping between the env var and the secret name in `secret-env-vars` variable
   in `.github/workflows/something-fastapi.yml`.