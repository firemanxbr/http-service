ifeq ($(PYTHON),)
	export PYTHON=/usr/local/bin/python3
endif

ifeq ($(HTTP_SERVICE_VERSION),)
	export HTTP_SERVICE_VERSION="0.1.0"
endif

.PHONY: help
help:			## Show the help.
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep

.PHONY: install
install:		## Install http-service requirements
	$(PYTHON) -m pip install -r requirements.txt
	$(PYTHON) -m pip install -r requirements_dev.txt

.PHONY: test
test:			## Run all tests
	$(PYTHON) -m pytest .

.PHONY: build
build:			## Build the http-service container
	@docker build -t http-service:$(HTTP_SERVICE_VERSION) .

.PHONY: scan
scan:			## Run the security scanner the container image for http-service
	@docker scan http-service:$(HTTP_SERVICE_VERSION)

.PHONY: clean-images
clean-images:		## Clean all container images
	docker rmi $$(docker images -aq) -f

.PHONY: clean
clean:			## Clean unused files and cache dirs
	@rm -rf .pytest_cache
	@rm -rf app/__pycache__
	@rm -rf tests/__pycache__
