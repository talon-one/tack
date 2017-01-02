
# When Kubernetes schedules a service of type LoadBalancer to run on a node, it
# _modifies_ the ingress rules of the first security group it finds for that
# node.
#
# Putting an empty security group first in the list, and telling Terraform to
# ignore subsequent changes to the ingress rules, allows Kubernetes to manage
# the ingress rules without conflicts.
resource "aws_security_group" "kubernetes_elb_ingress" {
  description = "Created by Terraform, managed by Kubernetes"
  vpc_id = "${ var.vpc-id }"
  lifecycle {
    ignore_changes = ["ingress"]
  }
}
