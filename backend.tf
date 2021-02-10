
terraform {
  backend "gcs" {
    bucket      = "hsctf-bucket"
    prefix      = "tf/blueteam2"
    credentials = "credentials.json"
  }
}