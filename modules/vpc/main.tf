resource "aws_vpc" "this" {
  cidr_block = var.cidr
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.name}-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}
