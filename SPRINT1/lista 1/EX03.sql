USE sprint1;

CREATE TABLE filme(
idFilme INT PRIMARY KEY,
título VARCHAR(50),
diretor VARCHAR(40),
genero VARCHAR(40)

); 

INSERT INTO filme VALUES
	(01, 'Seven', 'David Fincher', 'Suspense'),
    (02, 'Clube da luta', 'David Fincher', 'Drama'),
    (03, 'Matrix', 'Lana Wachowski', 'Ficção Cientifica'),
    (04, 'Parasita', 'Bong Joon-ho', 'Drama'),
    (05, 'Jogos Mortais', 'James Wan', 'Terror'),
    (06, 'WALL-E', 'Adrew Stanton', 'Animação'),
    (07, 'Avatar', 'James Cameron', 'Ficção Científica');
    
    
-- Exibir todos os dados da tabela.
SELECT * FROM filme;

-- Adicionar o campo protagonista do tipo varchar(50) na tabela;
ALTER TABLE filme ADD COLUMN protagonista VARCHAR(50);

-- Atualizar o campo protagonista de todas os filmes inseridos;
UPDATE filme set protagonista = 'pica-pau'
	WHERE idFilme IN (1,2,3,4,5,6,7);
    
-- Modificar o campo diretor do tamanho 40 para o tamanho 150;
ALTER TABLE filme MODIFY COLUMN diretor VARCHAR(150);

-- Atualizar o diretor do filme com id=5;
UPDATE filme set diretor = 'NARUTO'
	WHERE idFilme = 5;
    
-- Atualizar o diretor dos filmes com id=2 e com o id=7;
UPDATE filme SET diretor = 'GOKU'
	WHERE idFilme IN (2,7);

-- Atualizar o título do filme com o id=6;
UPDATE filme SET tÍtulo = 'TURBO'
	WHERE idFilme = 6;
    
-- Excluir o filme com o id=3;
DELETE FROM filme WHERE idFilme = 3;

-- Exibir os filmes em que o gênero é diferente de drama;
SELECT * FROM filme
	WHERE genero <> 'drama';
	
-- Exibir os dados dos filmes que o gênero é igual ‘suspense’;
SELECT * FROM filme
	WHERE genero = 'Suspense';

-- Descrever os campos da tabela mostrando a atualização do campo protagonista e diretor;
DESCRIBE filme;

-- Limpar os dados da tabela;
TRUNCATE TABLE filme;