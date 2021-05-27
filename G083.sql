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
    Ano_Edicao number(4,0),
    --numero de copias
    Num_Copias number(3,0),
	primary key (ID_Livro)
    );
    
-- Tabela de pessoas em que cada uma tem um dado codigo BI, a data em que nasceu
-- e o seu nome completo
create table Pessoas(
    -- Numero identificador da pessoa (Bilhete de Identidade/ Cartao de cidadao)
    BI number(9,0),
    -- Quando a pessoa foi trazida para este mundo
    data_Nascimento DATE,
    -- O primeiro e ultimo nome do individuo
    nome_Pessoa varchar(30),
	primary key (BI)
    );

create table Empregados(
    BI number(9,0),
    -- O montante que o individuo recebe ao mês
    salario number(4,0),
    -- Numero identificador do empregado (numero gerado pela biblioteca)
    ID_Empregado number(5,0),
	primary key (BI),
	foreign key (BI) references Pessoas(BI)
    );
   
create table Autores(
    BI number(9,0),
    -- Numero identificador do autor (numero gerado pela biblioteca)
    ID_Autor number(5,0),
    --TODO:
    pseudonimo varchar(30), -- possivel lista para incluir todos os pseudónimos
    -- Fernando Pessoa -> Ricardo Reis, Alberto Caeiro, Alvaro de Campos, Bernardo Soares
	primary key (BI),
	foreign key (BI) references Pessoas(BI)
    );
   
create table Usuarios(
    BI number(9,0),
    -- Data da ultima entrada que o individuo fez na biblioteca
    registoEntrada DATE,
    -- Numero identificador do usuario (numero gerado pela biblioteca)
    ID_Usuario number(5,0),
	primary key (BI),
	foreign key (BI) references Pessoas(BI)
    );
   
create table Membros(
    BI number(9,0),
    -- Numero do cartao atribuido para os membros (numero gerado pela biblioteca)
    num_Cartao number(3,0),
	primary key (BI),
	foreign key (BI) references Pessoas(BI)
    );
   
create table Temas(
    -- Numero identificador do tema (numero gerado pela biblioteca)
    ID_Tema number(3,0),
    -- Nome do tema correspondente
    nome_Tema varchar(20),
	primary key(ID_Tema)
    );
   
create table Reservas(
    -- Numero identificador da reserva (numero gerado pela biblioteca)
    ID_Reserva number(6,0),
    -- Data do inicio da reserva (quando o membro pode levar o livro para fora da biblioteca)
    data_Inicio DATE,
    -- Data de devolucao do livro (data-limite para o membro entregar o livro para a biblioteca)
    data_Devolucao DATE,
    -- Numero identificador do livro que foi reservado
    ID_Livro number(5,0),
    -- Numero identificador do membro que fez a reserva
    BI number(9,0),
	primary key (ID_Reserva),
	unique(ID_Livro, BI),
	foreign key (ID_Livro) references Livros(ID_Livro),
	foreign key (BI) references Membros(BI)
    );
  
create table Postos_De_Trabalho(
    -- Numero identificador do posto de trabalho (numero gerado pela biblioteca)
    ID_Trabalho number(2,0),
    -- Descricao da funcao de tal posto de trabalho
    descr_Trabalho varchar(50),
    primary key (ID_Trabalho)
    );
  
create table Encomendas(
    -- Numero identificador da encomenda (numero gerado pela biblioteca)
    ID_Encomenda number(5,0),
    -- Zona de onde veio a encomenda de livros (Leiria, Lisboa, ...)
    zonaOrigem varchar(25),
    primary key (ID_Encomenda)
    );

-- TODO:
-- Independemente do valor que insira no timestamp, ele da sempre valores do tipo 'HH:MIN:SS:FF9' que nao e o que nos queremos
-- Nos queremos valores do tipo 'HH:MIN:SS', podemos ter que perguntar o professor sobre isto.
create table Eventos(
    -- Data do evento para realizar na biblioteca
    data_Evento DATE,
    -- Hora em que comeca o evento
    hora_Evento_Inicio timestamp(1), --'20:25'
    -- Hora em que o evento termina
    hora_Evento_Fim timestamp(1), --'21:00'
    -- Quantidade de pessoas que o evento pode aguentar para realizar o evento em condicoes
    capacidade number(3,0),
    primary key (data_Evento, hora_Evento_Inicio)
    );
 
create table Palestras(
    data_Evento DATE,
   hora_Evento_Inicio timestamp(1),
   -- Topico da palestra a ser realizada
    topico varchar(30),
    -- Numero identificador do autor que ira apresentar a palestra
    BI varchar(10),
    primary key (data_Evento, hora_Evento_Inicio),
    foreign key (data_Evento, hora_Evento_Inicio) references Eventos(data_Evento, hora_Evento_Inicio)
    );
  
create table Filmes(
    data_Evento DATE,
    hora_Evento_Inicio timestamp(1),
    -- Nome do filme que sera apresentado na biblioteca
    nome_Filme varchar(30),
    -- Duracao do filme em minutos
    duracao number(3,0),
    primary key (data_Evento, hora_Evento_Inicio),
    foreign key (data_Evento, hora_Evento_Inicio) references Eventos(data_Evento, hora_Evento_Inicio)
    );
  
create table Encomendados(
    -- Numero identificador da encomenda associada
    ID_Encomenda number(5,0),
    -- Numero identificador do livro que foi encomendado
    ID_Livro number(5,0),
    -- Quantidade de copias que vao ser adicionadas para a biblioteca
    quantidade number(3,0),
    primary key (ID_Encomenda,ID_Livro),
    foreign key (ID_Livro) references Livros(ID_Livro),
    foreign key (ID_Encomenda) references Encomendas(ID_Encomenda)
    );
  
create table Escritos_Por(
    -- Numero identificador do livro que foi escrito
    ID_Livro number(5,0),
    -- Numero identificador do individuo que escreveu o livro
    BI number(9,0),
    primary key (ID_Livro, BI),
    foreign key (ID_Livro) references Livros(ID_Livro),
    foreign key (BI) references Autores(BI)
    );
  
create table Baseados_Em(
    -- Dia em que foi apresentado o filme
    data_Evento DATE,
    -- Hora em que deu inicio a visualizacao do filme
    hora_Evento_Inicio timestamp(1),
    -- O livro em que o filme foi baseado em / inspirou para a formacao do livro (?)
    ID_Livro number(5,0),
    primary key (data_Evento, hora_Evento_Inicio,  ID_Livro),
    foreign key (data_Evento, hora_Evento_Inicio) references Filmes(data_Evento, hora_Evento_Inicio),
    foreign key (ID_Livro) references Livros(ID_Livro)
    );
 
create table de(
    -- Numero identificador do tema
    ID_Tema number(3,0),
    -- Numero identificador do livro que tem o tal tema
    ID_Livro number(5,0),
    primary key (ID_Tema, ID_Livro),
    foreign key (ID_Tema) references Temas(ID_Tema),
    foreign key (ID_Livro) references Livros(ID_Livro)
    );
 
create table Trabalha_Em(
    -- Numero identificador do posto de trabalho
    ID_Trabalho number(2,0),
    -- Numero identificador do empregado que desempenha tal funcao de trabalho na biblioteca
    BI number(9,0),
    primary key (ID_Trabalho, BI),
    foreign key (ID_Trabalho) references Postos_De_Trabalho(ID_Trabalho),
    foreign key (BI) references Empregados(BI)
    );
  
create table assistiu(
    data_Evento DATE,
    hora_Evento_Inicio timestamp(1),
    -- Numero identificador do individuo que assistiu o evento
    BI number(9,0),
    primary key (data_Evento, hora_Evento_Inicio, BI),
    foreign key (data_Evento, hora_Evento_Inicio) references Eventos(data_Evento, hora_Evento_Inicio),
    foreign key (BI) references Pessoas(BI)
    );

-- Insercoes
drop sequence num_BI_Pessoas;
create sequence num_BI_Pessoas
start with 1
increment by 1;
    
delete from Pessoas;
insert into Pessoas values (num_BI_Pessoas.nextval, '2000-01-22', 'Bruno Cabrita');
insert into Pessoas values (num_BI_Pessoas.nextval, '1999-03-25', 'Bruno Braga');
insert into Pessoas values (num_BI_Pessoas.nextval, '1998-05-13', 'Alexandre Godinho');
insert into Pessoas values (num_BI_Pessoas.nextval, '1888-06-13', 'Fernando Pessoa');
insert into Pessoas values (num_BI_Pessoas.nextval, '1845-11-25', 'Eca de Queiros');
insert into Pessoas values (num_BI_Pessoas.nextval, '1922-11-16', 'Jose Saramago');
insert into Pessoas values (num_BI_Pessoas.nextval, '1919-11-06', 'Sophia de Mello Breyner');
select * from Pessoas;

drop sequence num_ID_Livros;
create sequence num_ID_Livros
start with 10
increment by 1;

delete from Livros;
insert into Livros values (num_ID_Livros.nextval, 'Mensagem', 'António Ferro', '1934', 5);
insert Into Livros values (num_ID_Livros.nextval, 'Mensagem', 'Porto Editora', '2007', 20);
insert into Livros values (num_ID_Livros.nextval, 'O Ano da Morte de Ricardo Reis', 'Porto Editora', '2021', 30); 
insert into Livros values (num_ID_Livros.nextval, 'Os Maias', 'Porto Editora', '2006', 20);
insert into Livros values (num_ID_Livros.nextval, 'Auto da Barca do Inferno', 'A Bela e o Monstro', '2000', 25);
insert into Livros values (num_ID_Livros.nextval, 'Memorial do Convento', 'Porto Editora', '2021', 30);
select * from Livros;

drop sequence num_ID_Trabalhos;
create sequence num_ID_Trabalhos
start with 24
increment by 2;

delete from Postos_De_Trabalho;
insert into Postos_De_Trabalho values (num_ID_Trabalhos.nextval, 'Atendimento ao Publico em Balcao');
insert into Postos_De_Trabalho values (num_ID_Trabalhos.nextval, 'Organizacao de Livros');
insert into Postos_De_Trabalho values (num_ID_Trabalhos.nextval, 'Gestao de Financas');
insert into Postos_De_Trabalho values (num_ID_Trabalhos.nextval, 'Vigilancia');
select * from Postos_De_Trabalho;

drop sequence num_ID_Empregados;
create sequence num_ID_Empregados
start with 100
increment by 1;

delete from Empregados;
insert into Empregados values (1, 300, num_ID_Empregados.nextval);
insert into Empregados values (2, 600, num_ID_Empregados.nextval);
insert into Empregados values (3, 450, num_ID_Empregados.nextval);

select * from Empregados;

delete from Eventos;

insert into Eventos values('2021-5-28', '2021-5-28 10:00:00', '2021-5-28 12:00:00', 50);
insert into Eventos values('2021-4-22', '2021-4-22 9:00', '2021-4-22 11:00', 100);
insert into Eventos values('2020-12-30', '2020-12-30 15:00', '2020-12-30 16:00', 75);
select * from Eventos;  
-- Triggers

-- Queries interessantes

--

        
    