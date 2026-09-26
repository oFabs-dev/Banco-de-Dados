USE sprint1;

CREATE TABLE musica(
idMusica INT PRIMARY KEY,
titulo VARCHAR (40),
artista VARCHAR(40),
genero VARCHAR(40)
);

 INSERT INTO musica VALUES
	(01, 'Joao e Maria', 'Chico Buarque', 'MBP'),
    (02, 'Valsinha', 'Chico Buarque', 'MBP'),
    (03, 'Many Men', '50 Cent', 'RAP'),
    (04, 'Toxicity', 'System Of A Down', 'ROCK'),
    (05, 'Brain Stew', 'Green Day', 'ROCK'),
    (06, 'Gunslinger', 'Avenged Sevenfold', 'ROCK'),
    (07, 'Acid Rain', 'Avenged Sevenfold', 'ROCK');
    
    

-- a) Exibir todos os dados da tabela.
SELECT * FROM musica;

-- b) Adicionar o campo curtidas do tipo int na tabela;
ALTER TABLE musica ADD COLUMN curtidas INT;

-- c) Atualizar o campo curtidas de todas as músicas inseridas;
UPDATE musica SET curtidas = 2
	WHERE idMusica IN (1,2,3,4,5,6,7);

-- d) Modificar o campo artista do tamanho 40 para o tamanho 80;
ALTER TABLE musica MODIFY COLUMN artista VARCHAR (80);

-- e) Atualizar a quantidade de curtidas da música com id=1;
UPDATE musica SET curtidas = 4
	WHERE idMusica = 1;
    
-- f) Atualizar a quantidade de curtidas das músicas com id=2 e com o id=3;
UPDATE musica SET curtidas = 5
	WHERE idMusica IN (1,2);
    
-- g) Atualizar o nome da música com o id=5;
UPDATE musica SET titulo = 'Monster'
	WHERE idMusica = 5;
-- h) Excluir a música com o id=4;

DELETE FROM musica WHERE idMusica = 4;

-- i) Exibir as músicas onde o gênero é diferente de funk;
SELECT * FROM musica
	WHERE genero <> 'ROCK';
    
-- j) Exibir os dados das músicas que tem curtidas maior ou igual a 20;
SELECT * FROM musica
	WHERE curtidas >= 20;
    
-- k) Descrever os campos da tabela mostrando a atualização do campo artista;
DESCRIBE musica artista;

-- l) Limpar os dados da tabela;
TRUNCATE TABLE musica;