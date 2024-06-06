resource "google_compute_global_address" "lb_ext_ip_addr" {
  name         = "lb-ext-ip-addr"
  project      = var.project_id
}

resource "google_compute_backend_service" "http_lb_backend" {
  connection_draining_timeout_sec = 300
  health_checks                   = [google_compute_health_check.http_healthcheck.id]
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  locality_lb_policy              = "ROUND_ROBIN"
  name                            = "http-lb-backend"
  port_name                       = "http"
  project                         = var.project_id
  protocol                        = "HTTP"
  session_affinity                = "NONE"
  timeout_sec                     = 30

  backend {
    group = google_compute_instance_group.app_instancegroup.id
  }
}

resource "google_compute_global_forwarding_rule" "http_lb_frontend" {
  ip_address            = google_compute_global_address.lb_ext_ip_addr.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  name                  = "http-lb-frontend"
  port_range            = "80-80"
  project               = var.project_id
  target                = google_compute_target_http_proxy.http_lb_target_proxy.id
}

resource "google_compute_health_check" "http_healthcheck" {
  check_interval_sec = 5
  healthy_threshold  = 2
  name               = "http-healthcheck"
  project            = var.project_id

  tcp_health_check {
    port         = 80
    proxy_header = "NONE"
  }

  timeout_sec         = 5
  unhealthy_threshold = 2
}



resource "google_compute_target_http_proxy" "http_lb_target_proxy" {
  name    = "http-lb-target-proxy"
  project = var.project_id
  url_map = google_compute_url_map.http_loadbalancer.id
}

resource "google_compute_url_map" "http_loadbalancer" {
  default_service = google_compute_backend_service.http_lb_backend.id
  name            = "http-loadbalancer"
  project         = var.project_id
}