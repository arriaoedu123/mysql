/**
	Carrinho de compras
	@author Arreaum
*/

-- criar um novo banco de dados
create database dbcarrinho;
-- exibir banco de dados do servidor
show databases;
-- selecionar o banco de dados
use dbcarrinho;

-- criando uma tabela
create table carrinho(
	codigo int primary key auto_increment,
	produto varchar(250) not null,
    quantidade int not null,
    valor decimal(10,2) not null
);

-- descricao da tabela
describe carrinho;

-- alterar o nome de um campo na tabela
alter table carrinho change quant quantidade int not null;
alter table carrinho add column desconto int after valor;
alter table carrinho modify column produto varchar(250) not null;
alter table carrinho add column codigo int primary key auto_increment;

-- CRUD Create
insert into carrinho(produto,quantidade,valor) values ('Bolinha de Gude',30,10);
insert into carrinho(produto,quantidade,valor) values ('RTX 3090',1,150000);
insert into carrinho(produto,quantidade,valor) values ('Carrinho de Rolimã',1,250);
insert into carrinho(produto,quantidade,valor) values ('Heder',1,1.99);

-- CRUD Read
select * from carrinho;

-- Operacoes matematicas no banco de dados
select sum(valor * quantidade) as total from carrinho;

-- CRUD Update
-- ATENCAO! Nao esqueca do where e usar sempre o id para evitar problema e nao ser demitido
update carrinho set valor = 18 where codigo = 1;
update carrinho set quantidade = 35 where codigo = 2;

-- uso de filtros
select * from carrinho order by valor;
select * from carrinho order by produto;
select * from carrinho where valor > 10;

-- CRUD Delete
-- ATENCAO! Nao esqueca do where e usar sempre o id para evitar problema e nao ser demitido
delete from carrinho where codigo = 5;

-- timestamp default current_timestamp (data e hora automatico)
-- date (tipo de dados relacioandos a data) YYYYMMDD
create table estoque(
	codigo int primary key auto_increment,
    barcode varchar(50) unique,
    produto varchar(100) not null,
    fabricante varchar(100) not null,
    datacad timestamp default current_timestamp,
    dataval date not null,
    quantidade int not null,
    estoquemin int not null,
    medida varchar(50) not null,
    valor decimal(10,2),
    loc varchar(100)
);

-- descrever uma tabela
describe estoque;

-- CRUD Create
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,medida,valor,loc)
values(
	'Caneta BIC preto','BIC',20221005,100,10,'CX',28.75,'Setor A P2'
);
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,medida,valor,loc)
values(
	'Pneu furado','Pireli','20250921',50,5,'U','50','Setor B P3'
);
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,medida,valor,loc)
values(
	'Heder','Suzanense','20211005',1,0,'UN',51,'Setor C P1'
);
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,medida,valor,loc)
values(
	'Saco de melância','Sadia','20210520',5,10,'UN',30,'Setor A P2'
);
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,medida,valor,loc)
values(
	'Coxinha','Aurelio','20221005',10,5,'UN',1.99,'Setor B P4'
);

-- CRUD Read
select * from estoque;
update estoque set medida = 'UN' where codigo = 2;

-- inventario do estoque (total)
select sum(valor * quantidade) as total from estoque;

-- relatorio de reposicao do estoque 1
select * from estoque where quantidade < estoquemin;

-- relatorio de reposicao do estoque 2
-- date_format() -> formatar a exibicao da data
-- %d (dia) %m (mes) %y (ano 2 digitos) %Y (ano 4 digitos)
select codigo as código,produto,date_format(dataval,'%d/%m/%Y') as data_validade,quantidade,estoquemin as estoque_mínimo from estoque where quantidade < estoquemin;

-- relatorio de produto vencidos 1
select codigo as código,produto,date_format(dataval,'%d/%m/%Y') as data_validade from estoque;

-- relatorio de validade do produto 2
-- datediff() retorna a diferenca em dias de duas datas
-- curdate() data atual
select codigo as código,produto,date_format(dataval,'%d/%m/%Y') as data_validade,datediff(dataval,curdate()) as dias_restantes from estoque;

-- CRUD Update
update estoque set produto = 'Caneta BIC azul' where codigo = 1;
update estoque set medida = 'UN';

-- CRUD Delete
delete from estoque where codigo = 3;