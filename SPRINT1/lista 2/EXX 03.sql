/*3 – Desenhos Animados
No MySQL Workbench, crie o banco de dados "desenho".
Você foi contratado para criar um banco de dados que armazene informações
detalhadas sobre desenhos animados exibidos na emissora. O objetivo é manter
um catálogo com as seguintes informações.
Para atender a essa necessidade, você propôs a criação de uma tabela com os
seguintes campos: id, um número inteiro chave primária da tabela, este valor
deverá ser autoincrementado a partir do 10. Título, um campo de texto com
tamanho de 50 caracteres que armazenará o título do desenho animado. A data de
lançamento um campo que armazenará a data de lançamento do desenho. O
nome da emissora original, um campo de texto com tamanho de 50 caracteres.
Classificação, um campo que armazenará a classificação indicativa do desenho.
Status, um campo de texto com tamanho de 15 caracteres, que armazenará o
status do desenho. Nota, um campo que armazenará a avaliação do desenho,
permitindo valores de 1 a 5.*/

USE sprint1;

CREATE TABLE desenho(
id INT PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR(50),
lançamento DATE,
emissora VARCHAR(50),
classificacao VARCHAR(50),
statuss VARCHAR(15),
nota INT,
CONSTRAINT notachk CHECK ( nota >= 0 AND NOTA <= 5)
)AUTO_INCREMENT=30;   



INSERT INTO desenho VALUES
  (DEFAULT, 'Bob Esponja', '1999-05-01', 'Nickelodeon', 'Livre', 'exibindo', 5),
  (DEFAULT, 'Naruto', '2002-10-03', 'TV Tokyo', '12 anos', 'finalizado', 5),
  (DEFAULT, 'One Piece', '2002-04-25', 'Toei Animation', 'Livre', 'exibindo', 4),
  (DEFAULT, 'Hora de aventura', '2010-04-26', 'Cartoon Network', '14 anos', 'finalizado', 5),
  (DEFAULT, 'Steven Universe', '2013-11-04', 'Cartoon Network', 'Livre', 'cancelado', 4);


-- 1. Exibir todos os dados da tabela
SELECT * FROM desenho;

-- 2. Exibir todos os desenhos com a classificação menor ou igual a 14 anos
SELECT * FROM desenho 
	WHERE classificacao <= '14 anos';
    
-- 3. Exibir todos os desenhos de uma mesma emissora original
 SELECT * FROM desenho 
	WHERE emissora = 'cartoon network';
    
-- 4. Modificar o campo status, para que aceite apenas o status 'exibindo', 'finalizado', 'cancelado', tente inserir algum outro valor para ver se a regra foi aplicad
ALTER TABLE desenho ADD CONSTRAINT chkStatuss CHECK (statuss in ('exibindo','finalizado','cancelado'));

INSERT INTO desenho value
(DEFAULT, 'Steven Universe', '2013-11-04', 'Cartoon Network', 'Livre', 'PRODUÇÃO', 4);

-- 5. Modificar o status 'exibindo' para 'finalizado' de 2 desenhos pelo ID
UPDATE desenho SET statuss = 'finalizado'
	WHERE id in (1,3);
    
-- 6. Deletar a linha do desenho de ID 12
DELETE FROM desenho
	WHERE id = 12;


-- 7. Exibir apenas os desenhos que comecem com uma determinada letra
SELECT * FROM desenho WHERE titulo LIKE 'h%';

-- 8. Renomear a coluna classificacao para classificacaoIndicativa
ALTER TABLE desenho RENAME COLUMN classificacao to classificacaoIndicativa;

-- 9. Atualizar a nota e data de lançamento do desenho de ID 11
UPDATE desenho SET nota = 5, lançamento = '2011-11-11'
	WHERE id = 11;
    
-- 10. Limpe todos os dados da tabela
TRUNCATE desenho;

-- 11. Remover a regra do status do desenho
ALTER TABLE desenho DROP CHECK chkStatuss;