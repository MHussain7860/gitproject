provider "aws" {
 region "us-east-1"

resource "aws_instance" "app-server" {
  ami = "ami--12345"
