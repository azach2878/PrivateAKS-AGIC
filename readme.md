## Fully Private AKS

Fully Private AKS Cluster. | Green Field
Using Firewall / NVA & Application Gateway AGIC (Ingress Controller) Using Terraform.
##
## Best practices for cluster isolation in Azure Kubernetes Service (AKS) 
Kubernetes provides features that let you logically isolate teams and workloads in the same cluster. 
The goal should be to provide the least number of privileges, scoped to the resources each team needs. 
A Namespace in Kubernetes creates a logical isolation boundary. 
Additional Kubernetes features and considerations for isolation and multi-tenancy include the following areas:
- Scheduling includes the use of basic features such as resource quotas and pod disruption budgets.
- Networking includes the use of network policies to control the flow of traffic in and out of pods.
- Authentication and authorization include the user of role-based access control (RBAC) and Azure Active Directory (AD) integration, pod identities, and secrets in Azure Key Vault.
- Containers includes the Azure Policy Add-on for AKS to enforce pod security, the use of pod security contexts, and scanning both images and the runtime for vulnerabilities. Also involves using App Armor or Seccomp (Secure Computing) to restrict container access to the underlying node.

![image](https://user-images.githubusercontent.com/51384650/131776942-cd9079c3-067c-4e13-b474-f8a8dc88c22b.png)
##
## Isolate your AKS workload logically. 
Best practice guidance: 
      Use logical isolation to separate teams and projects. Try to minimize the number of physical AKS clusters you deploy to isolate teams or applications.
With logical isolation, a single AKS cluster can be used for multiple workloads, teams, or environments. Kubernetes Namespaces form the logical isolation boundary for workloads and resources. 

Logical separation of clusters usually provides a higher pod density than physically isolated clusters. There's less excess compute capacity that sits idle in the cluster. 
When combined with the Kubernetes cluster Auto-Scaler, you can scale the number of nodes up or down to meet demands. This best practice approach to autoscaling lets you run only the number of nodes required and minimizes costs.

![image](https://user-images.githubusercontent.com/51384650/131777503-1b42ec2b-07bc-4e4b-a3d1-d325db9fd6f6.png)
## 

## Best Practices for Network Connectivity and Security in Azure Kubernetes Service (AKS) 
As you create and manage clusters in Azure Kubernetes Service (AKS), you provide network connectivity for your nodes and applications. These network resources include IP address ranges, load balancers, and ingress 
controllers. To maintain a high quality of service for your applications, you need to plan for and then configure these resources.

Private AKS Cluster: You can tighten the security around your AKS Cluster by deploying private AKS. 
In a private cluster, the control plane or API server has internal IP addresses. By using a private cluster, you can ensure network traffic between your API server and your node pools remains on the private network only. 

## Choose the appropriate network model: 
  Best practice guidance - For integration with existing virtual networks or on-premises networks, use Azure CNI networking in AKS. This network model also allows greater separation of resources and controls in an enterprise environment. 

AKS Network Types; 
  1- Kubenet networking: Azure manages the virtual network resources as the cluster is deployed and uses the kubenet Kubernetes plugin. 
  2- Azure CNI: “Advanced Networking” Deploys into a virtual network, and uses the Azure Container Networking Interface (CNI) Kubernetes plugin. 
     Pods receive individual IPs that can route to other network services or on-premises resources. 

When you use Azure CNI networking, the virtual network resource is in a separate resource group to the AKS cluster. 
Delegate permissions for the AKS service principal to access and manage these resources. 
The service principal used by the AKS cluster must have at least Network Contributor permissions on the subnet within your virtual network. 

## Identity and security management 
To limit access to cluster resources, AKS supports Kubernetes role-based access control (Kubernetes RBAC). 
Kubernetes RBAC lets you control access to Kubernetes resources and namespaces, and permissions to those 
resources. 

You can also configure an AKS cluster to integrate with Azure Active Directory (AD). With Azure AD integration, Kubernetes access can be configured based on existing identity and group membership. 
Your existing Azure AD users and groups can be provided access to AKS resources and with an integrated sign-on experience. 

## AKS-managed Azure Active Directory integration 
AKS-managed Azure AD integration is designed to simplify the Azure AD integration experience, where users were previously required to create a client app, a server app, and required the Azure AD tenant to grant Directory Read permissions. 
In the new version, the AKS resource provider manages the client and server apps for you. 

## Azure AD authentication 
Cluster administrators can configure Kubernetes role-based access control (Kubernetes RBAC) based on a user's identity or directory group membership. 
Azure AD authentication is provided to AKS clusters with OpenID Connect. OpenID Connect is an identity layer built on top of the OAuth 2.0 protocol. 

## Limitations 
  1- AKS-managed Azure AD integration can't be disabled "Once it's enabled can't be disabled" 
  2- Non-Kubernetes RBAC enabled clusters aren't supported for AKS-managed Azure AD integration 
  3- Changing the Azure AD tenant associated with AKS-managed Azure AD integration isn't supported 

## Distribute Ingress Traffic: 
Best practice guidance - To distribute HTTP or HTTPS traffic to your applications, use ingress resources and controllers. 
Ingress controllers provide additional features over a regular Azure load balancer (Layer 4 LB), and can be managed as native Kubernetes resources. 
An ingress controller is a piece of software that provides reverse proxy, configurable traffic routing, and TLS termination for Kubernetes services. 

Kubernetes ingress resources are used to configure the ingress rules and routes for individual Kubernetes services. Using an ingress controller and ingress rules, a single IP address can be used to route traffic to multiple services in a Kubernetes cluster. 

Note: An Azure load balancer can distribute customer traffic to applications in AKS cluster, but it's limited in what it understands about that traffic. 
A load balancer resource works at layer 4, and distributes traffic based on protocol or ports. 
Most web applications that use HTTP or HTTPS should use Kubernetes ingress resources and controllers, which work at layer 7. 

Ingress can distribute traffic based on the URL of the application and handle TLS/SSL termination. This ability also reduces the number of IP addresses you expose and map. 
With a load balancer, each application typically needs a public IP address assigned and mapped to the service in the AKS cluster. With an ingress resource, a single IP address can distribute traffic to multiple applications. 
There are many 3rd party Ingress controllers available for use with AKS. The Most common Ingress controller for Azure Kubernetes Services AKS: 
- NGINX Ingress Controller 
- Azure Application Gateway 
 
## Deploying NGINX Ingress Controller is fairly simple and straightforward. 
To create the ingress controller, use Helm to install nginx-ingress. For added redundancy, two replicas of the NGINX ingress controllers are deployed with the --set controller.replicaCount parameter. 
To fully benefit from running replicas of the ingress controller, make sure there is more than one node in your AKS cluster. 

The ingress controller also needs to be scheduled on a Linux node. Windows Server nodes shouldn't run the ingress controller. A node selector is specified using the --set nodeSelector parameter to tell the Kubernetes scheduler to run the NGINX ingress controller on a Linux-based node.  However, in this deployment I’m going to deploy Azure Application Gateway, Firewall and setup AGIC. Which is more complex (Also in the scenario: Assuming that our customer disallows Public IPs)

## Application Gateway Ingress Controller: 
The Application Gateway Ingress Controller (AGIC) allows Azure Application Gateway to be used as the ingress for an Azure Kubernetes Service aka AKS cluster. 

![image](https://user-images.githubusercontent.com/51384650/131778858-be198d4b-d5b5-4f3c-885a-83f3b25546b6.png)

## How AGIC Works. 
The Kubernetes Ingress resource can be annotated with arbitrary key/value pairs. AGIC relies on annotations to program Application Gateway features, which are not configurable via the Ingress YAML. Ingress annotations are applied to all HTTP setting, backend pools and listeners derived from an ingress resource. 

## Backend Path Prefix 
This annotation allows the backend path specified in an ingress resource to be re-written with prefix specified in this annotation. 
This allows users to expose services whose endpoints are different than endpoint names used to expose a service in an ingress resource. 
