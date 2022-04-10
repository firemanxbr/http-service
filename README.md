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
## Makefile
Makefile is a complete toolbox for different situations in the development workflow of http-service

### Help
To visualize all targets available run:
```code
$ make help
```

### Install
To install anywhere the HTTP service just need to run:
```code
$ make install
```

### Tests
To run all tests for HTTP service just need to run:
```code
$ make test
```

### Build
To build a container locally just need to run:
```code
$ make build
```

### Scan
To run the security scanner in the container image for http-service just need to run: 
```code
$ make scan
```

### Clean-images
To clean all container images just need to run: 
```code
$ make clean-images
```

### Clean
To clean all unused files and cache directories run: 
```code
$ make clean
```

___
## Environment Variables

List of Variables
- HTTP_SERVICE_PORT

Setting an environment variable
```code
$ export HTTP_SERVICE_PORT=8000
```

Checking an environment variable
```code
$ echo "$HTTP_SERVICE_PORT"
```

Unset an environment variable
```code
$ unset HTTP_SERVICE_PORT
```

---
## TODO
- Automate deployment of a local Kubernetes cluster using Kind(https://kind.sigs.k8s.io/)
- Setup a local CI/CD pipeline
