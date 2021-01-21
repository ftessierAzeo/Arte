terraform {
    required_version = ">= 0.12"
}


terraform {
       backend "remote" {
         # The name of your Terraform Cloud organization.
         organization = "ftessier"

         # The name of the Terraform Cloud workspace to store Terraform state files in.
         workspaces {
           name = "Demo-Arte"
         }
       }
     }