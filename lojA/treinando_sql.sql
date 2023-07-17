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

--mostrando o total gasto em cada produto que os clientes compraram
  SELECT c.nome as nome_cliente,cp.id_cliente_produto,p.nome,sum(p.preco) as total
    from Cliente_produto cp
      inner join Produto p on p.id_produto = cp.id_produto
      inner join Cliente c on c.id_cliente = cp.id_cliente
      group by cp.id_cliente_produto, c.nome,p.nome
      ORDER by c.nome


SELECT c.nome as nome_cliente,cp.id_cliente_produto,p.nome,max(p.preco) as total
    from Cliente_produto cp
      inner join Produto p on p.id_produto = cp.id_produto
      inner join Cliente c on c.id_cliente = cp.id_cliente
      group by cp.id_cliente_produto, c.nome,p.nome
      ORDER by c.nome

  SELECT p.nome, avg(p.preco)
  FROM Produto p
  GROUP by p.nome

--charindex

  SELECT * from Cliente

  SELECT c.nome, CHARINDEX('Amanda', c.nome)
    from Cliente c
    WHERE CONVERT(INT, CHARINDEX('amanda', c.nome, 1)) > 0

SELECT c.nome, CHARINDEX('Carlos', c.nome, 1)
from Cliente c
WHERE CHARINDEX('Carlos', c.nome, 1) <> '0'

--concat

select CONCAT('davi', ' ', 'fernandes')

SELECT CONCAT('davi', ' || ', 'fernades')

SELECT 'davi' + ' ' + 'fernades'

SELECT CONCAT(c.nome, ' - ', t.numero)
  From Telefone t
    inner JOIN Cliente c on c.id_cliente  = t.id_cliente

--concat_ws

SELECT CONCAT_WS(' - ', 'davi', 'fernandes', 'furtado')


SELECT CONCAT_WS(' - ', c.nome, c.sobrenome, 'PRODUTO :' + trim(CONVERT(char, p.nome )),
'DESCRIÇÃO:' + trim(CONVERT(char, p.descricao)))
  from Cliente_produto cp
  inner join Cliente c on c.id_cliente = cp.id_cliente
  inner join Produto p on p.id_produto = cp.id_produto



--diferences(0 a 4)


SELECT DIFFERENCE('davi',  'david')
SELECT DIFFERENCE('davi', 'deivid')

--funcçao format (retorna um valor formatado  e a cultura opcional, se especificar)
--para dados do tipos gerais usar CAST ou CONVERT 

SELECT CONVERT(char, GETDATE(), 103)'d', 'en-US' AS USA

/*
declare @dt datetime = getdate()

SELECT FORMAT(@dt, 'd', 'en-US') AS USA
  ,FORMAT(@dt, 'd', 'zh-cn') as china
  ,FORMAT(@dt, 'd', 'de-de') as alemanha
  ,FORMAT(@dt, 'D','en-US') as "USA por extenso"
  ,FORMAT(@dt, 'D', 'zh-cn') as "china por extenso"
  ,FORMAT(@dt, 'D', 'de-de') as "alemanha ppor extenso"
*/


declare @dt datetime = getdate()
SELECT FORMAT(6426394,'##-####-##') as prod

SELECT FORMAT(p.preco, 'N', 'en-US') as "formato americano",
      FORMAT(p.preco,'G', 'en-US') as geral, FORMAT(p.preco, 'C','pt-br') as "formato br",
      p.preco
  from Produto p

--left(extrai um caractere a esquerda de um texto ou campo)

SELECT left('davi', 3)

SELECT distinct LEFT(c.nome, 3) from Cliente c


--rigth(extrai caracteres a direita de um testo ou campo)

SELECT RIGHT('davi fernandes furtado rodrigues', 12)


SELECT distinct RIGHT(c.nome, 5) from Cliente c

--LEN(retorna o tamanho do campo)

SELECT LEN('davi fernandes furtado rodrigues')

SELECT c.nome, LEN(c.nome) as tamanho
  from Cliente c 

SELECT MAX(LEN(c.nome)) as maior
  from Cliente c

  SELECT MIN(LEN(c.nome)) as menor
  from Cliente c


--upper- coloca os caracteres me maiusculo

SELECT UPPER('davi fgsbdj vpnbg')

SELECT c.nome, UPPER(c.nome) from Cliente c


--lower - coloca os caracteres em minusculo

select LOWER('JKSCGK HLFNMICDNVXCVNIN')

--ltrim

SELECT LTRIM('   davi fernades furtado')@

declare @varTexto VARCHAR(50)
  set @varTexto = '              TEXTO DO LTRIM'


SELECT LTRIM(@varTexto)
SELECT resultado = LTRIM(@varTexto)

--rtrim

select len(RTRIM('davi          '))
select len('davi          x')


declare @varTesto2 VARCHAR(50)
set @varTesto2 = 'rada é o melhor espectro          '
SELECT RTRIM(@varTesto2)
SELECT LEN(RTRIM(@varTesto2))


--patindex(retorna a posição inicial da primeira ocorrencia de padrao)

SELECT PATINDEX('%nan%', 'davi fernandes')

SELECT PATINDEX('%s', 'davi fernandes')

SELECT PATINDEX('a%', 'ana ok')

SELECT PATINDEX('%vi_fer%', 'davi fernandes')

declare @varTesto3 VARCHAR(100)
  set @varTesto3 ='eu sou radamanthys de wyvern o maior de todos'

--substring

SELECT SUBSTRING(@varTesto3, PATINDEX('%radamanthys%',@varTesto3),7)

--replace

SELECT REPLACE('davi fernandes', 'a', 'x')

SELECT REPLACE(REPLACE('davi fernandes','a','x'), 'n',';')

SELECT c.nome, c.data_nascimento, c.sexo
  FROM Cliente c

  SELECT c.nome, c.data_nascimento, REPLACE(c.sexo, 'M','MASCULINO') as sexo
  FROM Cliente c


DECLARE @cpf VARCHAR(15)
set @cpf = '333.222.444-23'

SELECT REPLACE(REPLACE(@cpf,'.', ''), '-', '') 


--REPLICATE
SELECT REPLICATE('x',20)


--tamanho de coluna fixo em 50 posições

SELECT * from Cliente

SELECT LEN(nome) from Cliente

SELECT nome + REPLICATE('x', 10 - LEN(nome)) from Cliente 

--reverse

select REVERSE('davi fernandes')


--space

select 'davi' + SPACE(25)


DECLARE @varNome VARCHAR(50)
set @varNome = 'davi fernandes'

SELECT @varNome + SPACE(50- LEN(@varNome))

SELECT c.nome  + SPACE(59 - LEN(c.nome)) + c.sexo, LEN(c.nome + SPACE(59-LEN(c.nome)) + c.sexo)
  from Cliente c


--string_agg (concatena os valores das expressoes de cadeia de caractere e coloca os valores do separador entre eles)


select STRING_AGG(CONVERT(nvarchar(max),sexo), ',') as registro
from Cliente

select STRING_AGG(CONVERT(nvarchar(max), ISNULL(sexo, 'N')), '-') as registro
from Cliente

select DATEPART(year, c.data_nascimento) as ano, 
STRING_AGG(CONVERT(nvarchar(max), ISNULL(c.sexo, '0')), ' - ') as registro
FROM Cliente c
group by DATEPART(YEAR, c.data_nascimento)
order by 1

--WITHIN
SELECT DATEPART(YEAR, c.data_nascimento) as ano, 
        STRING_AGG(CONVERT(nvarchar(max), ISNULL(c.sexo,'0')), '-')
        WITHIN GROUP(order by DATEPART(year,c.data_nascimento) asc) as registro
  from Cliente c
  group by DATEPART(YEAR, c.data_nascimento)


--stuff


declare @vProcura VARCHAR(50)
DECLARE @vSub VARCHAR(30)

set @vProcura = 'eu, xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx, autorizo ...'
set @vSub = 'davi fernandes '

SELECT STUFF(@vProcura,5,30, @vSub+SPACE(30 -  LEN(@vSub)))

SELECT STUFF(@vProcura,5,30,trim(@vSub + SPACE(30 - LEN(@vSub))))


--substring

SELECT SUBSTRING('davi fernandes',1,4) as nome


SELECT p.nome, SUBSTRING(p.nome, 1,10)
  from Produto p


  select p.nome,
       case SUBSTRING(p.nome,1,CHARINDEX(' ',p.nome, CHARINDEX(' ', p.nome)+1))
        when '' then 
        p.nome
        else  
        SUBSTRING(p.nome,1,CHARINDEX(' ',p.nome, CHARINDEX(' ', p.nome)+1))
      
      END as nome_parcial

    from Produto p


    --iif

    SELECT p.nome,
        IIF(SUBSTRING(p.nome,1,CHARINDEX(' ', p.nome, CHARINDEX(' ',p.nome) +1)) = '',
        p.nome,
        SUBSTRING(p.nome,1,CHARINDEX(' ',p.nome, CHARINDEX(' ', p.nome)+1)))
      from Produto p


--translate

select replace('2*[4*3]/{7-2}','[]{}','()()')

SELECT TRANSLATE('abcdefghi','abc','123')

declare @vConta VARCHAR(40)
set @vConta = '2*[4*3]/{7-2}'


SELECT TRANSLATE(@vConta,'[]{}', '()()')


--trim 

select TRIM('  rada fernandes              ')

--while

declare @vString VARCHAR(100)
set @vString = 'SQL           SERVER        |'

WHILE CHARINDEX('  ', @vString) > 0 
BEGIN
    set @vString  = REPLACE(@vString,'  ',' ')
end

select @vString