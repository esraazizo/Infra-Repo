resource "google_compute_network" "vpc" {
  name = "esraa-vpc"
  auto_create_subnetworks = false
  project = "esraa-abdelaziz"
  routing_mode  = "REGIONAL"
  delete_default_routes_on_create = false
}

#-----------------------------------------------------------------
 
resource "google_compute_firewall" "my-firewall" {
  name    = "esraa-firewall"
  network = google_compute_network.vpc.name
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22" , "80"]
  }
}
# resource "google_compute_firewall" "my-firewall-e" {
#   name    = "esraa-firewall-e"
#   network = google_compute_network.vpc.id
#   direction     = "EGRESS"
#   #source_ranges = ["0.0.0.0/0"]
#   allow {
#     protocol = "all"
#   }
# }