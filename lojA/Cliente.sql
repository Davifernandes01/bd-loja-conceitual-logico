create table Cliente(

  id_cliente int not null primary KEY IDENTITY(1,1),
  nome varchar(15) not null,
  sobrenome varchar(15) not null, 
  sexo char(1) not null CHECK (sexo in ('M', 'F')),
  data_nascimento date not null,
  cpf varchar(14) not null,
  email varchar(50) not null

)
/*
alter TABLE Cliente
add CONSTRAINT un_cpf unique (cpf)

alter table Cliente
add CONSTRAINT un_email UNIQUE(email)

insert into Cliente(
  nome, sobrenome, sexo, data_nascimento, cpf, email
)values(
  'rada', 'manthys', 'M', '16/03/2007', '123.265.945.76', 'rada@gmail.com.com'
)

select * from Cliente
/*