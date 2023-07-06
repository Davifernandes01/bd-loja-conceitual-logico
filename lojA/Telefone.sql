CREATE table Telefone(
  id_telefone int PRIMARY key not null IDENTITY(1,1),
  id_cliente int  not null,
  numero varchar(10) not null,
  dd varchar(3) not null

)

--adicionando a chave estrangeira 

alter table Telefone
add CONSTRAINT fk_cliente_telefone FOREIGN key(id_cliente) REFERENCES Cliente(id_cliente)

ALTER TABLE Telefone
add CONSTRAINT un_numero UNIQUE(numero)

/*
insert into Telefone(
  id_cliente, numero, dd
)values(1,'98733098', '34')

select * from Telefone
*/