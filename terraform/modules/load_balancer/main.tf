resource "yandex_alb_target_group" "web_tg" {
  name = "web-target-group"

  target {
    ip_address = var.target_ips[0]
    subnet_id  = var.private_subnet_a_id
  }

  target {
    ip_address = var.target_ips[1]
    subnet_id  = var.private_subnet_b_id
  }
}

resource "yandex_alb_backend_group" "web_bg" {
  name = "web-backend-group"

  http_backend {
    name             = "web-backend"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_alb_target_group.web_tg.id]

    healthcheck {
      timeout  = "1s"
      interval = "5s"
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
    name = "default-route"

    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.web_bg.id
      }

      http_match {
        path {
          prefix = "/"
        }
      }
    }
  }
}

resource "yandex_alb_load_balancer" "web_alb" {
  name               = "web-alb"
  network_id         = var.network_id
  security_group_ids = [var.web_sg]

  allocation_policy {
    location {
      zone_id   = var.zone
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

    http {}
  }

  depends_on = [
    yandex_alb_http_router.web_router,
    yandex_alb_virtual_host.web_vhost,
    yandex_alb_backend_group.web_bg
  ]
}
