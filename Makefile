ifeq ($(PYTHON),)
	export PYTHON=/usr/local/bin/python3
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

.PHONY: test
test:			## Run all tests
	$(PYTHON) -m pytest .

.PHONY: build
build:			## Build the http-service container
	@docker build -t http-service .

.PHONY: scan
scan:			## Run the security scanner the container image for http-service
	@docker scan http-service

.PHONY: clean-images
clean-images:		## Clean all container images
	@docker rmi -f $(docker images -aq)

.PHONY: clean
clean:			## Clean unused files and cache dirs
	@rm -rf .pytest_cache
	@rm -rf app/__pycache__
	@rm -rf tests/__pycache__
