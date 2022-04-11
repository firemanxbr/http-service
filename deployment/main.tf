resource "kind_cluster" "this" {
  name            = var.cluster_name
  node_image      = "${var.node_image}:v${var.kubernetes_version}"
  wait_for_ready  = true
  kubeconfig_path = null

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    dynamic "node" {
      for_each = var.nodes
      content {
        role = node.value["role"]

        dynamic "extra_port_mappings" {
          for_each = node.value["extra_port_mappings"] == null ? [] : [node.value["extra_port_mappings"]]
          content {
            listen_address = extra_port_mappings.value["listen_address"]
            container_port = extra_port_mappings.value["container_port"]
            host_port      = extra_port_mappings.value["host_port"]
            protocol       = extra_port_mappings.value["protocol"]
          }
        }

        kubeadm_config_patches = node.value["kubeadm_config_patches"]
      }
    }

    containerd_config_patches = var.containerd_config_patches
  }
}
