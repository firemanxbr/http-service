# http-service
Example of an HTTP service using best practices in place.

---
## Introduction
This project has a goal to create an HTTP Service from scratch, step by step using best practices to archive a reasonable state of the art.

---
## Requirements

### Development environment
- We will not cover the development environment setup, keeping the focus on the application, all requirements below will be not covered, please do it yourself;
- [macOS Monterey](https://www.apple.com/macos/monterey/) using the zsh shell on the terminal;
- [Docker](https://docs.docker.com/desktop/mac/install/) for Mac installed and running; 
- [Python](https://docs.brew.sh/Homebrew-and-Python) 3.10 or newer;
- [Kind](https://kind.sigs.k8s.io/) to have a local Kubernetes cluster; 
- [Kubectl](https://kubernetes.io/docs/tasks/tools/) for managing the Kubernetes cluster;
- [Terraform](https://www.terraform.io/cli/commands) for IaC to orchestrate the [Kind](https://kind.sigs.k8s.io/);
- [Tekton](https://tekton.dev/) for CI/CD running into local Kubernetes cluster;

#### Tools for development environment
```code
$ brew install docker kubectl kind tektoncd-cli
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

### Kubernetes
After finishing the deployment of the local Kubernetes cluster is possible to check the nodes and pods: 
```code
$ kubectl get nodes                                                                         
NAME                  STATUS   ROLES                  AGE   VERSION
local-control-plane   Ready    control-plane,master   35m   v1.21.1

$ kubectl get pods --all-namespaces
NAMESPACE            NAME                                          READY   STATUS    RESTARTS   AGE
kube-system          coredns-558bd4d5db-5zm9d                      1/1     Running   0          36m
kube-system          coredns-558bd4d5db-z2llc                      1/1     Running   0          36m
kube-system          etcd-local-control-plane                      1/1     Running   0          36m
kube-system          kindnet-slz5z                                 1/1     Running   0          36m
kube-system          kube-apiserver-local-control-plane            1/1     Running   0          36m
kube-system          kube-controller-manager-local-control-plane   1/1     Running   0          36m
kube-system          kube-proxy-brdbm                              1/1     Running   0          36m
kube-system          kube-scheduler-local-control-plane            1/1     Running   0          36m
local-path-storage   local-path-provisioner-85494db59d-n5lhp       1/1     Running   0          36m
```

To deploy the http-service into the local Kubernetes cluster just need to run: 
```code
$ kubectl apply -f deployment/kubernetes/api.yaml -n development
```

To check the http-service deployment:
```code
$ kubectl get pods -n development
NAME                            READY   STATUS    RESTARTS   AGE
http-service-588fcc6754-w6hdf   1/1     Running   0          25m
```

To check the logs of http-service:
```code
$ kubectl logs deploy/http-service -n development
2022-04-12 00:25:37 INFO:     Will watch for changes in these directories: ['/Users/marcelobarbosa/Documents/http-service']
2022-04-12 00:25:37 INFO:     Uvicorn running on http://0.0.0.0:8080 (Press CTRL+C to quit)
2022-04-12 00:25:37 INFO:     Started reloader process [42921] using statreload
2022-04-12 00:25:38 INFO:     Started server process [42923]
2022-04-12 00:25:38 INFO:     Waiting for application startup.
2022-04-12 00:25:38 INFO:     Application startup complete.
2022-04-12 00:26:06 INFO:     127.0.0.1:60470 - "GET / HTTP/1.1" 307 Temporary Redirect
2022-04-12 00:26:06 INFO:     127.0.0.1:60470 - "GET /docs HTTP/1.1" 200 OK
2022-04-12 00:26:07 INFO:     127.0.0.1:60470 - "GET /openapi.json HTTP/1.1" 200 OK
2022-04-12 00:26:16 INFO:     127.0.0.1:60471 - "GET /helloworld HTTP/1.1" 200 OK
2022-04-12 00:26:51 INFO:     127.0.0.1:60474 - "GET /helloworld?name=AlfredENeumann HTTP/1.1" 200 OK
2022-04-12 00:26:59 INFO:     127.0.0.1:60477 - "GET /versionz HTTP/1.1" 200 OK
```

To test the http-service using a browser or Postman:
```code
$ kubectl port-forward svc/http-service 8080 -n development
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

After the command above access the URL http://127.0.0.1:8080 

---
## Tekton CI/CD
As an extra task following below is the setup of a local CI/CD system called [Tekton](https://tekton.dev/) running into the local Kubernetes cluster. 

**NOTE:** Working in progress, just an example about what is possible to do with [Tekton](https://tekton.dev/). 

Installing Tekton:
```code
$ kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml 
namespace/tekton-pipelines created
Warning: policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
podsecuritypolicy.policy/tekton-pipelines created
clusterrole.rbac.authorization.k8s.io/tekton-pipelines-controller-cluster-access created
clusterrole.rbac.authorization.k8s.io/tekton-pipelines-controller-tenant-access created
clusterrole.rbac.authorization.k8s.io/tekton-pipelines-webhook-cluster-access created
role.rbac.authorization.k8s.io/tekton-pipelines-controller created
role.rbac.authorization.k8s.io/tekton-pipelines-webhook created
role.rbac.authorization.k8s.io/tekton-pipelines-leader-election created
role.rbac.authorization.k8s.io/tekton-pipelines-info created
serviceaccount/tekton-pipelines-controller created
serviceaccount/tekton-pipelines-webhook created
clusterrolebinding.rbac.authorization.k8s.io/tekton-pipelines-controller-cluster-access created
clusterrolebinding.rbac.authorization.k8s.io/tekton-pipelines-controller-tenant-access created
clusterrolebinding.rbac.authorization.k8s.io/tekton-pipelines-webhook-cluster-access created
rolebinding.rbac.authorization.k8s.io/tekton-pipelines-controller created
rolebinding.rbac.authorization.k8s.io/tekton-pipelines-webhook created
rolebinding.rbac.authorization.k8s.io/tekton-pipelines-controller-leaderelection created
rolebinding.rbac.authorization.k8s.io/tekton-pipelines-webhook-leaderelection created
rolebinding.rbac.authorization.k8s.io/tekton-pipelines-info created
customresourcedefinition.apiextensions.k8s.io/clustertasks.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/conditions.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/pipelines.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/pipelineruns.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/pipelineresources.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/runs.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/tasks.tekton.dev created
customresourcedefinition.apiextensions.k8s.io/taskruns.tekton.dev created
secret/webhook-certs created
validatingwebhookconfiguration.admissionregistration.k8s.io/validation.webhook.pipeline.tekton.dev created
mutatingwebhookconfiguration.admissionregistration.k8s.io/webhook.pipeline.tekton.dev created
validatingwebhookconfiguration.admissionregistration.k8s.io/config.webhook.pipeline.tekton.dev created
clusterrole.rbac.authorization.k8s.io/tekton-aggregate-edit created
clusterrole.rbac.authorization.k8s.io/tekton-aggregate-view created
configmap/config-artifact-bucket created
configmap/config-artifact-pvc created
configmap/config-defaults created
configmap/feature-flags created
configmap/pipelines-info created
configmap/config-leader-election created
configmap/config-logging created
configmap/config-observability created
configmap/config-registry-cert created
deployment.apps/tekton-pipelines-controller created
service/tekton-pipelines-controller created
horizontalpodautoscaler.autoscaling/tekton-pipelines-webhook created
deployment.apps/tekton-pipelines-webhook created
service/tekton-pipelines-webhook created
```

Checking the Tekton pods:
```code
$ kubectl get pods --namespace tekton-pipelines
NAME                                           READY   STATUS    RESTARTS   AGE
tekton-pipelines-controller-799fd96f87-gqgwj   1/1     Running   0          48s
tekton-pipelines-webhook-6f44cfb768-65n9n      1/1     Running   0          48s
```

Create a Task for a sample pipeline:
```code
$ kubectl apply -f deployment/tekton/task-hello.yaml
task.tekton.dev/hello created
```

Create a TaskRun for the sample pipeline created above: 
```code
$ kubectl create -f deployment/tekton/taskRun-hello.yaml
taskrun.tekton.dev/hello-run-ghk65 created
```

Check the logs/results of the pipeline after the run:
```code
$ tkn taskrun logs --last -f
[hello] Hello World!
```

---
## Docker Hub
The container image can be downloaded from [Docker Hub](https://hub.docker.com/r/firemanxbr/http-service).

```code
$ docker pull firemanxbr/http-service:0.1.0
```

---
## TODO
- Create a pipeline to run local tests;
- Create a pipeline to move the http-service between different namespaces as environments;
- Create a pipeline to upgrade the container image on Docker Hub;
