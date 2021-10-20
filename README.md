## Summary

This repo will create a create your custom DocumentDB environment.

## Basic Architecture


## Step by Step Deployment


*  Update the `terraform.tfvars` file with region and aws account id.**
```shell script
$ cd tf-kylteq
$ cd environment
$ vi terraform.tfvars
```

### Ensure that flag `create_global` is set to `true`. So it will create a global database for your DocumentDB.
*  Update the `main.tf` file with your details.**
```shell script
$ vi main.tf
```

*  Create the resources using `terraform apply`. `THIS WILL TAKE AROUND 10 or so minutes`**
```shell script
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```

## Step by Step Deletion

### Ensure that flag `create_global` is set to `false`. So it will destroy the global database resources for your DocumentDB.
* **Step 1: Update the `create_global` flag at line 51 to `false`.**
```shell script
$ vi main.tf
```

* **Step 2: Run `terraform apply` to remove the awscli resources created for your DocumentDB global database. `THIS WILL TAKE AROUND 10 or so minutes`**
```shell script
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```

* **Step 3: Destroy the rest of your resources using `terraform destroy`. `THIS WILL TAKE AROUND 10 or so minutes`**
```shell script
$ terraform destroy --auto-approve
```
