# create svc for vm
resource "google_service_account" "my-first-service-account" {
  account_id = "my-first-svc"                 # gke-admin
  display_name = "my-first-svc"               #k8s-admin
}
resource "google_project_iam_member" "project" {
  project = "esraa-abdelaziz"
  role   = "roles/container.admin"
  member = "serviceAccount:${google_service_account.my-first-service-account.email}"
}
#------------------------------------------------------------------------------------------------------------

# create vm-private
resource "google_compute_instance" "vm-private" {
  name         = "esraa-vm"
  machine_type = "e2-small"
  zone         = "us-east1-b"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.management-subnet.id
  }
  service_account {
    email  = google_service_account.my-first-service-account.email
    scopes = ["cloud-platform"]
  }
}




