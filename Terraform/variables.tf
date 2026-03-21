variable "project_id" {
default = "project-28225aef-d526-47fe-81e"
}
variable "region" {
  default = "asia-south1"
}
variable "zone" {
  default = "asia-south1-a"
}
variable "app_image" {
  description = "Using this image: metejas/node-devops-app-p1:latest"
  default = "metejas/node-devops-app-p1:latest"
}
variable "docker_user" {
    description = "Using Docker user name"
    default = "metejas"
}