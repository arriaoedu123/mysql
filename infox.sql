/**
	Sistema para gestao de uma assistencia tecnica de computador e perifericos
    @author Arreaum
*/

create database dbinfox;
use dbinfox;

create table usuarios(
	id int primary key auto_increment,
    usuario varchar(50) not null,
    login varchar(50) not null unique,
    senha varchar(250) not null,
    perfil varchar(50) not null
);
select senha from usuarios where id = 1;
describe usuarios;

-- a linha abaixo insere uma senha com criptografia
-- md5() criptografa a senha
insert into usuarios(usuario, login, senha, perfil)
values(
	'Marcondes','admin',md5('123@senac'),'administrador'
);
insert into usuarios(usuario, login, senha, perfil)
values(
	'Josiel','josiel',md5('123@senac'),'operador'
);

select * from usuarios;
select * from usuarios where id = 1;

-- selecionando o usuario de sua respectiva senha (tela de login)
select * from usuarios where login = 'admin' and senha = md5('123@senac');

update usuarios set usuario = 'Marcondes',
login = 'Marcondez', senha = md5('1234@senac'), perfil = 'admin' where id = 2;

delete from usuarios where id = 3;

-- char (tipo de dados que aceita uma String de caracteres nao variaveis)
create table clientes(
	idcli int primary key auto_increment,
    nome varchar(50) not null,
    cep char(8),
    endereco varchar(50) not null,
    numero varchar(12) not null,
    complemento varchar(30),
    bairro varchar(50) not null,
    cidade varchar(50) not null,
    uf char(2) not null,
    fone varchar(15) not null,
    email varchar(100) unique
);

drop table clientes;

describe clientes;

select idcli as ID, nome as Cliente, cep as CEP, endereco as Endereço, numero as Número,
				complemento as Complemento, bairro as Bairro, cidade as Cidade, uf as UF, fone as Fone,
				email as Email from clientes where nome like "k%";

update clientes set nome = 'teste2', fone = '321', cep = '321', endereco = 'teste', numero = '321', complemento = 'teste', bairro = 'teste', cidade = 'teste',uf = 'SP' where idcli = ?;

insert into clientes(nome,cep,endereco,numero,complemento,bairro,cidade,uf,fone,email)
values(
	'Kratos','12345678','Rua Um','1','Casa','Vila Um','São Um','SP','123456789','emailum@exemplo'
);
insert into clientes(nome,cep,endereco,numero,complemento,bairro,cidade,uf,fone,email)
values(
	'Kleiton','87654321','Rua Dois','2','Casa','Vila Dois','São Dois','SP','987654321','emaildois@exemplo'
);
insert into clientes(nome,cep,endereco,numero,complemento,bairro,cidade,uf,fone,email)
values(
	'Klaitos','12348765','Rua Tres','3','Casa','Vila Tres','São Tres','SP','123459876','emailtres@exemplo'
);
insert into clientes(nome,cep,endereco,numero,complemento,bairro,cidade,uf,fone,email)
values(
	'Aitros','87651234','Rua Quatro','4','Casa','Vila Quatro','São Quatro','SP','987612345','emailquatro@exemplo'
);
insert into clientes(nome,cep,endereco,numero,complemento,bairro,cidade,uf,fone,email)
values(
	'Bladur','18273645','Rua Cinco','5','Casa','Vila Cinco','São Cinco','SP','918273645','emailcinco@exemplo'
);

select * from clientes;

-- foreign key (FK) cria um relacionamento de 1 para muitos (cliente - tbos)
create table tbos(
	os int primary key auto_increment,
    dataos timestamp default current_timestamp,
    tipo varchar(20) not null,
    statusos varchar(30) not null,
    equipamento varchar(200) not null,
    defeito varchar(200) not null,
    tecnico varchar(50),
    valor decimal(10,2),
	idcli int not null, 
    foreign key(idcli) references clientes(idcli)
);

drop table tbos;

describe tbos;

insert into tbos(tipo,statusos,equipamento,defeito,idcli)
values(
	'orçamento','na bancada','notebook lenovo g90','não liga',1
);
insert into tbos(tipo,statusos,equipamento,defeito,idcli)
values(
	'manutenção','em análise','motorola g100','touch defeituoso',2
);
insert into tbos(tipo,statusos,equipamento,defeito,tecnico,valor,idcli)
values(
	'orçamento','aguardando aprovação','dell optiplex 7040','sem vídeo','Marcondes',150,3
);
insert into tbos(tipo,statusos,equipamento,defeito,tecnico,valor,idcli)
values(
	'orçamento','retirado','hp deskjet 2564','carrinho com defeito','Marcondes',300,4
);
insert into tbos(tipo,statusos,equipamento,defeito,tecnico,valor,idcli)
values(
	'manutenção','aguardando aprovação','desktop','sistema corrompido','Josiel',80,5
);

select * from tbos;

-- (inner join) uniao de tabelas relacionadas para consultas e updates
-- relatorio 1
select os as OS, dataos as DataOS, tipo as Tipo, statusos as Status, equipamento as Equipamento, defeito as Defeito, tecnico as Técnico, valor as Valor from tbos inner join clientes on tbos.idcli and os = clientes.idcli;

-- relatorio 2
select 
	tbos.equipamento,tbos.defeito,tbos.statusos as status_os,tbos.valor,
	clientes.nome,clientes.fone
from tbos inner join clientes on tbos.idcli = clientes.idcli where statusos = 'aguardando aprovação';

-- relatorio 3 (os,data formatada(dia,mes e ano),equipamento,defeito,valor,nome do cliente) filtrando por retirado
select
	tbos.idcli,date_format(dataos,'%d/%m/%Y - %H:%i') as data_os,tbos.equipamento,tbos.defeito,tbos.valor,
    clientes.nome
from tbos inner join clientes on tbos.idcli = clientes.idcli where statusos = 'retirado';

-- relatorio 4
-- faturamento
select sum(valor) as total from tbos;