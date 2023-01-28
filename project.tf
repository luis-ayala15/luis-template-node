variable token {}

terraform {
  required_providers {
    sonarcloud = {
      source  = "rewe-digital/sonarcloud"
      version = "0.2.1"
    }
  }
}

provider "sonarcloud" {
  organization = ""
  token        = "${var.token}"
}

resource "sonarcloud_project" "" {
  key        = ""
  name       = ""
  visibility = "public"
}