
# completely bruteforce vpc for 'homecare'..can be optimzed further
resource "aws_vpc" "home_care_vpc" {
  cidr_block = "10.0.0.0/26"
}

resource "aws_subnet" "public_a" {
  count             =  1

  vpc_id            = "${aws_vpc.home_care_vpc.id}"
  cidr_block        = "10.0.0.0/28"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "public_c" {
  count             =  1

  vpc_id            = "${aws_vpc.home_care_vpc.id}"
  cidr_block        = "10.0.0.16/28"
  availability_zone = "us-east-1c"
}

resource "aws_subnet" "private_a" {
  count             =  1
  vpc_id            = "${aws_vpc.home_care_vpc.id}"
  cidr_block        = "10.0.0.32/28"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_c" {
  count             =  1
  vpc_id            = "${aws_vpc.home_care_vpc.id}"
  cidr_block        = "10.0.0.48/28"
  availability_zone = "us-east-1c"
}

resource "aws_route_table" "public_RT" {
  count             = 1
  vpc_id            = "${aws_vpc.home_care_vpc.id}"
}

resource "aws_route_table" "private_RT" {
  count             = 1
  vpc_id            = "${aws_vpc.home_care_vpc.id}"
}





#subnets
resource "aws_internet_gateway" "default" {
  vpc_id    = "${aws_vpc.home_care_vpc.id}"
}

#route_tables
resource "type" "name" {
  
}

#igw
resource "type" "name" {
  
}


#nat_gateway
resource "type" "name" {
  
}


