# http-service
Example of an HTTP service using best practices in place.

---
## Introduction
This project has a goal to create an HTTP Service from scratch, step by step using best practices to archive a reasonable state of the art.

---
## Requirements

### Development environment
- We will not cover the development environment setup, keeping the focus on the application, all requirements below will be not covered, please do it yourself;
-  [macOS Monterey](https://www.apple.com/macos/monterey/) using the zsh shell on the terminal;
- [Docker](https://docs.docker.com/desktop/mac/install/) for Mac installed and running; 
- [Python](https://docs.brew.sh/Homebrew-and-Python) 3.10 or newer;
- [Kind](https://kind.sigs.k8s.io/) to have a local Kubernetes cluster; 
- [Kubectl](https://kubernetes.io/docs/tasks/tools/) for managing the Kubernetes cluster;
- [Terraform](https://www.terraform.io/cli/commands) for IaC to orchestrate the [Kind](https://kind.sigs.k8s.io/)

#### Tools for development environment
```code
$ brew install docker kubectl kind
```

### Application
- Please check the [Makefile](Makefile) and [requirements.txt](requirements.txt) files to be aware of all requirements necessary for HTTP Service. To run tests will be necessary to use the file [requirements_dev.txt](requirements_dev.txt)  

---
## Makefile
[Makefile](Makefile) is a complete toolbox for different situations in the development workflow of http-service

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
- HTTP_SERVICE_VERSION

Setting an environment variable
```code
$ export HTTP_SERVICE_PORT=8080
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
## Deployment

### Terraform
The Infrastructure as Code used in this project is [Terraform](https://www.terraform.io/cli/commands) to orchestrate the [Kind](https://kind.sigs.k8s.io/). [Kind](https://kind.sigs.k8s.io/) is used by the Kubernetes project to test the Kubernetes cluster changes, is a light version than Minikube that run a Kubernetes cluster inside of docker container.  

To orchestrate the [Kind](https://kind.sigs.k8s.io/) Kubernetes cluster needs to run the commands below inside of **deployment/** directory: 
```code
$ cd deployment/
$ terraform init
$ terraform plan -var="cluster_name=local"
$ terraform apply -var="cluster_name=local" -auto-approve
```

---
## TODO
- Setup a local CI/CD pipeline
