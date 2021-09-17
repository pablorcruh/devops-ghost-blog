# DEVOPS GHOST BLOG

## Description

The following project contains an Infrastructure as Code deployment
of a popular Ghost Content Management System using terraform

The deployment will be on Digital Ocean Droplet using a specific domain
and creating a DNS record.

Terraform as Infrastructure as Code tool can be used on many cloud providers
but in this case for simplicity and cost we choose to work with Digital Ocean,
but the provider and cloud specific modules can be replaced as needed for other provider

The project has the following files:

* dns.tf -> has information about the digital ocean dns
* docker-compose.yml -> has all the container setup to start the CMS
* server-keys -> the folder contains the private and public key
* provider -> has the provider configuration
* ssh_key.tf -> has the public key configuration to be passed to the droplet
* terraform.tfvars -> has the DigitalOcean API key, file never uploaded to the repository
* userdata.yaml -> has all software provisioning inside the droplet and executes some commands
* .env -> has environment variables used to configure the containers
* .env.example -> example file of .env

We need a ssh key to access droplet within our project, so we create a folder for all keys, we create new keys so we don't override our ssh keys on our machine.

On the root of the project we create a folder and generate the ssh keys


```
    mkdir server_keys
    ssh-keygen -b 4096
    
    
    Generating public/private rsa key pair.
    Enter file in which to save the key (/path/to/.ssh/id_rsa): /path/to/project/server_keys/id_rsa
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in /path/to/project/devops_ghost_blog/server_keys/id_rsa.

```
We need an environment variables so we need to create a .env file on the root of the project

```
    GHOST_URL=https://your.domain.com
    GHOST_VIRTUAL_HOST=your.domain.com
    DATABASE_PASSWORD=database_password
    SUPPORT_EMAIL=support@email.com
    DATABASE_USER=root
```
To start the project

```
    terraform init
```

We use terraform to download all the components needed for the provider specified

To finish we apply all the changes on our infrastructure as we planned

In case you need to understand the variables used in the configuration we supply the **terraform.tfvars** structure

We need to create a file called terraform.tfvars with the following structure

```
    do_token="DIGITAL_OCEAN_API_KEY"
    file_path="file/path/from/source/project"
    domain="ghost.your.domain"
```

The domain on the terraform.tfvars is a subdomain that we specify to create a A record on de Digital Ocean DNS record
In the example we specify ghost.your.domain that will be created

We specify the path to the project so terraform can locate the docker-compose file.

```
     terraform plan
```

We use terraform to generate an output describing all changes to be executed on our infrastructure.

```
    terraform apply
```

In case you need to access to ghost server for the first time you need to ssh into the droplet.

```
    ssh -i server_keys/id_rsa root@droplet_ip_address 

```

## Note

To access to the admin console on the CMS

* https://your.domain.com/ghost/

You wil be redirect to setup a admin user and a password to manage the blog

