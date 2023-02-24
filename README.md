# Infra-Repo

create a cluster and deploy jenkins and deploy a app in it in gcp

Deploy an application on GKE using CI/CD Jenkins Pipeline using the following steps:

1- Implement a secure GKE Cluster

2- Deploy and configure Jenkins on GKE

3- Deploy the backend application on GKE using the Jenkins pipeline

# First-Part

1-Install Terraform and create Infrastructure.

-  Infrastructure Overview
    
      1-vpc.

      2-Two subnets [management subnet and restricted subnet],NAT Gateway for two subnets and Firewall to allow SSH Connection.

      3-GKE Files Consist of:

        private container cluster resource with authorized networks configuration - node pool with count 1.

      4- a Private VM to Connect with GKE Cluster.
    
    
2-Build Infrastructure. [3 steps ]

 -Initialize Terraform use
  
    terraform init
         
 -Check Plan
 
    terraform init
    
 -Apply the plan
 
    terraform apply
    
 -screenshot of terraform init:
  
  <img src="ScreenShots/terraform-init.png" width=400 >
  
  -screenshot of terraform plan:
  
  <img src="ScreenShots/terraform-plan.png" width=400 >
  
  <img src="ScreenShots/terraform-plan-2.png" width=400 >
  
  -screenshot of terraform apply:
  
  <img src="ScreenShots/terraform-apply.png" width=400 >
  
  <img src="ScreenShots/terraform-apply-2.png" width=400 >
  
3-Check Infrastructure using console. 
 -vpc
 
  <img src="ScreenShots/vpc.png" width=400 >
 
 -vm
  
   <img src="ScreenShots/vm.png" width=400 >
   
 -two subnets
   
   <img src="ScreenShots/two-subnets.png" width=400 >
   
 -cluster
  
   <img src="ScreenShots/cluster-info.png" width=400 >
   
   <img src="ScreenShots/cluster-info-2.png" width=400 >
   
4- SSH VM

5-Connect to Private GKE Cluster through VM 

   <img src="ScreenShots/connest-to-cluster.png" width=400 >
   
6-Install kubectl and GKE gcloud auth Plugin

    sudo apt-get install kubectl
    
    sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

7-Log in with your Credentials

    gcloud auth login

8- Set your active Application Default Credentials

    gcloud auth application-default login
    
 -Then build my-image and push it to gcr to use it in slave-pod  
    
   <img src="ScreenShots/build-img.png" width=400 >
    
   <img src="ScreenShots/push-img.png" width=400 >
    
   <img src="ScreenShots/finish-push.png" width=400 >
    
   <img src="ScreenShots/img-gcr.png" width=400 >
    
9-Deploy jenkins on GKE Cluster
    
    kubectl apply -f jenkins.yml 

    kubectl apply -f jenkins_Service.yml
    
    kubectl apply -f ServiceAccount.yml

    kubectl apply -f slave-deploy.yaml

    kubectl apply -f slave-svc.yaml 

    kubectl apply -f volumes.yml

10- View all pods in  jenkins namespace
   
    kubectl get all -n jenkins
    
  - screen of all in jenkins namespace 
  
   <img src="ScreenShots/all-in-ns.png" width=400 >
   
11-Get a EXTERNAL-IP

   <img src="ScreenShots/get-ip-access-jenkins.png" width=400 >

12-Use EXTERNAL-IP and acces Jenkins 

   -Link of Jenkins:  http://34.139.44.40:8080
  
  <img src="ScreenShots/welcome-jenkins.png" width=400 >
  
 

# Second-Part

    Build CI/CD Pipeline using Jenkins 
    
Jenkins will do these things:

  - Build an image from Dockerfile

  - Push the image to DockerHub

  - Apply deployment for the app based on the image
 
  - Apply LoadBalancer service for the app

The Steps:

1- Create new node slave node and create credentials for it.

   <img src="ScreenShots/new-node-slave.png" width=400 >
   
 - Create credentials for slave node 
 
   <img src="ScreenShots/cred-slave.png" width=400 >

 - Configuration of the salve node
 
   <img src="ScreenShots/config-slave-node.png" width=400 >
   
 - SSH slave node and change passwd
 
   <img src="ScreenShots/ssh-slave-service.png" width=400 >
 
 - Connect to Cluster from through slave node 
 
   <img src="ScreenShots/connect-to-cluster-from-slave.png" width=400 >
 
 - Finally node successfully connected and online 
 
   <img src="ScreenShots/node-connected-successfully.png" width=400 >
   
 - Jenkins page after create slave node
 
   <img src="ScreenShots/jenkins-after-create-node.png" width=400 >

2- Create CI-CD Pipeline and The Pipeline will do.

 - Pull Code from GitHub

 - Build the Application image using Docker

 - Push Image to DockerHub

 - Trigger CD Pipeline to Run

 - Deploy our Application in GKE
 
The Steps:

 - Create name space for app application
  
  <img src="ScreenShots/create-ns-app.png" width=400 >
  
 - Create pipeline and add credential for it [Dockerhub Account]
 
  <img src="ScreenShots/cred-docker.png" width=400 >
  
  <img src="ScreenShots/congig-pipeline.png" width=400 >
  
 - Build and Deploy
  
  <img src="ScreenShots/build-deploy-success.png" width=400 >
  
  <img src="ScreenShots/build-deploy-success-2.png" width=400 >
   
 - Get Services and Ingress 
 
  <img src="ScreenShots/svc-ingress.png" width=400 >

 - Push image hello-world to Dockerhub Repository  
  
  <img src="ScreenShots/dockerhub-repo.png" width=400 >

 - Get IP and Access My App Page 
 
  <img src="ScreenShots/Ip-app.png" width=400 >

 - Finally Open My page  
 
  <img src="ScreenShots/my-app-page.png" width=400 >

 - Link To My Page : 
  
   http://35.231.6.0
   

