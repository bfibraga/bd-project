drop table Livros cascade constraints;
drop table Pessoas cascade constraints;
drop table Empregados cascade constraints;
drop table Autores cascade constraints;
drop table  Usuarios cascade constraints;
drop table Membros cascade constraints;
drop table Temas cascade constraints;
drop table Reservas cascade constraints;
drop table Postos_de_Trabalho cascade constraints;
drop table Encomendas cascade constraints;
drop table Eventos cascade constraints;
drop table Palestras cascade constraints;
drop table Filmes cascade constraints;
drop table Encomendados cascade constraints;
drop table Escritos_Por cascade constraints;
drop table Baseados_Em cascade constraints;
drop table de cascade constraints;
drop table Trabalha_Em cascade constraints;
drop table assistiu cascade constraints;


-- Tabela dos livros em que cada um tem um dado id, o seu titulo, a editora e o
--  ano da edicao
create table Livros(
    -- Id usado para identificar por entre a base de dados (chave primaria)
    ID_Livro number(5,0),
    -- Titulo do livro
    Titulo varchar(30),
    -- nome da editora do livro
    Editora varchar(30),
    -- ano da edicao
    Edicao number(4,0)
    );
    
alter table Livros add constraint pk_Livros primary key (ID_Livro);

-- Tabela de pessoas em que cada uma tem um dado codigo BI, a data em que nasceu
-- e o seu nome completo
create table Pessoas(
    BI varchar(10),
    data_Nascimento DATE,
    nome_Pessoa varchar(30)
    );
    
alter table Pessoas add constraint pk_Pessoas primary key (BI);
    
-- 
create table Empregados(
    BI varchar(10),
    salario number(4,0),
    ID_Empregado number(5,0)
    );
    
alter table Empregados add constraint pk_Empregados primary key (BI);
alter table Empregados add constraint fk_PessoaEmp foreign key (BI) references Pessoas(BI);
    
create table Autores(
    BI varchar(10),
    ID_Autor number(5,0),
    pseudonimo varchar(30)
    );
    
alter table Autores add constraint pk_Autores primary key (BI);
alter table Autores add constraint fk_PessoaAut foreign key (BI) references Pessoas(BI);
    
create table Usuarios(
    BI varchar(10),
    registoEntrada DATE,
    ID_Usuario number(5,0)
    );
    
alter table Usuarios add constraint pk_Usuarios primary key (BI);
alter table Usuarios add constraint fk_PessoaUsuario foreign key (BI) references Pessoas(BI);
    
create table Membros(
    BI varchar(10),
    num_Cartao number(3,0)
    );
    
alter table Membros add constraint pk_Membros primary key (BI);
alter table Membros add constraint fk_PessoaMembro foreign key (BI) references Pessoas(BI);
    
create table Temas(
    ID_Tema number(3,0),
    nome_Tema varchar(20)
    );
    
alter table Temas add constraint pk_Temas primary key (ID_Tema);
    
create table Reservas(
    ID_Reserva number(6,0),
    data_Inicio DATE,
    data_Devolucao DATE,
    ID_Livro number(5,0),
    BI varchar(10)
    );
    
alter table Reservas add constraint pk_Reservas primary key (ID_Reserva);
alter table Reservas add constraint uniq_LivroMembro unique(ID_Livro, BI);
alter table Reservas add constraint fk_ReservaLivro foreign key (ID_Livro) references Livros(ID_Livro);
alter table Reservas add constraint fk_ReservaMembro foreign key (BI) references Membros(BI);

    
create table Postos_De_Trabalho(
    descr_Trabalho varchar(50),
    ID_Trabalho number(3,0)
    );
    
alter table Postos_De_Trabalho add constraint pk_Postos primary key (ID_Trabalho);
    
create table Encomendas(
    ID_Encomenda number(5,0),
    zonaOrigem varchar(25)
    );
    
alter table Encomendas add constraint pk_Encomendas primary key (ID_Encomenda);
    
create table Eventos(
    data_Evento DATE,
    hora_Evento_Inicio varchar(5), --'20:25'
    hora_Evento_Fim varchar(5), --'21:00'
    capacidade number(3,0)
    );
    
alter table Eventos add constraint pk_Eventos primary key (data_Evento, hora_Evento_Inicio);
    
create table Palestras(
    data_Evento DATE,
    hora_Evento_Inicio varchar(5),
    topico varchar(30),
    BI varchar(10)
    );
    
alter table Palestras add constraint pk_Palestras primary key (data_Evento, hora_Evento_Inicio);
alter table Palestras add constraint fk_EventoPalestras foreign key (data_Evento, hora_Evento_Inicio) references Eventos(data_Evento, hora_Evento_Inicio);

    
create table Filmes(
    data_Evento DATE,
    hora_Evento_Inicio varchar(5),
    nome_Filme varchar(30),
    duracao number(3,0)
    );
    
alter table Filmes add constraint pk_Filmes primary key (data_Evento, hora_Evento_Inicio);
alter table Filmes add constraint fk_EventoFilmes foreign key (data_Evento, hora_Evento_Inicio) references Eventos(data_Evento, hora_Evento_Inicio);
    
create table Encomendados(
    ID_Encomenda number(5,0),
    ID_Livro number(5,0),
    quantidade number(3,0)
    );
    
alter table Encomendados add constraint pk_Encomendados primary key (ID_Encomenda,ID_Livro);
alter table Encomendados add constraint fk_LivroEncomendados foreign key (ID_Livro) references Livros(ID_Livro);
alter table Encomendados add constraint fk_EncomendaEncomendados foreign key (ID_Encomenda) references Encomendas(ID_Encomenda);

    
create table Escritos_Por(
    ID_Livro number(5,0),
    BI varchar(10)
    );
    
alter table Escritos_Por add constraint pk_EscritosPor primary key (ID_Livro, BI);
alter table Escritos_Por add constraint fk_LivroEscritosPor foreign key (ID_Livro) references Livros(ID_Livro);
alter table Escritos_Por add constraint fk_AutorEscritosPor foreign key (BI) references Autores(BI);
    
create table Baseados_Em(
    data_Evento DATE,
    hora_Evento_Inicio varchar(5),
    ID_Livro number(5,0)
    );
    
alter table Baseados_Em add constraint pk_BaseadosEm primary key (data_Evento, hora_Evento_Inicio,  ID_Livro);
alter table Baseados_Em add constraint fk_FilmeBaseadosEm foreign key (data_Evento, hora_Evento_Inicio) references Filmes(data_Evento, hora_Evento_Inicio);
alter table Baseados_Em add constraint fk_LivroBaseadosEm foreign key (ID_Livro) references Livros(ID_Livro);
    
create table de(
    ID_Tema number(3,0),
    ID_Livro number(5,0)
    );
    
alter table de add constraint pk_de primary key (ID_Tema, ID_Livro);
alter table de add constraint fk_TemaDe foreign key (ID_Tema) references Temas(ID_Tema);
alter table de add constraint fk_LivroDe foreign key (ID_Livro) references Livros(ID_Livro);
    
create table Trabalha_Em(
    ID_Trabalho number(3,0),
    BI varchar(10)
    );
    
alter table Trabalha_Em add constraint pk_TrabalhaEm primary key (ID_Trabalho, BI);
alter table Trabalha_Em add constraint fk_PostosTrabalhaEm foreign key (ID_Trabalho) references Postos_De_Trabalho(ID_Trabalho);
alter table Trabalha_Em add constraint fk_EmpregadoTrabalhaEm foreign key (BI) references Empregados(BI);   
    
create table assistiu(
    data_Evento DATE,
    hora_Evento_Inicio varchar(5),
    BI varchar(10)
    );
    
alter table assistiu add constraint pk_assistiu primary key (data_Evento, hora_Evento_Inicio, BI);
alter table assistiu add constraint fk_EventoAssistiu foreign key (data_Evento, hora_Evento_Inicio) references Eventos(data_Evento, hora_Evento_Inicio);
alter table assistiu add constraint fk_PessoaAssistiu foreign key (BI) references Pessoas(BI);

-- Insercoes
delete from Pessoas;
insert into Pessoas values ('0000000000', '2000-01-22', 'Bruno Cabrita');
insert into Pessoas values ('0000000001', '1999-03-25', 'Bruno Braga');
insert into Pessoas values ('0000000002', '1998-05-13', 'Alexandre Godinho');
insert into Pessoas values ('3125125141', '1888-06-13', 'Fernando Pessoa');
insert into Pessoas values ('312541251', '1845-11-25', 'Eca de Queiros');
insert into Pessoas values ('6144512412', '1922-11-16', 'Jose Saramago');
insert into Pessoas values ('4314343444', '1919-11-06', 'Sophia de Mello Breyner');
select * from Pessoas;
-- Triggers

-- Queries interessantes

--

    
    