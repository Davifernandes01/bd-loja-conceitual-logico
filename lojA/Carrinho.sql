CREATE table Carrinho(

  id_carrinho int not NULL PRIMARY key IDENTITY(1,1),
  data_insercao date not null,

);

alter TABLE Carrinho
add  data_insercao date not null