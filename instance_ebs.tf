provider "aws" {
  region= "ap-south-1"
  profile= "terrauser"
}

resource "aws_instance" "instance_with_ebs_attached" {
  ami           = "ami-010aff33ed5991201"
  instance_type = "t2.micro"

  tags = {
    Name = "instance from TF"
  }
}

resource "aws_ebs_volume" "ebsVol" {
  availability_zone = aws_instance.instance_with_ebs_attached.availability_zone
  size              = 1

  tags = {
    Name = "webserver_storage"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebsVol.id
  instance_id = aws_instance.instance_with_ebs_attached.id
}