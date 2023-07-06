create table Pedidos(

  id_pedido int not null primary key IDENTITY(1,1),
  id_carrinho_cliente_produto int not null,
  id_status int not null,
  data_pedido date not null
)

alter TABLE Pedidos
add CONSTRAINT fk_carrinho_cliente_produto FOREIGN key (id_carrinho_cliente_produto)
REFERENCES Carrinho_cliente_produto(id_carrinho_Produto)

ALTER TABLE Pedidos
add CONSTRAINT fk_status FOREIGN key (id_status) REFERENCES Status_pedido(id_status)