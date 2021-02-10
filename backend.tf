
terraform {
  backend "gcs" {
    bucket      = "hsctf-bucket"
    prefix      = "tf/blueteam3"
    credentials = "credentials.json"
  }
}