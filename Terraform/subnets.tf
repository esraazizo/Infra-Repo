resource "google_compute_subnetwork" "management-subnet" {
  name          = "management-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-east1"
  network       = google_compute_network.vpc.id
  private_ip_google_access = true

}

#-------------------------------------------------------------------------

resource "google_compute_subnetwork" "restricted-subnet" {
  name          = "restricted-subnet"
  ip_cidr_range = "10.1.0.0/24"
  region        = "us-east1"
  network       = google_compute_network.vpc.id
  private_ip_google_access = true

  #private_ip_google_access = true
  secondary_ip_range {
    range_name    = "k8s-pod-range-1"
    ip_cidr_range = "10.32.0.0/14"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range-1"
    ip_cidr_range = "10.2.0.0/16"
  }
}



