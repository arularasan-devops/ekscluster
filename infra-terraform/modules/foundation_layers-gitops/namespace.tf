resource "kubernetes_namespace" "app_namespace" {
  for_each = { for i, v in var.app_namespace : i => v }
  metadata {
    annotations = {
      name = var.app_namespace[each.key].namespace_name
    }
    labels = {
      istio-injection = "enabled"
    }
    name = var.app_namespace[each.key].namespace_name
  }
}

resource "kubernetes_namespace" "system_namespace" {
  for_each = { for i, v in var.foundationlayer_namespace : i => v }
  metadata {
    annotations = {
      name = var.foundationlayer_namespace[each.key].namespace_name
    }

    name = var.foundationlayer_namespace[each.key].namespace_name
  }
}

resource "kubectl_manifest" "argoproject" {
   depends_on = [
     kubernetes_namespace.app_namespace
   ]
    yaml_body = file("${path.module}/argoapps/argoproject.yml")
}


resource "kubectl_manifest" "cluster-autoscaler" {
   depends_on = [
     kubernetes_namespace.app_namespace
   ]
    yaml_body = templatefile("${path.module}/argoapps/cluster-autoscaler.yml", { env = var.env })
}


resource "kubectl_manifest" "ebs-csi" {
   depends_on = [
     kubernetes_namespace.app_namespace
   ]
    yaml_body = templatefile("${path.module}/argoapps/ebs-csi.yml", { env = var.env })
}

resource "kubectl_manifest" "external-dns" {
   depends_on = [
     kubernetes_namespace.app_namespace
   ]
    yaml_body = templatefile("${path.module}/argoapps/external-dns.yml", { env = var.env })
}

resource "kubectl_manifest" "loadbalancercontroller" {
   depends_on = [
     kubernetes_namespace.app_namespace
   ]
    yaml_body = templatefile("${path.module}/argoapps/loadbalancercontroller.yml", { env = var.env })
}

resource "kubectl_manifest" "metric-server" {
   depends_on = [
     kubernetes_namespace.app_namespace
   ]
    yaml_body = templatefile("${path.module}/argoapps/metric-server.yml", { env = var.env })
}

resource "kubectl_manifest" "istio-base" {
   depends_on = [
     kubernetes_namespace.app_namespace
   ]
    yaml_body = templatefile("${path.module}/argoapps/istio-base.yml", { env = var.env })
}

resource "kubectl_manifest" "istiod" {
   depends_on = [
     kubernetes_namespace.app_namespace
   ]
    yaml_body = templatefile("${path.module}/argoapps/istiod.yml", { env = var.env })
}

resource "kubectl_manifest" "istio-ingress" {
   depends_on = [
     kubernetes_namespace.app_namespace
   ]
    yaml_body = templatefile("${path.module}/argoapps/metric-server.yml", { env = var.env })
}


