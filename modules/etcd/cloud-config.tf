data "template_file" "cloud-config" {
  count = "${ length( split(",", var.etcd-ips) ) }"
  template = "${ file( "${ path.module }/cloud-config.yml" )}"

  vars {
    cluster-domain = "${ var.cluster-domain }"
    cluster-token = "etcd-cluster-${ var.name }"
    dns-service-ip = "${ var.dns-service-ip }"
    etc-tar = "/manifests/etc.tar"
    fqdn = "etcd${ count.index + 1 }.${ var.internal-tld }"
    hostname = "etcd${ count.index + 1 }"
    hyperkube = "${ var.hyperkube-image }:${ var.hyperkube-tag }"
    hyperkube-image = "${ var.hyperkube-image }"
    hyperkube-tag = "${ var.hyperkube-tag }"
    internal-tld = "${ var.internal-tld }"
    pod-ip-range = "${ var.pod-ip-range }"
    service-cluster-ip-range = "${ var.service-cluster-ip-range }"
    cert-path = "/etc/kubernetes/ssl"
    root-cert = "${ var.root-cert }"
    etcd-cert = "${ var.etcd-cert }"
    apiserver-cert = "${ var.apiserver-cert }"

    etcd-key = "${ var.etcd-key }"
    apiserver-key = "${ var.apiserver-key }"
  }
}
