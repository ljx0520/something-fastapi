terraform:
	terraform init -reconfigure \
		-backend-config="bucket=$(TFSTATE_BUCKET)" \
		-backend-config="prefix=$(PROJECT)"
	terraform $(ACTION) -var-file=$(PROJECT).tfvars $(ARGS)

### Playground ###

# Most of other resources normally depend on the API/services being enabled.
# We could pepper depends_on all over the script but for the sake of brevity,
# instead, this target can be run once, the first time a project is being set up.
# Afterwards, run the normal apply.
apply-play-services:
	$(MAKE) terraform ACTION=apply PROJECT=org-playground \
		TFSTATE_BUCKET=org-tfstate-f519bd7a9a236334 \
		ARGS=-target="google_project_service.services"

plan-play:
	$(MAKE) terraform ACTION=plan PROJECT=org-playground \
		TFSTATE_BUCKET=org-tfstate-f519bd7a9a236334

apply-play:
	$(MAKE) terraform ACTION=apply PROJECT=org-playground \
		TFSTATE_BUCKET=org-tfstate-f519bd7a9a236334

### Production ###

apply-prod-services:
	$(MAKE) terraform ACTION=apply PROJECT=something-fastapi-405711 \
		TFSTATE_BUCKET=org-tfstate-f219baa786ec05ab \
		ARGS=-target="google_project_service.services"

plan-prod:
	$(MAKE) terraform ACTION=plan PROJECT=something-fastapi-405711 \
		TFSTATE_BUCKET=org-tfstate-f219baa786ec05ab

apply-prod:
	$(MAKE) terraform ACTION=apply PROJECT=something-fastapi-405711 \
		TFSTATE_BUCKET=org-tfstate-f219baa786ec05ab

# random default
all: apply-play