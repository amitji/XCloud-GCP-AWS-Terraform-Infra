XCloud Project's objective is to build similar infrastructure on both AWS and GCP to have multi cloud infrastructure for an organization for their business critical applications. 

Example I have taken to build and Infra is as follows - 
A simple applications where you need webservers to serve the traffic from across different regions, microservices on backend to serve the business logic, a database for persistence. And since this is business critical application, you want this application to be secure, highly available and fault tolerant, so we need auto scaling and load balancing and some security rules to define & limit access to these resources.

Will create following resources for both AWS and GCP - 

  a. VM machines
  b. sql database  
  c. vpc,firewalls 
  d. web-server 
  e. load balancer, auto scaler
