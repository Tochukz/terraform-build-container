# Terraform build container

## Build and publish the docker image 
The build should be done on a Linux machine such as Ubuntu.  
You may setup an EC2 instance with Ubuntu AMI if you do not have a Linux machine.  

__Login__  
First login to docker from the terminal
```bash
$ docker login
```
Supply your username and password to login

__Build the image__  
```bash
$ docker build -t bbdchucks/terraform-build-container:0.01 . 
```

__Publish the image to docker hub__   
```bash
$ docker push bbdchucks/terraform-build-container:0.01
```

__Other usefull docker commands__ 
```bash
# list existing images
$ docker images
# list containers
$ docer ps 
```
