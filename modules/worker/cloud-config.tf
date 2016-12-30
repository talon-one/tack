data "template_file" "cloud-config" {
  template = "${ file( "${ path.module }/cloud-config.yml" )}"

  vars {
    cluster-domain = "${ var.cluster-domain }"
    dns-service-ip = "${ var.dns-service-ip }"
    hyperkube-image = "${ var.hyperkube-image }"
    hyperkube-tag = "${ var.hyperkube-tag }"
    internal-tld = "${ var.internal-tld }"
    cert-path = "/etc/kubernetes/ssl"
    root-cert = "${ var.root-cert }"
    worker-cert = "${ var.worker-cert }"
    worker-key = "${ var.worker-key }"
  }
}
