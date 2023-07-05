-- tabela de associação entre cliente e endereços (um cliente para varios endereços, e um endereco para varios clientes)

create table Cliente_Endereco(
    id_cliente_endereco int not null PRIMARY KEY IDENTITY(1,1),
    id_cliente int not null,
    id_endereco int not null
);

--chaves estrangeiras

alter TABLE Cliente_Endereco
ADD CONSTRAINT fk_id_cliente FOREIGN key(id_cliente) REFERENCES Cliente(id_cliente)

alter table Cliente_Endereco
add CONSTRAINT fk_id_endereco FOREIGN key(id_endereco) REFERENCES Endereco(id_endereco)
