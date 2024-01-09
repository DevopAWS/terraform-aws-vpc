resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge(var.common_tags,
  var.vpc_tags,
   {
    Name = local.name
  }
  )
}

#internet gateway igw
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
        Name = local.name
    }
  )
}

#public-subnet creation
resource "aws_subnet" "public-subnet" {
    count = length(var.public-subnets-cidr) 
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public-subnets-cidr[count.index]
  availability_zone = local.azs_name[count.index]

  tags = merge(
    var.common_tags,
    var.public-subnets_tags,
    {
        Name = "${local.name}-public-subnet-${local.azs_name[count.index]}"
    }

  )
}

#private-subnet creation
resource "aws_subnet" "private-subnet" {
    count = length(var.private-subnets-cidr) 
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private-subnets-cidr[count.index]
  availability_zone = local.azs_name[count.index]

  tags = merge(
    var.common_tags,
    var.private-subnets_tags,
    {
        Name = "${local.name}-private-subnet-${local.azs_name[count.index]}"
    }

  )
}

#database-subnet creation
resource "aws_subnet" "database-subnet" {
    count = length(var.database-subnets-cidr) 
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database-subnets-cidr[count.index]
  availability_zone = local.azs_name[count.index]

  tags = merge(
    var.common_tags,
    var.database-subnets_tags,
    {
        Name = "${local.name}-database-subnet-${local.azs_name[count.index]}"
    }

  )
}