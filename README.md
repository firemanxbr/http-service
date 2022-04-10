# http-service
Example of an HTTP service using best practices in place

---
## Introduction
This project has a goal to create an HTTP Service from scratch, step by step using best practices to archive a reasonable state of the art.

---
## Requirements

### Development environment
- We will not cover the development environment setup, keeping the focus on the application, all requirements below will be not covered, please do it yourself;
-  macOS Monterey using the zsh shell on the terminal;
- Docker for Mac installed and running; 
- Python 3.9 or newer

### Application
- Please check the [Makefile](Makefile) and [requirements.txt](requirements.txt) files to be aware of all requirements necessary for HTTP Service;

---
## Install
To install anywhere the HTTP service just need to run:
```code
$ make install
```

## Tests
To run all tests for HTTP service just need runs:
```code
$ make test
```

---
## TODO
- Create a production-ready Dockerfile (https://catalog.redhat.com/software/containers/ubi8/ubi-minimal/5c359a62bed8bd75a2c3fba8?container-tabs=gti)
- Documentation
- Automate deployment of a local Kubernetes cluster using Kind(https://kind.sigs.k8s.io/)
