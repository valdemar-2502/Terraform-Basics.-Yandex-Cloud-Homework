# Создание NAT-шлюза
resource "yandex_vpc_gateway" "nat_gateway" {
  name = "nat-gateway"
  shared_egress_gateway {}
}

# Создание таблицы маршрутизации
resource "yandex_vpc_route_table" "nat_route_table" {
  network_id = yandex_vpc_network.develop.id
  name       = "nat-route-table"
  
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}
