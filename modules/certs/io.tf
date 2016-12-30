variable "aws-region" {}

variable "internal-tld" {}

variable "k8s-service-ip" {}

output "root-cert" {
  value = "${ tls_self_signed_cert.root.cert_pem }"
}
output "etcd-cert" {
  value = "${ tls_locally_signed_cert.etcd.cert_pem }"
}
output "apiserver-cert" {
  value = "${ tls_locally_signed_cert.apiserver.cert_pem }"
}
output "admin-cert" {
  value = "${ tls_locally_signed_cert.admin.cert_pem }"
}
output "worker-cert" {
  value = "${ tls_locally_signed_cert.worker.cert_pem }"
}

output "root-key" {
  value = "${ tls_private_key.root.private_key_pem }"
}
output "etcd-key" {
  value = "${ tls_private_key.etcd.private_key_pem }"
}
output "apiserver-key" {
  value = "${ tls_private_key.apiserver.private_key_pem }"
}
output "admin-key" {
  value = "${ tls_private_key.admin.private_key_pem }"
}
output "worker-key" {
  value = "${ tls_private_key.worker.private_key_pem }"
}
