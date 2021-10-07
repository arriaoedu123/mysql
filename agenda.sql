/**
	Agenda de Contatos
    @author Arreaum
*/

-- exibir banco de dados do servidor
show databases;
-- criar um novo banco de dados
create database dbagenda;

-- excluir um banco de dados
drop database dbteste;
-- selecionar o banco de dados
use dbagenda;

-- verificar tabelas existentes
show tables;

-- criando uma tabela
-- toda tabela precisa ter uma chave primaria (PK)
-- int (tipo de dados -> numeros inteiros
-- primary key -> transforma este campo em chave primaria
-- auto_increment -> numeracao automatica
-- varchar (tipo de dados equivalente a String (50) -> numero maximo de caracteres)
-- not null -> preenchimento obrigatorio
-- unique -> nao permite valores duplicados na tabela
create table contatos(
	id int primary key auto_increment,
    nome varchar(50) not null,
    fone varchar(15) not null,
    email varchar(50) unique
);

-- descricao da tabela
describe contatos;

-- alterar o nome de um campo na tabela
alter table contatos change nome contato varchar(50) not null;

-- adicionar um novo campo a tabela
alter table contatos add column obs varchar(250);

-- adicionar um novo campo(coluna) em um local especifico da tabela
alter table contatos add column fone2 varchar(15) after fone;

-- modificar o tipo de dados da coluna e/ou validacoes na coluna
alter table contatos modify column fone2 int;
alter table contatos modify column email varchar(100) not null;

-- excluir uma coluna da tabela
alter table contatos drop column obs;

-- excluir a tabela
drop table contatos;

-- CRUD (Create Read Update Delete)
-- operacoes basicas do banco de dados

-- CRUD Create
insert into contatos(nome,fone,email) values ('Arreaum', '99999-1111', 'arreaum@exemplo.com');
insert into contatos(nome,fone,email) values ('Robson Vaamonde', '99999-2222', 'vaamonde@exemplo.com');
insert into contatos(nome,fone,email) values ('Ismaelish', '99999-3333', 'ismaelish@exemplo.com');
insert into contatos(nome,fone,email) values ('Morcego', '99999-4444', 'morcego@exemplo.com');
insert into contatos(nome,fone,email) values ('José', '99999-5555', 'jose@exemplo.com');
insert into contatos(nome,fone,email) values ('Mário', '99999-6666', 'mario@exemplo.com');

-- CRUD Read
-- selecionar todos os registros(dados) da tabela
select * from contatos;

-- selecionar colunas especificas da tabela
select nome, fone from contatos;

-- selecionar colunas em ordem crescente e decrescente(asc desc)
select * from contatos order by nome;
select id, nome from contatos order by id desc;

-- uso de filtros
select * from contatos where id = 1;
select * from contatos where nome = 'Ismaelish';
select * from contatos where nome like 'M%';

-- CRUD Update
-- ATENCAO! Nao esqueca do where e usar sempre o id para evitar problema e nao ser demitido
update contatos set fone = '99999-9999' where id = 4;
update contatos set email = 'macarrao@exemplo.com' where id = 2;

-- CRUD delete
-- ATENCAO! Nao esqueca do where e usar sempre o id para evitar problema e nao ser demitido
delete from contatos where id = 1;                                                                                                