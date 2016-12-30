data "template_file" "kubeconfig" {
  template = <<EOF

mkdir -p credentials
echo '${ var.root-cert }' > credentials/root-cert.pem
echo '${ var.admin-cert }' > credentials/admin-cert.pem
echo '${ var.admin-key }' > credentials/admin-key.pem

kubectl config set-cluster ${ var.name }-cluster \
  --embed-certs=true \
  --server=https://${ var.master-elb } \
  --certificate-authority=credentials/root-cert.pem

kubectl config set-credentials ${ var.name }-admin \
  --embed-certs=true \
  --certificate-authority=credentials/root-cert.pem \
  --client-key=credentials/admin-key.pem \
  --client-certificate=credentials/admin-cert.pem

kubectl config set-context ${ var.name } \
  --cluster=${ var.name }-cluster \
  --user=${ var.name }-admin

# Run this command to configure your kubeconfig:
# eval $(terraform output kubeconfig)
EOF
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = <<LOCAL_EXEC
${data.template_file.kubeconfig.rendered}
LOCAL_EXEC
  }

}
