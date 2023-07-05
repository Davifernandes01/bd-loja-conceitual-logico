create table Carrinho_produto(
  id_carrinho_produto int primary key not null IDENTITY(1,1),
  id_produto int not null,
  id_carrinho int not null,
  quantidade_produto TINYINT not null
);

alter table Carrinho_produto
add CONSTRAINT fk_carrinho_produto_produto FOREIGN key(id_produto) REFERENCES Produto(id_produto)

alter table Carrinho_produto
add CONSTRAINT fk_carrinho_produto_carrinho FOREIGN key(id_carrinho) REFERENCES Carrinho(id_carrinho)