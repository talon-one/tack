# root private key
resource "tls_private_key" "root" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "root" {
  key_algorithm   = "ECDSA"
  private_key_pem = "${tls_private_key.root.private_key_pem}"

  validity_period_hours = 26280
  early_renewal_hours   = 8760

  is_ca_certificate = true

  allowed_uses = ["cert_signing"]

  subject {
    common_name         = "Example Inc. Root"
    organization        = "Example, Inc"
    organizational_unit = "Department of Certificate Authority"
    street_address      = ["5879 Cotton Link"]
    locality            = "Pirate Harbor"
    province            = "CA"
    country             = "US"
    postal_code         = "95559-1227"
  }
}

resource "tls_private_key" "etcd" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_cert_request" "etcd" {
  key_algorithm   = "${tls_private_key.etcd.algorithm}"
  private_key_pem = "${tls_private_key.etcd.private_key_pem}"

  subject {
    common_name = "etcd.${var.internal-tld}"
  }

  dns_names = [
    "etcd.${var.internal-tld}",
    "etcd1.${var.internal-tld}",
    "etcd2.${var.internal-tld}",
    "etcd3.${var.internal-tld}",
  ]

  ip_addresses = ["127.0.0.1"]
}

resource "tls_locally_signed_cert" "etcd" {
  cert_request_pem = "${tls_cert_request.etcd.cert_request_pem}"

  ca_key_algorithm   = "${tls_private_key.root.algorithm}"
  ca_private_key_pem = "${tls_private_key.root.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.root.cert_pem}"

  validity_period_hours = 17520
  early_renewal_hours   = 8760

  allowed_uses = ["server_auth", "client_auth"]
}

resource "tls_private_key" "admin" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_cert_request" "admin" {
  key_algorithm   = "${tls_private_key.admin.algorithm}"
  private_key_pem = "${tls_private_key.admin.private_key_pem}"

  subject {
    common_name = "admin.${var.internal-tld}"
  }

  dns_names = [
    "kubernetes",
    "kubernetes.default",
    "kubernetes.svc",
    "kubernetes.svc.cluster.local",
    "*.*.compute.internal",
    "*.ec2.internal",
  ]
}

resource "tls_locally_signed_cert" "admin" {
  cert_request_pem = "${tls_cert_request.admin.cert_request_pem}"

  ca_key_algorithm   = "${tls_private_key.root.algorithm}"
  ca_private_key_pem = "${tls_private_key.root.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.root.cert_pem}"

  validity_period_hours = 17520
  early_renewal_hours   = 8760

  allowed_uses = ["server_auth", "client_auth"]
}

resource "tls_private_key" "apiserver" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_cert_request" "apiserver" {
  key_algorithm   = "${tls_private_key.apiserver.algorithm}"
  private_key_pem = "${tls_private_key.apiserver.private_key_pem}"

  subject {
    common_name = "master.${var.internal-tld}"
  }

  dns_names = [
    "kubernetes",
    "kubernetes.default",
    "kubernetes.svc",
    "kubernetes.svc.cluster.local",
    "master.${var.internal-tld}",
    "*.${var.aws-region}.elb.amazonaws.com",
  ]

  ip_addresses = ["127.0.0.1", "${var.k8s-service-ip}"]
}

resource "tls_locally_signed_cert" "apiserver" {
  cert_request_pem = "${tls_cert_request.apiserver.cert_request_pem}"

  ca_key_algorithm   = "${tls_private_key.root.algorithm}"
  ca_private_key_pem = "${tls_private_key.root.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.root.cert_pem}"

  validity_period_hours = 17520
  early_renewal_hours   = 8760

  allowed_uses = ["server_auth", "client_auth"]
}

resource "tls_private_key" "worker" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_cert_request" "worker" {
  key_algorithm   = "${tls_private_key.worker.algorithm}"
  private_key_pem = "${tls_private_key.worker.private_key_pem}"

  subject {
    common_name = "worker.${var.internal-tld}"
  }

  dns_names = [
    "kubernetes",
    "kubernetes.default",
    "kubernetes.svc",
    "kubernetes.svc.cluster.local",
    "*.*.compute.internal",
    "*.ec2.internal",
  ]

  ip_addresses = ["127.0.0.1"]
}

resource "tls_locally_signed_cert" "worker" {
  cert_request_pem = "${tls_cert_request.worker.cert_request_pem}"

  ca_key_algorithm   = "${tls_private_key.root.algorithm}"
  ca_private_key_pem = "${tls_private_key.root.private_key_pem}"
  ca_cert_pem        = "${tls_self_signed_cert.root.cert_pem}"

  validity_period_hours = 17520
  early_renewal_hours   = 8760

  allowed_uses = ["client_auth"]
}
