
resource "google_service_account" "my-gke-svc" {
  project = "esraa-abdelaziz"
  account_id = "my-svc-gke"
  display_name = "my-svc-gke"

}
resource "google_project_iam_member" "cluster" {
  project = "esraa-abdelaziz"
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.my-gke-svc.email}"
}

# -----------------------------------------
resource "google_container_cluster" "my-gke" {
  name               = "esraa-cluster"
  location           = "us-east1-b"
  initial_node_count = "1"
  remove_default_node_pool = true
  network                  = google_compute_network.vpc.id
  subnetwork               = google_compute_subnetwork.restricted-subnet.id

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.16.0.0/16"
    services_ipv4_cidr_block = "10.12.0.0/16"
  }
  
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = google_compute_subnetwork.management-subnet.ip_cidr_range
      display_name = "sub1-cidr-range"
    }
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28" 
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
  release_channel {
    channel = "REGULAR"
  }
  
#    workload_identity_config {
# #     workload_pool = "first-project-2030.svc.id.goog"
#       workload_pool = "esraa-abdelaziz.my-first-service-account.id.goog"
# # }
#  }
}
#------------------------------------------------------------------

resource "google_container_node_pool" "my-gke-node-pool" {
  name = "esraa-node-pool"
  cluster = google_container_cluster.my-gke.id
  node_count = "1"
  location = "us-east1-b"

  management {
    auto_repair  = true
    auto_upgrade = true
  }


  node_config {
    preemptible  = false
    machine_type = "e2-standard-4"
    # disk_type = "pd-standard"
    # disk_size_gb = 20
    # labels = {
    #   role = "general"
    # }
    

    service_account = google_service_account.my-gke-svc.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
     ]
  }
}



