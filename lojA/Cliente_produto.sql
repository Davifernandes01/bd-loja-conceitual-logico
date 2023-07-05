create table Cliente_produto(
  id_cliente_produto int not null primary key IDENTITY(1,1),
  id_cliente int not null,
  id_produto int not null,
  quantidade TINYINT not NULL
);

alter TABLE Cliente_produto
add CONSTRAINT fk_cliente_produto_cliente FOREIGN key(id_cliente) REFERENCES Cliente(id_cliente)

alter TABLE Cliente_produto
add CONSTRAINT fk_cliente_produto_produto FOREIGN key(id_produto) REFERENCES Produto(id_produto)

