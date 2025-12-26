resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "uploads" {
  bucket = "docker-strapi-uploads-${random_id.suffix.hex}"
}
