variable "project" { }

variable "credentials_file" { }

variable "create_ai_notebook" { 
  type = number
  default = 0
}

variable "region" {
  default = "australia-southeast1"
}

variable "zone" {
  default = "australia-southeast1-c"
}
