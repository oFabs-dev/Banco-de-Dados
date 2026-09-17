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

INSERT INTO pessoa1 (idPessoa1, nome, dtNascimento) VALUES
(DEFAULT, 'Ana Silva', '1990-05-12'),
(DEFAULT, 'Bruno Costa', '1985-11-30'),
(DEFAULT, 'Carla Mendes', '1998-02-20'),
(DEFAULT, 'Diego Rocha', '2000-07-15'),
(DEFAULT, 'Elisa Farias', '1992-09-08');

CREATE TABLE pessoa2(
idPessoa2 int primary key auto_increment,
nome VARCHAR(45),
dtNascimento DATE
);

INSERT INTO pessoa2 VALUES
(DEFAULT, 'Fábio Nunes', '1988-03-22'),
(DEFAULT, 'Gabriela Lima', '1995-06-17'),
(DEFAULT, 'Hugo Teixeira', '1993-12-01'),
(DEFAULT, 'Isabela Souza', '1999-04-10'),
(DEFAULT, 'João Pereira', '1987-08-25');





    
    

    








