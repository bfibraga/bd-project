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
drop table lidos cascade constraints;


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
    
    alter table Livros add constraint valid_copies check (Num_Copias > 0);
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
    
    alter table Empregados add constraint valid_salary check (salario > 0);
   
create table Autores(
    BI number(9,0),
    -- Numero identificador do autor (numero gerado pela biblioteca)
    ID_Autor number(5,0),
    --Pseudonimo mais conhecido
    pseudonimo varchar(30), 
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
    
    alter table Reservas add constraint valid_time_interval check (data_Inicio < data_Devolucao);
  
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
    
    alter table Eventos add constraint valid_event_time_interval check (hora_Evento_Inicio < hora_Evento_Fim);
    alter table Eventos add constraint CHK_EVENT check(capacidade > 0);
    
create table Palestras(
    data_Evento DATE,
   hora_Evento_Inicio timestamp(1),
   -- Topico da palestra a ser realizada
    topico varchar(50),
    -- Numero identificador do autor que ira apresentar a palestra
    BI number(9,0),
    primary key (data_Evento, hora_Evento_Inicio),
    foreign key (data_Evento, hora_Evento_Inicio) references Eventos(data_Evento, hora_Evento_Inicio),
    foreign key (BI) references Autores(BI)
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
    alter table Filmes add constraint CHK_FILM check(duracao > 0);
  
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
    
    alter table Encomendados add constraint valid_quantity check (quantidade > 0);
	
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
    
create table lidos(
    ID_Livro number(5,0),
    BI number(9,0),
    primary key (ID_Livro, BI),
    foreign key (ID_Livro) references Livros(ID_Livro),
    foreign key (BI) references Membros(BI)
    );
-- Função que retorna numero de reservas ativas de uma pessoa dado o seu BI
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
    
-- Função que retorna o numero de postos de trabalho de um empregado dado o seu BI
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

-- Um usuario so pode entrar num evento se a capacidade não exceder o seu limite.

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

-- Os dois triggers em baixo de seguida servem para certificar que um filme nao seja uma palestra e vice versa
create or replace trigger check_film
    before insert on filmes
    for each row
    declare nmr integer;
    begin 
        with eventosDup as (select data_Evento as dataP, hora_Evento_Inicio as horaP
        from Palestras
        where data_Evento = :NEW.data_Evento and hora_Evento_Inicio = :NEW.hora_Evento_Inicio)
        select count(dataP) into nmr
        from eventosDup;
        if (nmr > 0) 
        then RAISE_APPLICATION_ERROR(-20003, 'Filme nao pode ser simultaneamente uma Palestra');
        end if;
    end;
/

create or replace trigger check_palestra
    before insert on palestras
    for each row
    declare nmr integer;
    begin
        with eventosDup as (select data_Evento as dataP, hora_Evento_Inicio as horaP
        from Filmes
        where data_Evento = :NEW.data_Evento and hora_Evento_Inicio = :NEW.hora_Evento_Inicio)
        select count(dataP) into nmr
        from eventosDup;
        if (nmr > 0) 
        then RAISE_APPLICATION_ERROR(-20003, 'Palestra nao pode ser simultaneamente uma Filme');
        end if;
    end;
/

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

-- Uma reserva dum livro nao pode ser realizada se nao houver copias suficientes para efetuar a reserva
drop view reservas_ativas_por_Livro cascade constraints;

create or replace view reservas_ativas_por_Livro as
    select count(*) as num_reservas, ID_Livro 
    from Reservas
    where entregue = 0
    group by ID_Livro;
    
select sum(num_reservas) from reservas_ativas_por_Livro where ID_Livro = 11;
select num_copias from Livros where ID_Livro = 11;
    
create or replace trigger enough_copies_to_reserve
    before insert on Reservas
    for each row
    declare num_res number;
    copias number;
    begin
        select sum(num_reservas) into num_res
            from reservas_ativas_por_Livro
            where ID_Livro = :NEW.ID_Livro;
        select num_copias into copias
            from Livros
            where ID_Livro = :NEW.ID_Livro;
        if (num_res = copias)
            then raise_application_error(-20002, 'Nao ha copias suficientes para reserva');
        end if;
    end;
/
-- Fazer uma encomenda
--TODO: SQL Error
--drop trigger fazer_encomenda;
/*create or replace trigger fazer_encomenda
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
*/

create or replace trigger over_capacity 
    before insert on assistiu
    for each row
    begin  
        if (lotacao_evento(:NEW.Data_Evento, :NEW.Hora_Evento_Inicio) = capacidade_do_evento(:NEW.Data_Evento, :NEW.Hora_Evento_Inicio))
        then RAISE_APPLICATION_ERROR(-20002, 'Capacidade atingida no evento');
        end if;
    end;
/

create or replace trigger increase_capacity
    after insert on encomendados
    for each row
    begin
        update Livros set num_copias = num_copias + :NEW.quantidade where Livros.ID_Livro = :NEW.ID_Livro;
    end;
    /

-- Insercoes
drop sequence num_BI_Pessoas;
create sequence num_BI_Pessoas
start with 1
increment by 1;
    
delete from Pessoas;
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('2000-01-22', 'YYYY-MM-DD'), 'Bruno Cabrita'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1999-06-30', 'YYYY-MM-DD'), 'Alberto Pedro'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1999-07-21', 'YYYY-MM-DD'), 'Laura Carla'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1999-11-03', 'YYYY-MM-DD'), 'Catarina Pedro'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1999-05-13', 'YYYY-MM-DD'), 'Clara Sousa'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1999-03-25', 'YYYY-MM-DD'), 'Bruno Braga'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1998-05-13', 'YYYY-MM-DD'), 'Alexandre Godinho'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1888-06-13', 'YYYY-MM-DD'), 'Fernando Pessoa'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1845-11-25', 'YYYY-MM-DD'), 'Eca de Queiros');
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1922-11-16', 'YYYY-MM-DD'), 'Jose Saramago'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1919-11-06', 'YYYY-MM-DD'), 'Sophia de Mello Breyner'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('2000-11-23', 'YYYY-MM-DD'), 'Joao Vieira'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1990-11-24', 'YYYY-MM-DD'), 'Ana Luisa Amaral'); 
insert into Pessoas values (num_BI_Pessoas.nextval, TO_DATE('1980-12-14', 'YYYY-MM-DD'), 'Nellie Bly'); 


drop sequence num_ID_Livros;
create sequence num_ID_Livros
start with 10
increment by 1;

delete from Livros;
insert into Livros values (num_ID_Livros.nextval, 'Mensagem', 'Antonio Ferro', '1934', 20);
insert Into Livros values (num_ID_Livros.nextval, 'Mensagem', 'Porto Editora', '2007', 10);
insert into Livros values (num_ID_Livros.nextval, 'O Ano da Morte de Ricardo Reis', 'Porto Editora', '2021', 30); 
insert into Livros values (num_ID_Livros.nextval, 'Os Maias', 'Porto Editora', '2006', 20);
insert into Livros values (num_ID_Livros.nextval, 'Auto da Barca do Inferno', 'A Bela e o Monstro', '2000', 25);
insert into Livros values (num_ID_Livros.nextval, 'Memorial do Convento', 'Porto Editora', '2021', 30);
insert into Livros values (num_ID_Livros.nextval, 'Dez Dias no Manicomio', 'Ima Editorial', '2020', 20);
insert into Livros values (num_ID_Livros.nextval, 'Agora', 'Assirio E Alvim', '2020', 10);


drop sequence num_ID_Trabalhos;
create sequence num_ID_Trabalhos
start with 24
increment by 2;

delete from Postos_De_Trabalho;
insert into Postos_De_Trabalho values (num_ID_Trabalhos.nextval, 'Atendimento ao Publico em Balcao');
insert into Postos_De_Trabalho values (num_ID_Trabalhos.nextval, 'Organizacao de Livros');
insert into Postos_De_Trabalho values (num_ID_Trabalhos.nextval, 'Gestao de Financas');
insert into Postos_De_Trabalho values (num_ID_Trabalhos.nextval, 'Vigilancia');


drop sequence num_ID_Empregados;
create sequence num_ID_Empregados
start with 100
increment by 1;

delete from Empregados;
insert into Empregados values (1, 300, num_ID_Empregados.nextval);
insert into Empregados values (2, 600, num_ID_Empregados.nextval);


drop sequence num_ID_Autores;
create sequence num_ID_Autores
start with 200
increment by 1;

delete from Autores;
insert into Autores values(4, num_ID_Autores.nextval, 'Ricardo Reis');
insert into Autores values(5, num_ID_Autores.nextval, 'Eca de Queiros');
insert into Autores values(6, num_ID_Autores.nextval, 'Jose Saramago');
insert into Autores values(7, num_ID_Autores.nextval, 'Sophia Breyner');
insert into Autores values(13, num_ID_Autores.nextval, 'N.B');
insert into Autores values(12, num_ID_Autores.nextval, 'A.L.A');


delete from Eventos;
insert into Eventos values(TO_DATE('2000-5-28', 'YYYY-MM-DD'), TO_TIMESTAMP('5-28-2000 10:00','MM-DD-YYYY HH24:MI') , TO_TIMESTAMP('5-28-2001 12:00','MM-DD-YYYY HH24:MI'), 50);
insert into Eventos values(TO_DATE('2001-4-22', 'YYYY-MM-DD'), TO_TIMESTAMP('4-22-2001 9:00','MM-DD-YYYY HH24:MI'), TO_TIMESTAMP('4-22-2001 11:00','MM-DD-YYYY HH24:MI'), 100);
insert into Eventos values(TO_DATE('2020-12-30', 'YYYY-MM-DD'), TO_TIMESTAMP('12-30-2020 15:00','MM-DD-YYYY HH24:MI'), TO_TIMESTAMP('12-30-2020 16:00','MM-DD-YYYY HH24:MI'), 75);
insert into Eventos values(TO_DATE('2021-03-22', 'YYYY-MM-DD'), TO_TIMESTAMP('03-22-2021 15:00','MM-DD-YYYY HH24:MI'), TO_TIMESTAMP('03-22-2021 17:00','MM-DD-YYYY HH24:MI'), 50);
 

delete from Palestras;
insert into Palestras values(TO_DATE('2000-5-28', 'YYYY-MM-DD'), TO_TIMESTAMP('5-28-2000 10:00','MM-DD-YYYY HH24:MI'), 'Romance no Ar', 7);
insert into Palestras values(TO_DATE('2021-03-22', 'YYYY-MM-DD'), TO_TIMESTAMP('03-22-2021 15:00','MM-DD-YYYY HH24:MI'), 'Diferentes imaginacoes do Mundo', 12);
insert into Palestras values(TO_DATE('2001-4-22', 'YYYY-MM-DD'), TO_TIMESTAMP('4-22-2001 9:00','MM-DD-YYYY HH24:MI'), 'Individuo vs Sociedade', 6);


delete from Filmes;
insert into Filmes values(TO_DATE('2020-12-30', 'YYYY-MM-DD'), TO_TIMESTAMP('12-30-2020 15:00','MM-DD-YYYY HH24:MI'), 'Os Misterios de Lisboa', 130);


drop sequence num_ID_Usuarios;
create sequence num_ID_Usuarios
start with 250
increment by 2;

delete from Usuarios;
insert into Usuarios values(3,TO_DATE('2021-05-22', 'YYYY-MM-DD'), num_ID_Usuarios.nextval);
insert into Usuarios values(4,TO_DATE('2021-05-24', 'YYYY-MM-DD'), num_ID_Usuarios.nextval);
insert into Usuarios values(6,TO_DATE('2021-03-22', 'YYYY-MM-DD'), num_ID_Usuarios.nextval);
insert into Usuarios values(8,TO_DATE('2021-06-23', 'YYYY-MM-DD'), num_ID_Usuarios.nextval);


drop sequence num_ID_Cartao;
create sequence num_ID_Cartao
start with 321
increment by 2;

delete from Membros;
insert into Membros values(3, num_ID_Cartao.nextval);
insert into Membros values(4, num_ID_Cartao.nextval);
insert into Membros values(6, num_ID_Cartao.nextval);
insert into Membros values(11, num_ID_Cartao.nextval);


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


drop sequence num_ID_Encomendas;
create sequence num_ID_Encomendas
start with 300
increment by 1;

delete from Encomendas;
insert into Encomendas values(num_ID_Encomendas.nextval);
insert into Encomendas values(num_ID_Encomendas.nextval);
insert into Encomendas values(num_ID_Encomendas.nextval);
insert into Encomendas values(num_ID_Encomendas.nextval);
insert into Encomendas values(num_ID_Encomendas.nextval);


drop sequence num_ID_Reserva;
create sequence num_ID_Reserva
start with 1
increment by 2;

delete from Reservas;
insert into Reservas values(num_ID_Reserva.nextval, TO_DATE('2000-10-21', 'YYYY-MM-DD'), TO_DATE('2000-11-21', 'YYYY-MM-DD'),11, 11, 0);
insert into Reservas values(num_ID_Reserva.nextval, TO_DATE('2020-10-21', 'YYYY-MM-DD'), TO_DATE('2020-11-21', 'YYYY-MM-DD'),11, 3, 0);
insert into Reservas values(num_ID_Reserva.nextval, TO_DATE('2020-10-24', 'YYYY-MM-DD'), TO_DATE('2020-11-22', 'YYYY-MM-DD'),13, 3, 1);
insert into Reservas values(num_ID_Reserva.nextval, TO_DATE('2020-10-24', 'YYYY-MM-DD'), TO_DATE('2020-11-22', 'YYYY-MM-DD'),15, 3, 0);
insert into Reservas values(num_ID_Reserva.nextval, TO_DATE('2020-10-01', 'YYYY-MM-DD'), TO_DATE('2020-11-25', 'YYYY-MM-DD'),15, 11, 1);
insert into Reservas values(num_ID_Reserva.nextval, TO_DATE('2020-10-24', 'YYYY-MM-DD'), TO_DATE('2020-11-24', 'YYYY-MM-DD'),13, 11, 1);
insert into Reservas values(num_ID_Reserva.nextval, TO_DATE('2020-10-30', 'YYYY-MM-DD'), TO_DATE('2020-11-25', 'YYYY-MM-DD'),13, 3, 1);
insert into Reservas values(num_ID_Reserva.nextval, TO_DATE('2000-11-21', 'YYYY-MM-DD'), TO_DATE('2000-12-20', 'YYYY-MM-DD'),11, 3, 0);
insert into Reservas values(num_ID_Reserva.nextval, TO_DATE('2000-11-21', 'YYYY-MM-DD'), TO_DATE('2000-12-20', 'YYYY-MM-DD'),11, 11, 0);



delete from Encomendados;
insert into Encomendados values(300, 11, 10);
insert into Encomendados values(301, 13, 25);
insert into Encomendados values(301, 15, 35);
insert into Encomendados values(301, 11, 5);
insert into Encomendados values(302, 17, 25);
insert into Encomendados values(302, 14, 25);


delete from Escritos_Por;
insert into Escritos_Por values(10, 4);
insert into Escritos_Por values(13, 5);
insert into Escritos_Por values(15, 6);
insert into Escritos_Por values(10, 5);
insert into Escritos_Por values(10, 6);


delete from de;
insert into de values(911, 11);
insert into de values(912, 13);


delete from Trabalha_Em;
insert into Trabalha_Em values(24,1);
insert into Trabalha_Em values(26,1);
insert into Trabalha_Em values(30,2);


delete from assistiu;
insert into assistiu values(TO_DATE('2000-5-28', 'YYYY-MM-DD'), TO_TIMESTAMP('5-28-2000 10:00','MM-DD-YYYY HH24:MI'),1);
insert into assistiu values(TO_DATE('2000-5-28', 'YYYY-MM-DD'), TO_TIMESTAMP('5-28-2000 10:00','MM-DD-YYYY HH24:MI'),2);
insert into assistiu values(TO_DATE('2020-12-30', 'YYYY-MM-DD'), TO_TIMESTAMP('12-30-2020 15:00','MM-DD-YYYY HH24:MI'),3);


delete from Baseados_Em;
insert into Baseados_Em values(TO_DATE('2020-12-30', 'YYYY-MM-DD'), TO_TIMESTAMP('12-30-2020 15:00','MM-DD-YYYY HH24:MI'),10);
insert into Baseados_Em values(TO_DATE('2020-12-30', 'YYYY-MM-DD'), TO_TIMESTAMP('12-30-2020 15:00','MM-DD-YYYY HH24:MI'),11);

delete from lidos;
insert into lidos values(11, 3);
insert into lidos values(11, 4);
insert into lidos values(13, 6);
insert into lidos values(11, 6);
insert into lidos values(12, 4);
insert into lidos values(12, 3);


-- Funções 


-- Queries interessantes

-- Procurar as datas e horas de palestras dadas por autores que escreveu um dado livro.
select TO_CHAR(Data_Evento, 'MM-DD-YYYY') as Dias, TO_CHAR(Hora_Evento_Inicio, 'HH24:MI') as Horas
from Palestras inner join Autores using (BI)
    inner join Escritos_por using (BI)
    inner join Livros using (ID_Livro)
where Titulo like '%Memorial%';



-- Nomes e BI’s de empregados que tenham recebido encomendas de livros escritos por um dado autor.


/*select nome_Pessoa as nome_Empregado, Empregados.BI as BI_Empregados
from recebidos_por inner join encomendados using (ID_Encomenda)
    inner join Escritos_por using (ID_Livro)
    inner join Pessoas using (BI)
where Escritos_por.ID_Autor = 11;*/


-- Nomes das pessoas que foram assistir a um filme baseado num livro de um dado tema.

select nome_Pessoa
from Pessoas inner join assistiu using (BI)
		inner join Eventos using (data_Evento, hora_Evento_Inicio)
		inner join Filmes using (data_Evento, hora_Evento_Inicio)
		inner join baseados_Em using (data_Evento, hora_Evento_Inicio)
		inner join Livros using (ID_Livro)
		inner join de using (ID_Livro)
        inner join Temas using (ID_Tema)
where nome_Tema like '%Romance%';

-- Título dos livros reservados pelo menos uma vez por um dado membro.

select Titulo
from Reservas inner join Livros using (ID_Livro)
where BI = 3;

-- Tópicos apresentados por um dado autor.

select topico
from Palestras inner join Autores using (BI)
where BI = 6;

-- Os autores que nao apresentaram nenhuma palestra na biblioteca

select nome_Pessoa
    from Autores inner join Pessoas using (BI)
minus
 select nome_Pessoa
    from Autores inner join Pessoas using (BI)
        inner join Palestras using (BI)
    order by nome_Pessoa;


-- O numero de livros presentes na biblioteca que foram reservados pelo menos três vezes

select Titulo, count(ID_Livro) as num_reservas
from Livros inner join Reservas using (ID_Livro)
group by Titulo
having count(ID_Livro) > 2;
        
--alter table assistiu add constraint chk_over_capacity check ((lotacao_evento(data_Evento, hora_Evento_Inicio)) <= (capacidade_do_evento(data_Evento, hora_Evento_Inicio)));

select * from Pessoas;
select * from Livros;
select * from Postos_De_Trabalho;
select * from Empregados;
select * from Autores;
select * from Eventos; 
select * from Palestras;
select * from Filmes;
select * from Usuarios;
select * from Membros;
select * from Temas;
select * from Encomendas;
select * from Reservas;
select * from Encomendados;
select * from Trabalha_Em;
select * from Escritos_Por;
select * from de;
select * from assistiu;
select * from Baseados_Em;