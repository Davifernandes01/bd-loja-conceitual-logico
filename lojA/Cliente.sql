create table Cliente(

  id_cliente int not null primary KEY IDENTITY(1,1),
  nome varchar(15) not null,
  sobrenome varchar(15) not null, 
  sexo char(1) not null CHECK (sexo in ('M', 'F')),
  data_nascimento date not null,
  cpf varchar(14) not null,
  email varchar(50) not null

)

