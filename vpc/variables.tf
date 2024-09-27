variable "name" {
  type = object({
    vpc                           = string
    public_subnet                 = string
    eks_control_plane_subnet      = string
    private_subnet                = string
    db_private_subnet             = string
    eks_control_plane_route_table = string
    public_route_table            = string
    private_route_table           = string
    db_route_table                = string
    internet_gateway              = string
    public_nat_gateway            = string
  })
  default = {
    vpc                           = "default"
    public_subnet                 = "public"
    eks_control_plane_subnet      = "eks-private"
    private_subnet                = "private"
    db_private_subnet             = "db-private"
    eks_control_plane_route_table = "eks-control-plane-rtb"
    public_route_table            = "public-rtb"
    private_route_table           = "private-rtb"
    db_route_table                = "db-rtb"
    internet_gateway              = "igw"
    public_nat_gateway            = "nat-public-gw"
  }
  description = "resource names"
}

variable "cidr" {
  type        = string
  default     = ""
  description = "vpc base cidr"
}

variable "availability_zone_count" {
  type        = number
  default     = 3
  description = "availability zone count"
}

variable "subnet_cidr" {
  type = object({
    public            = list(string)
    eks_control_plane = list(string)
    private           = list(string)
    db_private        = list(string)
  })
  default = {
    public            = []
    eks_control_plane = []
    private           = []
    db_private        = []
  }
  description = "subnet cidr"
}
