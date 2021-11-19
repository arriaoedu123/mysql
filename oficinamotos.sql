create database oficina;

create table usuarios(
	id int primary key auto_increment,
    usuario varchar(50) not null,
    login varchar(50) not null unique,
    senha varchar(250) not null,
    perfil varchar(50) not null
);

insert into usuarios(usuario, login, senha, perfil)
values(
	'Maria','admin',md5('123@senac'),'administrador'
);

insert into usuarios(usuario, login, senha, perfil)
values(
	'Anderson','anderson',md5('123@senac'),'operador'
);

insert into usuarios(usuario, login, senha, perfil)
values(
	'Andrew','andrew',md5('123@senac'),'operador'
);

insert into usuarios(usuario, login, senha, perfil)
values(
	'Joaquin','joaquin',md5('123@senac'),'atendente'
);

-- CRUD Update
update usuarios set senha = md5('123@Senac') where id = 1; 
update usuarios set perfil = 'gerente' where id = 2;

describe usuarios;
select * from usuarios;

create table clientes(
	idcli int primary key auto_increment,
    nome varchar(50) not null,
    doc varchar(250) not null,
    cep char(8),
    endereco varchar(50) not null,
    numero varchar(12) not null,
    complemento varchar(30),
    bairro varchar(50) not null,
    cidade varchar(50) not null,
    uf char(2) not null,
    fone varchar(15),
    cel varchar(15) not null,
    email varchar(100) unique
);
drop table clientes;
alter table clientes add column cnh char(12) unique after nome;
alter table clientes change doc cpf varchar(250) not null;
describe clientes;

insert into clientes(nome,cnh,cpf,cep,endereco,numero,complemento,bairro,cidade,uf,fone,cel,email)
values(
	'Heder',10165879162,'5827364728','04673645','Rua Um','168','Casa','Vila Um','São Paulo','SP','','11973849285','example@heder.com'
);
insert into clientes(nome,cnh,cpf,cep,endereco,numero,complemento,bairro,cidade,uf,fone,cel,email)
values(
	'Vitor',54476764388,'87654321213','07485394','Rua Dois','867','Casa','Vila Dois','São Paulo','SP','','11987654321','example@vitor.com'
);
insert into clientes(nome,cnh,cpf,cep,endereco,numero,complemento,bairro,cidade,uf,fone,cel,email)
values(
	'Cassio',31432391440,'54862514586','87654321','Rua Tres','145','Casa','Vila Tres','São Paulo','SP','','987654321','example@cassio.com'
);
insert into clientes(nome,cnh,cpf,cep,endereco,numero,complemento,bairro,cidade,uf,fone,cel,email)
values(
	'Ismael',50067056880,'52586895963','87654321','Rua Quatro','589','Casa','Vila Quatro','São Paulo','SP','','987654321','example@ismael.com'
);
insert into clientes(nome,cnh,cpf,cep,endereco,numero,complemento,bairro,cidade,uf,fone,cel,email)
values(
	'Daniel',70346927302,'45825214145','87654321','Rua Cinco','595','Casa','Vila Cinco','São Paulo','SP','','987654321','example@daniel.com'
);

-- CRUD Update
update clientes set cel = '11987654321' where idcli = 3;
update clientes set cel = '11987654321' where idcli = 4;
update clientes set cel = '11987654321' where idcli = 5;
update clientes set fone = '1195865469' where idcli = 3;

select * from clientes;

create table tbos(
	os int primary key auto_increment,
    datacad timestamp default current_timestamp,
    tipo varchar(20) not null,
    defeitocli varchar(200) not null,
    defeitotec varchar(200),
	modelo varchar(50) not null,
    fabricante varchar(50) not null,
    ano char(4) not null,
    placa char(7) unique,
    combustivel varchar(20) not null,
    tecnico int not null,
    foreign key(tecnico) references usuarios(id),
    valor decimal(10,2),
    chassi char(17) not null unique,
    idcli int not null, 
    foreign key(idcli) references clientes(idcli),
    garantia date,
    datasaida date
);

drop table tbos;
describe tbos;

insert into tbos(tipo,defeitocli,defeitotec,modelo,fabricante,ano,placa,combustivel,tecnico,valor,chassi,idcli)
values(
	'Orçamento','Corrente frouxa','Corrente frouxa','Vespa','Lambretta','2021','HGJ6458','Gasolina',1,250,'42043lXZuYw011150','1'
);

insert into tbos(tipo,defeitocli,defeitotec,modelo,fabricante,ano,placa,combustivel,tecnico,valor,chassi,idcli)
values(
	'Orçamento','Problema na partida','Relé de partida quebrado','Dark Horse','Indian','2016','ADS4568','Gasolina',2,5000,'6CTl4uKCA5B4X0532','2'
);

insert into tbos(tipo,defeitocli,defeitotec,modelo,fabricante,ano,placa,combustivel,tecnico,valor,chassi,idcli,garantia)
values(
	'Serviço','Ajuste de freio','Troca da lona','Fan 150','Honda','2017','DSH4652','Gasolina',3,300,'7F1jEs91ll1E76580','3',20220116
);

insert into tbos(tipo,defeitocli,defeitotec,modelo,fabricante,ano,placa,combustivel,tecnico,valor,chassi,idcli)
values(
	'Orçamento','Vela','Chicote','Virago 535','Yamaha','2005','NJD1325','Gasolina',3,500,'4LlGA9R9sXKAy5626','3'
);

insert into tbos(tipo,defeitocli,defeitotec,modelo,fabricante,ano,placa,combustivel,tecnico,valor,chassi,idcli,garantia,datasaida)
values(
	'Finalizado','Troca de óleo','Troca de óleo','F800','BMW','2019','SDH8485','Gasolina',2,80,'2VKC546DkAUCK8945','2',20220217,'20211014'
);

insert into tbos(tipo,defeitocli,defeitotec,modelo,fabricante,ano,placa,combustivel,tecnico,valor,chassi,idcli,garantia,datasaida)
values(
	'Finalizado','Filtro de ar','e troca de óleo','Twister','Honda','2015','JUD4568','Gasolina',1,550.25,'25lnDum3DAzSu8566','1',20220324,20211005
);

-- CRUD Update
update tbos set valor = 85 where os = 5;
update tbos set valor = 550 where os = 4;

select * from tbos;

-- relatorio de tipo da OS 1
select
	date_format(tbos.datacad,'%d/%m/%Y - %H:%i') as entrada,clientes.nome,clientes.fone as telefone,clientes.cel as celular,
    tbos.fabricante,tbos.modelo,tbos.defeitocli as defeito_cliente,tbos.defeitotec as defeito_tecnico,tbos.valor,tbos.tipo
from tbos inner join clientes on tbos.idcli = clientes.idcli where tipo = 'Orçamento';

-- relatorio de tipo da OS 2
select
	date_format(tbos.datacad,'%d/%m/%Y - %H:%i') as entrada,clientes.nome,clientes.fone as telefone,clientes.cel as celular,
    tbos.fabricante,tbos.modelo,tbos.defeitocli as defeito_cliente,tbos.defeitotec as defeito_tecnico,tbos.valor,tbos.tipo
from tbos inner join clientes on tbos.idcli = clientes.idcli where tipo = 'Serviço';

-- relatorio de tipo da OS 3
select
	date_format(tbos.datacad,'%d/%m/%Y - %H:%i') as entrada,clientes.nome,clientes.fone as telefone,clientes.cel as celular,
    tbos.fabricante,tbos.modelo,tbos.defeitocli as defeito_cliente,tbos.defeitotec as defeito_tecnico,tbos.valor,tbos.tipo,
    date_format(tbos.datasaida,'%d/%m/%Y - %H:%i') as retirada,date_format(tbos.garantia,'%d/%m/%Y - %H:%i') as garantia
from tbos inner join clientes on tbos.idcli = clientes.idcli where tipo = 'Finalizado';

-- relatorio do faturamento
select sum(valor) as total from tbos;

-- relatorio garantia
select 
	tbos.os as OS,clientes.nome,tbos.modelo,date_format(tbos.datasaida,'%d/%m/%Y') as retirada,tbos.valor,datediff(tbos.garantia,curdate()) as garantia_restante
from tbos inner join clientes on tbos.idcli = clientes.idcli where tipo = 'Finalizado';