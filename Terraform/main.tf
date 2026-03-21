provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Firewall to allow HTTP (port 80)
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80","9090","3001"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# VM Instance
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-vm"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

# Startup script to install Docker & run app
metadata_startup_script = <<EOF
#!/bin/bash
set -e
# Log everything
exec > /var/log/startup-script.log 2>&1
# Install Docker if not installed
            if ! command -v docker &> /dev/null
            then
                echo "Docker not found, installing..."
                sudo apt update
                sudo apt install -y docker.io
                sudo systemctl start docker
                sudo systemctl enable docker
            fi
            
            #Below commands was for running container directly from pulled image so unable to run all containers like graphana and prometheus separately on different ports hence commented
            #Pull Image
            #docker pull var.docker_user/node-devops-app-p1:latest
            
            #Stop old container and remove
            #docker stop node-devops-app-p1 || true
            #docker rm node-devops-app-p1 || true
            
            #Run new container on port 80 of server
            #docker run -d -p 80:3000 --name node-devops-app-p1 var.docker_user/node-devops-app-p1:latest

            #Below code will clone our repository and run docker compose file to run all containers with specific ports
            
            # Install Docker Compose if missing
            if ! docker compose version &> /dev/null
            then
               echo "Installing Docker Compose..."
               sudo mkdir -p /usr/local/lib/docker/cli-plugins
               sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
               -o /usr/local/lib/docker/cli-plugins/docker-compose
               sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
            fi
            
            #Now creting our application directory where it will be installed
            mkdir -p /home/me_tejaskapade/app
            cd /home/me_tejaskapade/app

            if [ ! -d ".git" ]; then
              git clone https://github.com/tejas-kapade/node-devops-app-testing01
            else
              git pull
            fi
            
            cd node-devops-app-testing01
            export DOCKER_API_VERSION=1.41

            docker compose down
            docker compose up -d
EOF
}