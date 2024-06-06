

resource "google_compute_disk" "app_data_disk" {
  project = var.project_id
  for_each = var.app_servers
  name = "${each.key}-data-disk"
  type = each.value.data_disk_type
  size = each.value.data_disk_size
  zone = var.primary_zone
}

resource "google_compute_attached_disk" "app_data_disk_attach" {
  project = var.project_id
  for_each = var.app_servers
  device_name = "data"
  disk = google_compute_disk.app_data_disk[each.key].self_link
  instance = google_compute_instance.app-server[each.key].self_link

}


resource "google_compute_instance" "app-server" {
    project = var.project_id
    for_each = var.app_servers
    zone = var.primary_zone
    name = each.key
    machine_type = each.value.machine_type
    tags = each.value.network_tags

    network_interface {
      network_ip = each.value.ip_address
      subnetwork = google_compute_subnetwork.subnetwork.id
    }

    depends_on = [google_compute_router_nat.main, google_compute_router.router]
    
    metadata_startup_script = <<SCRIPT
      #!/usr/bin/bash
      echo "Startup script is running" >/tmp/startup.out
      apt-get update && apt install -y apache2
      HOSTNAME=`hostname`
      WEBFILE=/var/www/html/index.html
      echo "<HTML>"  >$WEBFILE
      echo "<HEAD><TITLE>This is $HOSTNAME</TITLE></HEAD>" >> $WEBFILE
      echo "<BODY>" >> $WEBFILE
      echo "<H1>This is $HOSTNAME</H1>" >> $WEBFILE
      echo "" >> $WEBFILE
      echo "Welcome to $HOSTNAME" >> $WEBFILE
      echo "" >> $WEBFILE
      echo "</BODY>" >> $WEBFILE
      echo "</HTML>" >> $WEBFILE
      echo "Startup script has completed" >>/tmp/startup.out
      SCRIPT


    boot_disk {
      device_name = "${each.key}-boot"

      initialize_params {
        size = 10
        type = "pd-standard"
        #image = "projects/debian-cloud/global/images/debian-11-bullseye-v20221206"
        image = "family/debian-11"
      }
    }

    lifecycle {
      ignore_changes = [attached_disk]
    }
}

resource "google_compute_instance_group" "app_instancegroup" {
  instances = [for appsvr in google_compute_instance.app-server : appsvr.self_link]
  name      = "app-instancegroup"

  named_port {
    name = "http"
    port = 80
  }

  network = google_compute_network.vpc_network.id
  project = var.project_id
  zone    = var.primary_zone
}

