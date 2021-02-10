
terraform {
  backend "gcs" {
    bucket      = "hsctf-bucket"
    prefix      = "tf/blueteam"
    credentials = "credentials.json"
  }
}