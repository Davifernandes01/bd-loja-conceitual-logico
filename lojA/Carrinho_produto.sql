create table Carrinho_cliente_produto(
  id_carrinho_produto int primary key not null IDENTITY(1,1),
  id_cliente_produto int not null,
  id_carrinho int not null,
  quantidade_produto TINYINT not null
);



alter table Carrinho_cliente_produto
add CONSTRAINT fk_carrinho_produto_carrinho FOREIGN key(id_carrinho) REFERENCES Carrinho(id_carrinho)

alter table Carrinho_cliente_produto
add CONSTRAINT fk_cliente_produto FOREIGN key(id_carrinho_produto) REFERENCES Cliente_produto(id_cliente_produto)