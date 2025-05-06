terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_alb_target_group" "web_tg" {
  name = "web-target-group"
  target {
    subnet_id = var.subnet_id
    ip_address = var.target_ips[0]
  }
  target {
    subnet_id = var.subnet_id
    ip_address = var.target_ips[1]
  }
}

resource "yandex_alb_backend_group" "web_bg" {
  name = "web-backend-group"
  http_backend {
    name              = "web-backend"
    port             = 80
    target_group_ids = [yandex_alb_target_group.web_tg.id]
    healthcheck {
      interval = "10s"
      timeout  = "5s"
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "web_router" {
  name = "web-router"
}

resource "yandex_alb_virtual_host" "web_vhost" {
  name           = "web-vhost"
  http_router_id = yandex_alb_http_router.web_router.id
  authority      = ["*"]

  route {
    name = "web-route"
    http_route {
      http_match {
        path {
          prefix = "/"
        }
      }

      http_route_action {
        backend_group_id = yandex_alb_backend_group.web_bg.id
      }
    }
  }
}

resource "yandex_alb_load_balancer" "web_alb" {
  name       = "web-alb"
  network_id = var.network_id
  security_group_ids = [var.web_sg]
  allocation_policy {
    location {
      zone_id   = var.zone_1
      subnet_id = var.subnet_id
    }
  }
  listener {
    name = "http-listener"
    endpoint {
      address {
        external_ipv4_address {}
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.web_router.id
      }
    }
  }
}
