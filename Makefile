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
test:		## Run all tests
	$(PYTHON) -m pytest .
