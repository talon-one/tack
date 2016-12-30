variable "admin-key" {}
variable "admin-cert" {}
variable "root-cert" {}
variable "master-elb" {}
variable "name" {}

output "kubeconfig" { value = "${ data.template_file.kubeconfig.rendered }" }
