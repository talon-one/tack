data "template_file" "user-data" {
  template = "${ file( "${ path.module }/user-data.yml" )}"

  vars {
    internal-tld = "${ var.internal-tld }"
    cert-path = "/etc/kubernetes/ssl"
    root-cert = "${ var.root-cert }"
    etcd-cert = "${ var.etcd-cert }"
    etcd-key = "${ var.etcd-key }"
  }
}
