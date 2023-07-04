create table Endereco(
  id_endereco int not null PRIMARY key IDENTITY(1,1),
  rua VARCHAR(20) not NULL,
  numero int not null,
  bairro varchar(30) not null,
  cep VARCHAR(9) not null,
  cidade varchar(30) not NULL
)
