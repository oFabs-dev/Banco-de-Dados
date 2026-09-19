/*Exercício 1.
No MySQL Workbench:
Crie um banco de dados chamado Sprint2;
Use o banco de dados Sprint2;
Escreva e execute os comandos para:
• Criar a tabela chamada Atleta para conter os dados: idAtleta (int e chave
primária da tabela), nome (varchar, tamanho 40), modalidade (varchar, tamanho
40), qtdMedalha (int, representando a quantidade de medalhas que o atleta
possui)
• Inserir dados na tabela, procurando colocar mais de um atleta para cada
modalidade e pelo menos 5 atletas.
• Criar uma tabela chamada País para conter os dados: idPais (int e chave primária
da tabela), nome (varchar, tamanho 30), capital (varchar, tamanho 40);
• Inserir pelo menos 4 países na tabela país.
Fazer a modelagem lógica conforme a regra de negócio:
• 1 país tem 1 ou muitos atletas;
• 1 atleta é de 1 e somente 1 país;
Escreva e execute os comandos para:
• Criar a chave estrangeira na tabela correspondente conforme modelagem;
• Atualizar o país de todos os atletas;
• Exibir os atletas e seu respectivo país;
• Exibir apenas o nome do atleta e o nome do respectivo país;
• Exibir os dados dos atletas, seus respectivos países, de uma determinada capital;*/

USE sprint2;

CREATE TABLE Atleta(
idAtleta INT PRIMARY KEY auto_increment,
nome VARCHAR(40),
modalidade VARCHAR(40),
medalha int,
fkPais int,
constraint fkPaisAtleta
	foreign key (fkPais)
     references Pais(idPais)

);


insert into Atleta values
(default,'Jorge', 'Futebol', 3,1),
(default,'Jorginho', 'Volei', 6,2),
(default,'Ana', 'Golf', 2,3),
(default,'Aninha', 'Natação', 1,4),
(default,'Paulo', 'Futebol', 4,5);

CREATE TABLE Pais(
idPais INT PRIMARY KEY auto_increment,
nome VARCHAR(30),
capital VARCHAR(40)
);

insert into Pais values
(default,'Brasil', 'Brasilia'),
(default,'Portugal', 'Berlim'),
(default,'Estados Unidos', 'San Andreas'),
(default,'Canada', 'Vancouver');

UPDATE Atleta SET fkPais = 1 WHERE idAtleta = 1;
UPDATE Atleta SET fkPais = 1 WHERE idAtleta = 2;
UPDATE Atleta SET fkPais = 2 WHERE idAtleta = 3;
UPDATE Atleta SET fkPais = 3 WHERE idAtleta = 4;
UPDATE Atleta SET fkPais = 4 WHERE idAtleta = 5;

SELECT * FROM Atleta
	JOIN Pais ON fkPais = idPais;

SELECT Pais.nome, atleta.nome FROM Atleta
	JOIN Pais ON fkPais = idPais;
    
SELECT Pais.nome,capital , atleta.* FROM Atleta
	JOIN Pais ON fkPais = idPais
		WHERE capital = 'Brasilia';
        
        
        
/* No MySQL Workbench, utilizando o banco de dados ‘sprint2’:
• Criar a tabela chamada Musica para conter os dados: idMusica, titulo (tamanho
40), artista (tamanho 40), genero (tamanho 40), sendo que idMusica é a chave
primária da tabela.
• Inserir dados na tabela, procurando colocar um gênero de música que tenha mais
de uma música, e um artista, que tenha mais de uma música cadastrada. Procure
inserir pelo menos umas 3 músicas.
• Criar a tabela chamada Album para conter os dados: idAlbum, nome, tipo (digital
ou físico) e dtLancamento (DATE).
• Inserir pelo menos 2 albuns;
• Fazer a modelagem lógica conforme a regra de negócio:
• 1 album pode ter 1 ou muitas músicas;
• 1 música é de 1 e somente 1 album;
Execute os comandos para:
a) Exibir todos os dados das tabelas separadamente;
b) Criar a chave estrangeira na tabela de acordo com a regra de negócio;
c) Atualizar os álbuns de cada música;
d) Exibir as músicas e seus respectivos álbuns;
e) Exibir somente o título da música e o nome do seu respectivo álbum;
f) Exibir os dados das músicas e seu respectivo álbum, de um determinado tipo.*/

CREATE TABLE musica(
idMusica INT primary key auto_increment,
titulo varchar(40),
artista varchar(40),
genero varchar(40),
fkAlbum INT,
constraint fkMusicaAlbum 
	foreign key (fkAlbum)
		references album(idAlbum)
);

insert into musica value
(default,'Gunslinger','Avengend SevenFold','Rock', 1),
(default,'Nightmare','Avengend SevenFold','Rock',2),
(default,'Valsinha','Chico Buarque','MBP',3);


CREATE TABLE album(
idAlbum INT primary key auto_increment,
nome varchar(40),
tipo varchar(40),
dtLancamento DATE
);

insert into album values
(default,'AlbumLegal','Rock','2020-05-21'),
(default,'AlbumBacana','MBP','2022-05-21');

SElECT * FROM musica;
SELECT * FROM album;


update musica set fkAlbum = 1 WHERE idMusica = 1;
update musica set fkAlbum = 1 WHERE idMusica = 2;
update musica set fkAlbum = 2 WHERE idMusica = 3;

SELECT * FROM musica
	join Album on fkAlbum = idAlbum;
    
SELECT musica.titulo, album.nome FROM musica
	join Album on fkAlbum = idAlbum;
    
SELECT musica.*, album.nome FROM musica
	join Album on fkAlbum = idAlbum
    WHERE genero = 'Rock';
    
/*Exercício 3:


- Criar as tabelas;

- Inserir 5 registros

- Configurar chave estrangeira

- Exibir dados;

- Exibir dados com AS;

- Exibir dados com CASE;

- Exibir dados com IFNULL; */

CREATE TABLE pessoa(
idPessoa INT primary key auto_increment,
nome VARCHAR(45),
cpf CHAR(11)
);

INSERT INTO pessoa VALUES
(DEFAULT, 'Jota', '12345678901'),
(DEFAULT, 'Mariana', null),
(DEFAULT, 'Carlos', '34567890123'),
(DEFAULT, 'Ana', null),
(DEFAULT, 'Pedro', '56789012345');

CREATE TABLE reserva(
idReserva int primary key auto_increment,
dtReserva DATETIME,
dtRetirada DATETIME,
dtDevolucao DATETIME,
fkPessoa INT,
constraint fkPessoaReserva 	
	foreign key (fkPessoa)
		references Pessoa(idPessoa)
);

INSERT INTO reserva VALUES
(DEFAULT, '2026-09-01 10:00:00', '2026-09-02 09:00:00', '2026-09-05 18:00:00', 1),
(DEFAULT, '2026-09-05 14:30:00', '2026-09-04 10:00:00', '2026-09-06 12:00:00', 2),
(DEFAULT, '2026-09-05 08:15:00', '2026-09-06 09:00:00', '2026-09-08 17:00:00', 3),
(DEFAULT, '2026-09-07 11:45:00', '2026-09-08 10:30:00', '2026-09-10 15:00:00', 4),
(DEFAULT, '2026-09-09 16:00:00', '2026-09-10 09:00:00', '2026-09-12 20:00:00', 5);

SELECT * FROM reserva
	JOIN pessoa ON idPessoa = fkPessoa;
    
SELECT pessoa.nome AS Nome_da_pessoa, reserva.dtReserva AS Data_Reserva FROM reserva
	JOIN pessoa ON idPessoa = fkPessoa;
    
SELECT pessoa.nome AS Nome_da_pessoa, reserva.dtReserva AS Data_Reserva,
case
when dtReserva > '2026-09-05 00:00:00' and dtReserva < '2026-09-05 23:59:59' then 'Preço promoção'
else 'Preço normal'
end as Valores
 FROM reserva
	JOIN pessoa ON idPessoa = fkPessoa;
    

    
   SELECT pessoa.nome AS Nome_da_pessoa, IFNULL(pessoa.cpf,'Não informado') AS CPF , reserva.dtReserva AS Data_Reserva FROM reserva
	JOIN pessoa ON idPessoa = fkPessoa; 
    
    
/*Exercício 4:


- Criar as tabelas;

- Inserir 5 registros

- Configurar chave estrangeira

- Exibir dados;

- Exibir dados com AS;

- Exibir dados com CASE;

- Exibir dados com IFNULL;*/

CREATE TABLE pessoa1(
idPessoa1 int primary key auto_increment,
nome VARCHAR(45),
dtNascimento DATE
);

INSERT INTO pessoa1 VALUES
(DEFAULT, 'Ana', '1990-05-12'),
(DEFAULT, 'Bruno', null),
(DEFAULT, 'Carla', '1998-02-20'),
(DEFAULT, 'Diego', null),
(DEFAULT, 'Elisa', '1992-09-08');

CREATE TABLE pessoa2(
idPessoa2 int primary key auto_increment,
nome VARCHAR(45),
dtNascimento DATE
);

INSERT INTO pessoa2 VALUES
(DEFAULT, 'Fábio', '1988-03-22'),
(DEFAULT, 'Gabriela', null),
(DEFAULT, 'Hugo', null),
(DEFAULT, 'Isabela', '1999-04-10'),
(DEFAULT, 'João', '1987-08-25');


ALTER TABLE pessoa2 ADD COLUMN fkPessoa1 INT UNIQUE;

ALTER TABLE pessoa2 ADD constraint fkPessoa1_2 foreign key (fkPessoa1) REFERENCES pessoa1(idPessoa1);

UPDATE pessoa2 SET fkPessoa1 = 1 WHERE idPessoa2 = 1;
UPDATE pessoa2 SET fkPessoa1 = 2 WHERE idPessoa2 = 2;
UPDATE pessoa2 SET fkPessoa1 = 3 WHERE idPessoa2 = 3;
UPDATE pessoa2 SET fkPessoa1 = 4 WHERE idPessoa2 = 4;
UPDATE pessoa2 SET fkPessoa1 = 5 WHERE idPessoa2 = 5;


Select * from pessoa2
	join pessoa1 on fkPessoa1 = idPessoa1;
    
Select pessoa1.nome AS Grupo1, pessoa1.dtNascimento AS Data_de_Nascimento, pessoa2.nome AS Grupo2, pessoa2.dtNascimento AS Data_de_Nascimento  from pessoa2
	join pessoa1 on fkPessoa1 = idPessoa1;
    
    
    
Select pessoa1.nome AS Grupo1, pessoa1.dtNascimento AS Data_de_Nascimento, pessoa2.nome AS Grupo2, pessoa2.dtNascimento AS Data_de_Nascimento,
case
when pessoa1.dtNascimento or pessoa2.dtNascimento < '1990-01-01' then 'ESTA FICANDO VELHO'
else 'AINDA ESTA NOVO'
end as statuss
 from pessoa2
	join pessoa1 on fkPessoa1 = idPessoa1; 
    

    
Select pessoa1.nome AS Grupo1, ifnull(pessoa1.dtNascimento,'Não informado') AS Data_de_Nascimento, pessoa2.nome AS Grupo2, ifnull(pessoa2.dtNascimento,'Não informado') AS Data_de_Nascimento  from pessoa2
	join pessoa1 on fkPessoa1 = idPessoa1;
    
    
/*Exercício 5:



Referente a regra de negócio acima, cria a modelagem utilizando um relacionamento 1:1, implemente com o script realizando os seguintes comandos:

- Criar as tabelas;

- Inserir 5 registros

- Configurar chave estrangeira

- Exibir dados;

- Exibir dados com AS;

- Exibir dados com CASE;

- Exibir dados com IFNULL;*/

CREATE TABLE pessoas(
idPessoa INT primary key auto_increment,
nome VARCHAR (30),
idade INT
);

INSERT INTO pessoas VALUES
(default,'Joca', 18),
(default,'Marcio', 19),
(default,'Carlos', 25),
(default,'Antonio', 22),
(default,'Fernadinho', 21);

CREATE TABLE CNH(
idCNH INT primary key auto_increment,
CPF CHAR (11),
categoria VARCHAR(5),
validade DATE
);

INSERT INTO CNH VALUES
(default,'123.456.789-00', 'B', '2026-09-21'),
(default, null, 'AB','2027-01-14'),
(default,'456.789.123-00', 'A', '2026-09-30'),
(default, null, 'AB', '2026-12-04'),
(default,'789.123.456-00', 'B', '2027-02-03');

ALTER TABLE pessoas ADD COLUMN fkCNH INT UNIQUE;

ALTER TABLE pessoas ADD constraint fkPessoaCNH foreign key (fkCNH) REFERENCES CNH(idCNH);

UPDATE pessoas set fkCNH = 1 WHERE idpessoa = 1;
UPDATE pessoas set fkCNH = 2 WHERE idpessoa = 2;
UPDATE pessoas set fkCNH = 3 WHERE idpessoa = 3;
UPDATE pessoas set fkCNH = 4 WHERE idpessoa = 4;
UPDATE pessoas set fkCNH = 5 WHERE idpessoa = 5;

select * from pessoas 
join CNH on fkCNH = idCNH;

select pessoas.nome as Nome_da_pessoa, CNH.categoria as Categoria_Habilitação from pessoas 
join CNH on fkCNH = idCNH;

select pessoas.nome as Nome_da_pessoa, CNH.categoria as Categoria_Habilitação,
case
when categoria = 'A' then 'Moto'
when categoria = 'B' then 'Carro'
else 'Carro e moto'
end as tipo
 from pessoas
join CNH on fkCNH = idCNH;

select pessoas.nome as Nome_da_pessoa, CNH.categoria as Categoria_Habilitação, ifnull(CNH.CPF,'Não informado') AS CPF from pessoas 
join CNH on fkCNH = idCNH;


/*Exercício 6:
Regra de negócio: 

1 Farmácia tem no mínimo 1 e no máximo 1 endereço, 1 endereço é de no mínimo 1 farmácia e no máximo 1.

1 Farmácia tem no mínimo 1 farmacêutico e no máximo n, 1 farmacêutico é de no mínimo 1 farmácia e no máximo 1.

- Criar a modelagem lógica na regra acima, com os campos de sua escolha.

- Criar as tabelas;

- Inserir 5 registros;

- Configurar chave estrangeira;

- Exibir dados;

- Exibir dados com AS;

- Exibir dados com CASE;

- Exibir dados com IFNULL;*/


CREATE TABLE farmacia(
idFarmacia int primary key auto_increment,
nome VARCHAR(30),
cnpj CHAR(14) UNIQUE,
fkEndereco INT UNIQUE,
CONSTRAINT fkEnderenco_farma
 foreign key (fkEndereco) REFERENCES endereco(idEndereco)

);


CREATE TABLE endereco(
idEndereco int primary key auto_increment,
pais VARCHAR (30),
estado VARCHAR (30),
rua VARCHAR (30),
numero VARCHAR(10)

);

CREATE TABLE farmaceutico(
idFarmaceutico int primary key auto_increment,
nome VARCHAR (30),
cpf char(11) unique,
 fkFarma INT,
CONSTRAINT fkFarmaceutico_farma
 foreign key (fkFarma) REFERENCES farmacia(idFarmacia)
);


INSERT INTO endereco VALUES
(DEFAULT, 'Brasil', 'São Paulo', 'Av. Paulista',   '1000'),
(DEFAULT, 'Brasil', 'Paraná', 'Rua das Flores', '250'),
(DEFAULT, 'Brasil', 'Rio de Janeiro',  'Av. Atlântica',  '500'),
(DEFAULT, 'Brasil', 'Minas Gerais', 'Rua da Bahia',   '120'),
(DEFAULT, 'Brasil', 'Ceará',  'Av. Beira Mar',  '80');
 
INSERT INTO farmacia VALUES
(DEFAULT, 'Farma Vida Paulista', '11849311000111', 1),
(DEFAULT, 'Farma Curitiba', '111739281000222', 2 ),
(DEFAULT, 'Farma Copacabana', '117338111000333', 3),
(DEFAULT, 'Farma Savassi', '11193711000444', 4),
(DEFAULT, 'Farma Meireles', '18361111000555', 5);
 
INSERT INTO farmaceutico VALUES
(DEFAULT, 'Ellen','12892233301',1),
(DEFAULT, 'Bruno', null ,1),
(DEFAULT, 'Carla','11748333303',2),
(DEFAULT, 'Diego', null,3),
(DEFAULT, 'Elisa','12692233305',4);


select * from farmacia 
JOIN endereco ON idEndereco = fkEndereco;

select * from farmaceutico 
JOIN farmacia ON idFarmacia = fkFarma;


select farmaceutico.nome AS Colaborador, farmacia.nome AS Loja from farmaceutico 
JOIN farmacia ON idFarmacia = fkFarma;

select farmaceutico.nome AS Colaborador, farmacia.nome AS Loja from farmaceutico 
JOIN farmacia ON idFarmacia = fkFarma;

select farmaceutico.nome AS Colaborador, farmacia.nome AS Loja,
case
when farmacia.nome = 'Farma Vida Paulista' then 'Muitas vendas'
when farmacia.nome = 'Farma Savassi' then 'Mais ou menos'
else 'Poucas vendas'
end as VENDAS
 from farmaceutico 
JOIN farmacia ON idFarmacia = fkFarma;


select farmaceutico.nome AS Colaborador, farmacia.nome AS Loja, ifnull(cpf,'sem informação') as CPF from farmaceutico 
JOIN farmacia ON idFarmacia = fkFarma;

/**/
