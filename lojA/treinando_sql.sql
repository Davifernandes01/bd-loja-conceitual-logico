-- select simples
SELECT * from Pedidos
SELECT * from Cliente
SELECT * from Produto
SELECT * from Endereco
SELECT * from Telefone
SELECT * from Carrinho
SELECT * from Status_pedido
SELECT * from Carrinho_cliente_produto
SELECT * from Cliente_produto
SELECT * from Cliente_Endereco

-- mostrando quais atributos quero ver 

SELECT p.nome, p.descricao
from Produto p

SELECT e.cidade, e.cep
from Endereco e

SELECT ed.id_cliente, ed.id_endereco
from Cliente_Endereco ed

--count

select COUNT(*) from Cliente

-- select com where

--mostrando a quantidade de cliente por sexo
select COUNT(*) from Cliente
where sexo = 'M' --17

SELECT COUNT(*) from Cliente
where sexo = 'F' --16

--nascidos entre 1990 e 1999
SELECT * from Cliente
where data_nascimento > '01/01/1990' and data_nascimento < '31/12/1999'

--descobrindo a idade do povo
SELECT c.nome, c.sobrenome, DATEDIFF(YEAR, c.data_nascimento, GETDATE()) as idade
from Cliente c

--treinando um pouco o inner join


-- sabendo quais produto joão pegou
SELECT cp.id_cliente, c.nome, cp.id_produto, p.nome
  from Cliente_produto cp
    INNER JOIN Cliente c on cp.id_cliente = c.id_cliente
    INNER join Produto p on cp.id_produto = p.id_produto
    WHERE c.nome = 'joão'

--quantidades de produtos que cada pessoa pegou

select cp.id_cliente, c.nome, COUNT(p.id_produto) as total_produto
  from Cliente_produto cp
    inner join Cliente c on cp.id_cliente = c.id_cliente
    inner join produto p on cp.id_produto = p.id_produto
      GROUP by cp.id_cliente, c.nome

-- quero os dados: nome cliente, produtos no carrinho, numero do carrinho, quantidade e preco unidade e preco total
SELECT cc.id_cliente, cc.nome, p.nome as nome_produto, ccp.quantidade_produto, p.preco as preco_unidade, (ccp.quantidade_produto * p.preco) as TOTAL_preco
FROM Cliente cc
LEFT JOIN Cliente_produto cp ON cc.id_cliente = cp.id_cliente
LEFT JOIN Carrinho_cliente_produto ccp ON cp.id_cliente_produto = ccp.id_cliente_produto
LEFT JOIN Carrinho c ON ccp.id_carrinho = c.id_carrinho
LEFT JOIN Produto p ON cp.id_produto = p.id_produto
--where cc.nome = 'joão'
ORDER BY CC.nome

  
  

-- soma total dos produtos que cada cliente comprou  
SELECT c.id_cliente, c.nome, SUM(ccp.quantidade_produto * p.preco) AS TOTAL_DINHEIRO_GASTADO
  FROM Cliente c
    inner JOIN Cliente_produto cp ON c.id_cliente = cp.id_cliente
    inner JOIN Carrinho_cliente_produto ccp ON cp.id_cliente_produto = ccp.id_cliente_produto
    inner JOIN Produto p ON cp.id_produto = p.id_produto
      GROUP BY c.id_cliente, c.nome;
      
--PESSOAS com o numero de telefone cadastrado
SELECT c.id_cliente, c.nome, T.dd, T.numero
  from Cliente c
    inner join Telefone T ON C.id_cliente = T.id_cliente
    ORDER BY C.nome


--PESSOAS com o endereço cadastrado
SELECT c.id_cliente, c.nome, e.bairro, e.rua, e.numero, e.cidade
  from Cliente c
    INNER JOIN Cliente_Endereco ce on c.id_cliente = ce.id_cliente
    INNER join Endereco e on ce.id_endereco = e.id_endereco
    ORDER BY C.nome

-- data pedido, nome do  cliente, nome do produto, preco do produto unitario e total

SELECT c.id_cliente, c.nome, pp.nome as nome_produto,ccp.quantidade_produto,pp.preco as preco_unitario,
(ccp.quantidade_produto * pp.preco) as valor_total,
p.id_pedido,
p.data_pedido, sp.descricao
    from Pedidos p
      inner join Status_pedido sp on p.id_status = sp.id_status
      inner join Carrinho_cliente_produto ccp on  ccp.id_carrinho_produto = p.id_carrinho_cliente_produto    --p.id_carrinho_cliente_produto = ccp.id_carrinho_produto
      inner join Cliente_produto cp on ccp.id_cliente_produto = cp.id_cliente_produto
      inner join Cliente c on cp.id_cliente = c.id_cliente
      inner join Produto pp on cp.id_produto = pp.id_produto
     -- where sp.descricao = 'aprovado'
        ORDER by c.nome
        

--clasula in -- mostra os ids dentro da clasula in
SELECT * from Cliente
where id_cliente in(1,8,6)

--clasula not in -- n mostra os ids dentro da clasula not in
SELECT * from Cliente
WHERE id_cliente not in(1,8,6,7,2)

--distinct -- mostra o resultado sem repetir
SELECT distinct DATEPART(YEAR, data_nascimento) from Cliente
ORDER by 1 -- crescente

SELECT distinct DATEPART(YEAR, data_nascimento) from Cliente
ORDER by 1 DESC --decrscente

--lista complenta de clientes

SELECT c.id_cliente
      ,c.nome,
      c.sexo,
      cp.id_cliente_produto,
      p.nome as nome_produto,
      ccp.quantidade_produto,
      p.descricao,
      p.preco
  from Cliente_produto cp
    INNER join Cliente  c on c.id_cliente = cp.id_cliente
    inner join Produto p on p.id_produto = cp.id_produto
    --WHERE c.sexo = 'M'
    INNER join Carrinho_cliente_produto ccp on ccp.id_cliente_produto = cp.id_cliente_produto
    ORDER by c.id_cliente
  

  SELECT * from Produto
  WHERE id_produto = 3

--quantos cada produto vendeu no total, e a quantidade de produto no total
  SELECT p.id_produto,
         p.nome,
        p.preco,
        SUM(ccp.quantidade_produto) as total_produtos_vendidos,
       round(SUM(p.preco * ccp.quantidade_produto),2) as total_vendido_em_reais
    From Carrinho_cliente_produto ccp
     inner join Cliente_produto cp on cp.id_produto = ccp.id_cliente_produto
     inner join Produto p on p.id_produto = cp.id_produto
     --WHERE p.id_produto = 10
   GROUP by p.id_produto,p.nome,p.preco
     ORDER by 1

--total de produtos vendido em cada ano
 SELECT 
        SUM(ccp.quantidade_produto) as total_produtos_vendidos,
       round(SUM(p.preco * ccp.quantidade_produto),2) as total_vendido_em_reais,
       YEAR(cc.data_insercao) as data
    From Carrinho_cliente_produto ccp
     inner join Cliente_produto cp on cp.id_produto = ccp.id_cliente_produto
     inner join Produto p on p.id_produto = cp.id_produto
     inner join Carrinho cc on cc.id_carrinho = ccp.id_carrinho
     --WHERE p.id_produto = 10
   GROUP by YEAR(cc.data_insercao)
    
