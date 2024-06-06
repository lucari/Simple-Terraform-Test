##################################################################################
##                   GCP PARAMETERS                                             ##
##################################################################################

credentials_file            = "./svc-acct.json"
project_service_account     = ""
project_id                  = "playground-s-11-7b5db2df"
vpc_id                      = "vpc-p-rjp-base-spoke"
region                      = "europe-west1"
primary_zone                = "europe-west1-b"

##################################################################################
##                   NW PARAMETERS                                             ##
##################################################################################

subnet_name      = "sb-rjp-tst-euw3"
subnet_cidr      = "10.4.21.0/28"


##################################################################################
##                   VM PARAMETERS                                             ##
##################################################################################

app_servers = {
    richy-vm1 = {
        machine_type = "e2-micro"
        ip_address = "10.4.21.3"
        network_tags = ["allow-iap", "allow-hc", "allow-web"]
        data_disk_type = "pd-standard"
        data_disk_size = "10"
    },
    richy-vm2 = {
        machine_type = "e2-micro"
        ip_address = "10.4.21.4"
        network_tags = ["allow-iap", "allow-hc", "allow-web"]
        data_disk_type = "pd-standard"
        data_disk_size = "10"
    }

}



