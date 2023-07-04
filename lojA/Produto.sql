create table Produto(
  id_produto int PRIMARY key not NULL IDENTITY(1,1),
  nome VARCHAR(30) not NULL,
  preco money not null,
  descricao text not NULL,
  
)
