variable "region" {
  type    = string
}

variable "name" {
  type    = string
}

variable "key" {
  type    = string
}

variable "ava_zone" {
  type    = list(any)
}

variable "cidr_main" {
  type    = string
}

variable "pub_sub" {
  type    = list(any)
}

variable "pri_sub" {
}

variable "pri_subdb" {
}

variable "cidr_route" {
  type    = string
}

variable "cidr_routev6" {
  type    = string
}

variable "ssh" {
  type    = string
}

variable "http" {
  type    = string
}

variable "icmp" {
  type    = string
}

variable "mysql" {
  type    = string
}

variable "port_ssh" {
  type    = number
}

variable "port_http" {
  type    = number
}

variable "port_mysql" {
  type    = number
}

variable "port_zero" {
  type    = number
}

variable "minus" {
}

variable "pro_tcp" {
  type    = string
}

variable "pro_icmp" {
  type    = string
}

variable "pro_udp" {
  type    = string
}

variable "nul" {
}

variable "port_all" {
  type    = string
}

variable "pri_ip" {
  type    = string
}

variable "pro_HTTP" {
  type    = string
}

variable "nb_2" {
  type    = number
}

variable "hc_type" {
  type    = string
}

variable "min_s" {
  type    = number
}

variable "max_s" {
  type    = number
}

variable "mydb" {
  type    = string
}
