Select your appropriate backend for your account/region/environment


```terrafrom init --backend-config=account/us-west-2/dev/backend.tfvars```


Run your terraform `plan` and `apply` using the tfvar files for the same account/region/environment

```terraform plan --var-file=account/account.tfvars --var-file=accont/us-west-2.tfvars --var-file=account/us-west-2/dev/dev.tfvars```

```terraform apply --var-file=account/account.tfvars --var-file=accont/us-west-2.tfvars --var-file=account/us-west-2/dev/dev.tfvars```


This allows you to set variables for a account/region that can be shared between (and overwritten by precedence) different environments.