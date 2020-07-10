# devpy on k8s
manifest files for devpy deployment on k8s.
## Requirements
- a namespace called pypiserver is created and present
- a default storage class is present
- Your k8s has a Loadbalancer available (metallb if on premise or public clouds have their own), else change the service type to ClusterIP in servcie.yaml
