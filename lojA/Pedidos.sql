create table Pedidos(
  id_pedido int not null PRIMARY key IDENTITY(1,1),
  data_pedido date not null,
  id_carrinho_produto int not null,
  id_cliente int not null,
  id_status int not null

);

alter table Pedidos
add CONSTRAINT fk_carrinho_produto FOREIGN key (id_carrinho_produto) REFERENCES Carrinho_produto(id_carrinho_produto)

alter table Pedidos
add CONSTRAINT fk_cliente FOREIGN key(id_cliente) REFERENCES Cliente(id_cliente)

alter table Pedidos
add CONSTRAINT fk_status FOREIGN key(id_status) REFERENCES Status_pedido(id_status)