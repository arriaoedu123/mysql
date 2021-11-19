/**
	E-Commerce
	@author Arreaum
*/

-- criar um novo banco de dados
create database dbcarrinho;
-- exibir banco de dados do servidor
show databases;
-- selecionar o banco de dados
use dbcarrinho;

create table clientes(
	idcli int primary key auto_increment,
    nome varchar(50) not null,
    email varchar(50) unique not null,
    senha varchar(250) not null
);

update clientes set nome = "Marcondes", email = "marcondes@exemplo.com", senha = md5('123@senac') where id = 1;

insert into clientes(nome,email,senha)
values(
	'Marcondes','marcondes@exemplo.com',md5('123@senac')
);

insert into clientes(nome,email,senha)
values(
	'Mario','mario@exemplo.com',md5('123@senac')
);

insert into clientes(nome,email,senha)
values(
	'Muriel','muriel@exemplo.com',md5('123@senac')
);

insert into clientes(nome,email,senha)
values(
	'João','joao@exemplo.com',md5('123@senac')
);

insert into clientes(nome,email,senha)
values(
	'Charles','charles@exemplo.com',md5('123@senac')
);

select * from clientes;

-- login
-- and (o select só será executado se as duas condições existirem)
select * from clientes where email = "charles@exemplo.com" and senha = md5('123@senac');

select * from clientes where senha = md5('1');
select * from clientes where nome like "M%";
select idcli as ID, nome as Cliente, email as Email from clientes where nome like "m%";
update clientes set email = "linus@exemplo.com" where idcli = 6;
describe clientes;

-- timestamp default current_timestamp (data e hora automatico)
-- date (tipo de dados relacioandos a data) YYYYMMDD
create table produtos(
	codigo int primary key auto_increment,
    barcode varchar(50) unique,
    produto varchar(100) not null,
    fabricante varchar(100) not null,
    datacad timestamp default current_timestamp,
    dataval date not null,
    estoque int not null,
    estoquemin int not null,
    medida varchar(50) not null,
    valor decimal(10,2),
    loc varchar(100)
);

describe produtos;

-- CRUD Create
insert into produtos(produto,fabricante,dataval,estoque,estoquemin,medida,valor,loc)
values(
	'Caneta BIC preto','BIC',20221005,100,10,'CX',28.75,'Setor A P2'
);
insert into produtos(produto,fabricante,dataval,estoque,estoquemin,medida,valor,loc)
values(
	'Pneu furado','Pireli','20250921',50,5,'U','50','Setor B P3'
);
insert into produtos(produto,fabricante,dataval,estoque,estoquemin,medida,valor,loc)
values(
	'Heder','Suzanense','20211005',1,0,'UN',51,'Setor C P1'
);
insert into produtos(produto,fabricante,dataval,estoque,estoquemin,medida,valor,loc)
values(
	'Saco de melância','Sadia','20210520',5,10,'UN',30,'Setor A P2'
);
insert into produtos(produto,fabricante,dataval,estoque,estoquemin,medida,valor,loc)
values(
	'Coxinha','Aurelio','20221005',10,5,'UN',1.99,'Setor B P4'
);

-- CRUD Read
select * from produtos;
update produtos set medida = 'UN' where codigo = 2;

-- inventario do estoque (total)
select sum(valor * estoque) as total from produtos;

-- relatorio de reposicao do estoque 1
select * from produtos where estoque < estoquemin;

-- relatorio de reposicao do estoque 2
-- date_format() -> formatar a exibicao da data
-- %d (dia) %m (mes) %y (ano 2 digitos) %Y (ano 4 digitos)
select codigo as código,produto,date_format(dataval,'%d/%m/%Y') as data_validade,estoque,estoquemin as estoque_mínimo from produtos where estoque < estoquemin;

-- relatorio de produto vencidos 1
select codigo as código,produto,date_format(dataval,'%d/%m/%Y') as data_validade from produtos;

-- relatorio de validade do produto 2
-- datediff() retorna a diferenca em dias de duas datas
-- curdate() data atual
select codigo as código,produto,date_format(dataval,'%d/%m/%Y') as data_validade,datediff(dataval,curdate()) as dias_restantes from produtos;

-- CRUD Update
update produtos set produto = 'Caneta BIC azul' where codigo = 1;

create table pedidos(
	pedido int primary key auto_increment,
    dataped timestamp default current_timestamp,
    total decimal(10,2),
    idcli int not null,
    foreign key(idcli) references clientes(idcli)
);

insert into pedidos(idcli) values (2);
select * from pedidos;

-- abertura do pedido
select 
	pedidos.pedido,date_format(pedidos.dataped,'%d/%m/%Y - %H:%i') as data_pedido,
    clientes.nome as cliente, clientes.email as e_mail
from pedidos inner join clientes on pedidos.idcli = clientes.idcli;

create table carrinho(
	pedido int not null,
    codigo int not null,
    quantidade int not null,
    foreign key(pedido) references pedidos(pedido),
    foreign key(codigo) references produtos(codigo)
);

select * from carrinho;

insert into carrinho(pedido,codigo,quantidade) values (1,1,10);
insert into carrinho(pedido,codigo,quantidade) values (1,2,5);

-- exibir o carrinho
select pedidos.pedido,carrinho.codigo as código,carrinho.quantidade,produtos.valor,produtos.valor * carrinho.quantidade as sub_total
from (carrinho inner join pedidos on carrinho.pedido = pedidos.pedido) inner join produtos on carrinho.codigo = produtos.codigo;

-- total do carrinho
select sum(produtos.valor * carrinho.quantidade) as total from carrinho inner join produtos on carrinho.codigo = produtos.codigo;

-- atualizar o banco de dados apos a venda
update carrinho inner join produtos on carrinho.codigo = produtos.codigo set produtos.estoque =  produtos.estoque - carrinho.quantidade
where carrinho.quantidade > 0;