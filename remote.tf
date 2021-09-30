terraform {
   backend "remote" {
     hostname     = "app.terraform.io"
     organization = "sg-tech"
 
     workspaces {
       name = "terraform-aws-vpc"
     }
   }
}
