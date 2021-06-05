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
drop table recebidos_por cascade constraints;


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
    -- O montante que o individuo recebe ao mes
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
    pseudonimo varchar(300), -- possivel lista para incluir todos os pseudonimos
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
    -- Numero para verificar se ja foi entregue a livro a biblioteca ou nao
    entregue number(1,0),
	primary key (ID_Reserva),
	--unique(ID_Livro, BI),
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
    topico varchar(50),
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
    
create table recebidos_por(
     ID_Encomenda number(5,0),
     BI number(9,0),
     primary key (ID_Encomenda, BI),
     foreign key (BI) references Empregados(BI),
     foreign key (ID_Encomenda) references Encomendas(ID_Encomenda)
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
insert into Pessoas values (num_BI_Pessoas.nextval, '2000-11-23', 'Joao Vieira');
select * from Pessoas;

drop sequence num_ID_Livros;
create sequence num_ID_Livros
start with 10
increment by 1;

delete from Livros;
insert into Livros values (num_ID_Livros.nextval, 'Mensagem', 'Antonio Ferro', '1934', 5);
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
select * from Empregados;

drop sequence num_ID_Autores;
create sequence num_ID_Autores
start with 200
increment by 1;

delete from Autores;
insert into Autores values(4, num_ID_Autores.nextval, 'Ricardo Reis, Alberto Caeiro, Alvaro de Campos, Bernado Soares');
insert into Autores values(5, num_ID_Autores.nextval, 'Eca de Queiros');
insert into Autores values(6, num_ID_Autores.nextval, 'Jose Saramago');
insert into Autores values(7, num_ID_Autores.nextval, 'Sophia Breyner');
select * from Autores;

delete from Eventos;
insert into Eventos values('2000-5-28', '2000-5-28 10:00:00', '2001-5-28 12:00:00', 50);
insert into Eventos values('2001-4-22', '2001-4-22 9:00', '2001-4-22 11:00', 100);
insert into Eventos values('2020-12-30', '2020-12-30 15:00', '2020-12-30 16:00', 75);
select * from Eventos;  

delete from Palestras;
insert into Palestras values('2000-5-28', '2000-5-28 10:00:00', 'Romance no Ar', 7);
insert into Palestras values('2001-4-22', '2001-4-22 9:00', 'Individuo vs Sociedade', 6);
select * from Palestras;

delete from Filmes;
insert into Filmes values('2020-12-30', '2020-12-30 15:00', 'Os Misterios de Lisboa', 130);
select * from Filmes;

drop sequence num_ID_Usuarios;
create sequence num_ID_Usuarios
start with 250
increment by 2;

delete from Usuarios;
insert into Usuarios values(3,'2021-05-22', num_ID_Usuarios.nextval);
insert into Usuarios values(8, '2021-06-23', num_ID_Usuarios.nextval);
select * from Usuarios;

drop sequence num_ID_Cartao;
create sequence num_ID_Cartao
start with 321
increment by 2;

delete from Membros;
insert into Membros values(3, num_ID_Cartao.nextval);
insert into Membros values(8, num_ID_Cartao.nextval);
select * from Membros;

drop sequence num_ID_Tema;
create sequence num_ID_Tema
start with 911
increment by 1;

delete from Temas;
insert into Temas values(num_ID_Tema.nextval, 'Romance');
insert into Temas values(num_ID_Tema.nextval, 'Tragedia');
insert into Temas values(num_ID_Tema.nextval, 'Accao');
insert into Temas values(num_ID_Tema.nextval, 'Terror');
insert into Temas values(num_ID_Tema.nextval, 'Humor');
select * from Temas;

drop sequence num_ID_Encomendas;
create sequence num_ID_Encomendas
start with 300
increment by 1;

delete from Encomendas;
insert into Encomendas values(num_ID_Encomendas.nextval);
insert into Encomendas values(num_ID_Encomendas.nextval);
insert into Encomendas values(num_ID_Encomendas.nextval);
select * from Encomendas;

drop sequence num_ID_Reserva;
create sequence num_ID_Reserva
start with 1
increment by 2;

delete from Reservas;
insert into Reservas values(num_ID_Reserva.nextval, '2000-10-21', '2000-11-21',11, 3, 1);
insert into Reservas values(num_ID_Reserva.nextval, '2020-10-21', '2020-11-21',11, 3, 0);
insert into Reservas values(num_ID_Reserva.nextval, '2020-10-24', '2020-11-22',13, 3, 0);
insert into Reservas values(num_ID_Reserva.nextval, '2020-10-24', '2020-11-22',15, 3, 0);
insert into Reservas values(num_ID_Reserva.nextval, '2020-10-01', '2020-11-25',15, 8, 0);
select * from Reservas;

delete from Escritos_Por;
--'Mensagem' de Porto Editora escrito por Fernando Pessoa
insert into Escritos_Por values(10, 4);
--'Os Maias' escrito por Eca de Queiros
insert into Escritos_Por values(13, 5);
select * from Escritos_Por;

delete from de;
insert into de values(911, 11);
insert into de values(912, 13);
select * from de;

delete from Trabalha_Em;
insert into Trabalha_Em values(24,1);
insert into Trabalha_Em values(26,1);
insert into Trabalha_Em values(30,2);
select * from Trabalha_Em;

delete from assistiu;
insert into assistiu values('2000-5-28', '2000-5-28 10:00:00',1);
insert into assistiu values('2000-5-28', '2000-5-28 10:00:00',2);
insert into assistiu values('2020-12-30', '2020-12-30 15:00',3);
select * from assistiu;

delete from Baseados_Em;
insert into Baseados_Em values('2020-12-30', '2020-12-30 15:00',10);
insert into Baseados_Em values('2020-12-30', '2020-12-30 15:00',11);
select * from Baseados_Em;

-- Fun��es 

-- Fun��o que retorna numero de reservas ativas de uma pessoa dado o seu BI
 create or replace function reservas_ativas(BI_pessoa IN Number)
        return number
        IS num_livros number(1,0);
        BEGIN
            SELECT count(distinct ID_Reserva)
            INTO num_livros
            FROM Reservas
            WHERE entregue = 0 and BI = BI_pessoa;
            RETURN (num_livros);
        END;
    /
    
-- Fun��o que retorna o numero de postos de trabalho de um empregado dado o seu BI
create or replace function trabalhos_de_funcionario(BI_funcionario IN Number)
        return number
        IS num_trabalhos number(3,0);
        BEGIN
            SELECT count(distinct ID_Trabalho)
            into num_trabalhos
            FROM Trabalha_em
            WHERE Trabalha_em.BI = BI_funcionario;
            RETURN (num_trabalhos);
        END;
/


create or replace function capacidade_do_evento(date_event IN DATE, hour_event IN TIMESTAMP)
        return number
        IS capacity_event number(3,0);
        BEGIN
            SELECT capacidade
            into capacity_event
            FROM Eventos
            WHERE Eventos.Data_Evento = date_event and Eventos.Hora_Evento_Inicio = hour_event;
            RETURN capacity_event;
        END;
        /
        
create or replace function lotacao_evento(date_event IN DATE, hour_event IN TIMESTAMP)
        return number
        IS capacity_event number(3,0);
        BEGIN
            SELECT count(distinct BI)
            into capacity_event
            FROM assistiu
            WHERE assistiu.data_Evento = date_event and assistiu.Hora_Evento_Inicio = hour_event;
            RETURN capacity_event;
        END;
        /

-- Triggers and Constraints

--O autor a apresentar a palestra, automaticamente esta a assistir a palestra 
-- Trigger para inserir na tabela assistiu
--drop trigger autor_assiste_palestra;
create or replace trigger autor_assiste_palestra after insert on Palestras
    for each row
    begin
        insert into assistiu values (:NEW.data_Evento, :NEW.hora_Evento_Inicio, :NEW.BI);
    end;
/

-- Um usuario so pode entrar num evento se a capacidade n�o exceder o seu limite.

--Um membro so pode ter no maximo 3 reservas ativas (ou seja, se um membro tiver 3 reservas em que
-- ainda nao entregou o livro, esse mesmo membro nao pode efetuar mais nenhuma reserva ate que uma
-- das que tem ficar entregue na biblioteca)
-- Possivel constraint com check

--drop trigger only_3_active_reserves;
create or replace trigger only_3_active_reserves before insert on Reservas
    for each row
    begin   
        if (reservas_ativas(:NEW.BI) > 2)
        then RAISE_APPLICATION_ERROR(-20000, 'Erro');
    end if;
    end;
/

select BI, reservas_ativas(BI)
from Reservas
group by BI
order by BI;

insert into Reservas values(num_ID_Reserva.nextval, '2020-10-01', '2020-11-25',15, 3, 0);

select BI, reservas_ativas(BI)
from Reservas
group by BI
order by BI;

-- Uma encomenda dum dado livro e realizada, em pacotes de 25, quando a quantidade de copias presentes na biblioteca
-- sao insuficientes para todos os usuarios.
-- Trigger para inserir na tabela encomendas (Como escolher a zonaOrigem?)


-- Um empregado nao pode desempenhar mais que duas funcoes (postos de trabalho) para aliviar o esforco
-- necessario para trabalhar na biblioteca.
-- Possivel constraint com check
create or replace trigger only_2_active_workstations before insert on Trabalha_Em
    for each row
    begin  
        if (trabalhos_de_funcionario(:NEW.BI) > 1)
        then RAISE_APPLICATION_ERROR(-20001, 'Nao pode fazer mais que dois postos de trabalho');
        end if;
    end;
/

-- Fazer uma encomenda
--TODO: SQL Error
--drop trigger fazer_encomenda;
create or replace trigger fazer_encomenda
    after insert on Usuarios
    for each row
    declare numero_livros integer;
    numero_usuarios integer;
    encomenda integer;
    begin
        select count(*) into numero_usuarios from Usuarios;
        select sum(Num_Copias) into numero_livros from Livros;
        if (numero_livros > numero_usuarios) then 
            encomenda := num_ID_Encomendas.nextval;
            insert into Encomendas values (encomenda);
            insert into Encomendados values(encomenda, ID_Livro, 5);
            update Livros set num_copias = num_copias + 5 where Livros.ID_Livro = ID_Livro;
        end if;
    end;
/

create or replace trigger over_capacity 
    before insert on assistiu
    for each row
    begin  
        if (lotacao_evento(:NEW.Data_Evento, :NEW.Hora_Evento_Inicio) = capacidade_do_evento(:NEW.Data_Evento, :NEW.Hora_Evento_Inicio))
        then RAISE_APPLICATION_ERROR(-20002, 'Capacidade atingida no evento');
        end if;
    end;
/

-- Queries interessantes

-- Procurar as datas e horas de palestras dadas por um autor que escreveu um dado livro.
select *
from Escritos_Por inner join Palestras using (BI);



-- Nomes e BI�s de empregados que tenham recebido encomendas de livros escritos por um dado autor.

-- Nomes das pessoas que foram assistir a um filme baseado num livro de um dado tema.

-- T�tulo dos livros reservados por um dado membro.

-- T�picos apresentados por um dado autor.

-- 

        
--alter table assistiu add constraint chk_over_capacity check ((lotacao_evento(data_Evento, hora_Evento_Inicio)) <= (capacidade_do_evento(data_Evento, hora_Evento_Inicio)));

