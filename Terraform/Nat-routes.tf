resource "google_compute_router_nat" "my-nat" {
  name                               = "esraa-nat"
  router                             = google_compute_router.router.name
  region                             = "us-east1"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"

  
}


#----------------------------------------------------------------------

resource "google_compute_router" "router" {
  name    = "esraa-router"
  region  = "us-east1"
  network = google_compute_network.vpc.id
}



