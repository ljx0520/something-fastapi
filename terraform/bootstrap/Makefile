terraform:
	terraform init -reconfigure -backend-config="path=./$(PROJECT).tfstate"
	terraform $(ACTION) -var "project_id=$(PROJECT)"

plan-play:
	$(MAKE) terraform PROJECT=org-playground ACTION=plan

apply-play:
	$(MAKE) terraform PROJECT=org-playground ACTION=apply

plan-prod:
	$(MAKE) terraform PROJECT=something-fastapi-405711 ACTION=plan

apply-prod:
	$(MAKE) terraform PROJECT=something-fastapi-405711 ACTION=apply

# random default
all: apply-play