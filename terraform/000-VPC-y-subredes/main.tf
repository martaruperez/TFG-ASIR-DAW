resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "tfg-vpc"
  }
}

#SUBREDES PÚBLICAS:

# Subred pública A
resource "aws_subnet" "public_a" {
  vpc_id    = aws_vpc.main.id
  cidr_block   = "172.16.1.0/24"
  availability_zone    = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tfg-public-subnet-a"
  }
}

# Subred pública B
resource "aws_subnet" "public_b" {
  vpc_id    = aws_vpc.main.id
  cidr_block   = "172.16.2.0/24"
  availability_zone    = "eu-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "tfg-public-subnet-b"
  }
}

#SUBREDES PRIVADAS con la app:

# Subred privada A
resource "aws_subnet" "private_app_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = "172.16.10.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "tfg-private-app-subnet-a"
  }
}

# Subred privada B
resource "aws_subnet" "private_app_b" {
  vpc_id = aws_vpc.main.id
  cidr_block = "172.16.11.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "tfg-private-app-subnet-b"
  }
}

# SUBRED PRIVADA BBDD
resource "aws_subnet" "private_db" {
  vpc_id = aws_vpc.main.id
  cidr_block = "172.16.20.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "tfg-private-db-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "tfg-igw"
  }
}

# Tabla de rutas pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "tfg-public-rt"
  }
}

# Asociaciones de subred pública
resource "aws_route_table_association" "public_a" {
  subnet_id   = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id   = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# Ruta privada para subred privada en AZ a
resource "aws_route_table" "private_app_a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id    = aws_instance.nat_1a.primary_network_interface_id
  }

  tags = {
    Name = "tfg-private-app-rt-a"
  }
}

# Ruta privada para subred privada en AZ b
resource "aws_route_table" "private_app_b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id    = aws_instance.nat_1b.primary_network_interface_id
  }

  tags = {
    Name = "tfg-private-app-rt-b"
  }
}

# Tabla de rutas privada para BBDD (sin salida, pero con endpoint)
resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "tfg-private-db-rt"
  }
}

# Asociaciones de subredes privadas
resource "aws_route_table_association" "private_app_a" {
  subnet_id   = aws_subnet.private_app_a.id
  route_table_id = aws_route_table.private_app_a.id
}

resource "aws_route_table_association" "private_app_b" {
  subnet_id   = aws_subnet.private_app_b.id
  route_table_id = aws_route_table.private_app_b.id
}



resource "aws_route_table_association" "private_db" {
  subnet_id   = aws_subnet.private_db.id
  route_table_id = aws_route_table.private_db.id
}