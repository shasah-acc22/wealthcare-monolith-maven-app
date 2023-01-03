# wealthcare-monolith-maven-app
 WealthCare is a microservice application deployed using Maven.

## PERSONAS

The application consists of the below 3 Personas.

### 1) Business Manager

Business Manager can do the following operations.

- Creates Wealth manager
- Creates Customer 
- Assign Wealth manager to the customer

### 2) Wealth Manager

Wealth Manager can do the following operations.

- Manage financial plan for Customer
- Create Goals
- Create Investment
- View Customer Portfolio
- View Customer profile

### 3) Customer

Customer can do the following operations.

- View Financial Plan
- View Portfolio
- View Profile

## LICENSE

The Wealthcare monolith Application is licensed under Apache-2.0 License.

## TOOLS AND TECHNOLOGIES

- Java
- EJB
- Websphere
- DB2 database

## DEPLOYING THE APPLICATION IN OPENSHIFT

### Prerequisites

- 1) Install the below dependencies in your Openshift Environment.
```
sudo yum install docker
sudo yum install maven
```
- 2) Fork the git repository and then clone it into your environment. Use you Personal Access Token if needed.

- 3) Go to the below folder and build the EAR file.
```
ls
cd wealthcare-monolith-maven-app/config/
ls
chmod +x 01-buildEar.sh 03-build-dockerhub.sh
ls
./01-buildEar.sh
```

- 4) Check if the OpenShift Image Registry is present in your environment.
```
oc get route -n openshift-image-registry
oc get route -n openshift-image-registry | awk '{print $2}' | awk 'NR==2'

# Change the path below
docker login -u $(oc whoami) -p $(oc whoami -t) <above-image-registry-path>

# Check if docker pull is successful
docker pull hello-world

```

- 5) Create a project namespace.
```
cd wealthcare-monolith-maven-app/config/
oc create -f 02-namespace.yaml
oc project wealthcare-monolith-ns
```

- 6) Build the docker hub file.
```
cd wealthcare-monolith-maven-app/config/
./03-build-dockerhub.sh
```

- 7) Check if the image was successfully pulled and tagged
```
oc get images | grep monolith
```

- 8) Create a MYSQL Database in the namespace.
```
oc new-app -e MYSQL_USER=admin -e MYSQL_PASSWORD=admin -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=BLUDB mysql:latest
oc expose service/mysql

# Get the pod name
oc get pods

# Login into the mysql pod bash
oc rsh <mysql-pod-name>

#Login as the admin user. you have to provide the password as well.
mysql -u admin -p

# Check if your database is listed and then use the same.
show databases;
use BLUDB;

# Check if any tables are listed.
show tables;

# Copy the MySQL Schema and Data from the wealthcare-monolith-maven-app/sql/ path.
# Copy the content from both the .sql files and paste in the mysql bash itself.

# Check if the tables were created and populated properly.
show tables;
select * from WCUSERS;
```
-9)  Create a Config Map in the project namespace. Before running the command, go to the file and change the URL path (add your cluster URL) and the MYSQL connection credentials (only if you have changed the username and password for the same)
```
cd wealthcare-monolith-maven-app/config/
oc create -f 04-config-map.yaml
```

- 10) Deploy the Wealthcare application using the below yaml file. Before running the command, go to the file and change the image name (add your cluster URL).
```
cd wealthcare-monolith-maven-app/config/
oc create -f 05-monolith.yaml
```

- 11) Ensure if all the deployments are Running and in Ready State (1/1).
```
oc get all
```

- 12) Access the console through "wealthcare-monolith-app" Route created in the namespace. You need to add the following path to the Route URL.
```
  <route-URL>/wcareWeb/
```

- 13) Use the below Personas to login and check for the functionalities.
  ##### Username / Password -------- Persona
       1) sam / sam      --------     Wealth Manager
       2) harry / harry  --------     Business Manager
       3) sandy / sandy  --------     Customer
