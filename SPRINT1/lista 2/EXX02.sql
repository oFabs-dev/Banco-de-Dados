
USE sprint1;

CREATE TABLE esporte(
id INT primary key auto_increment,
nome VARCHAR(40),
categoria VARCHAR(20),
constraint chkcategoria check(categoria in('Individual','Coletivo')),
participantes INT,
estreia DATE,
pais VARCHAR(30)
);


-- 1. Insira pelo menos 5 registros na tabela.
INSERT INTO esporte VALUES
	(default,'Box', 'Individual', 1, '1997-04-02', 'Russia'),
    (default,'Futebol', 'Coletivo', 11,'2008-04-02', 'Brasil'),
    (default,'Natação', 'Individual', 1, '2004-04-02', 'Japão'),
    (default,'Capoeira', 'Individual', 1, '2003-04-02', 'Japão'),
    (default,'Volei', 'Coletivo', 6, '1993-04-02', 'Japão');

-- 2. Altere a tabela para adicionar uma coluna popularidade que armazene a popularidade do esporte como um valor decimal entre 0 e 10
-- e exiba como ficou a estrutura da tabela.

ALTER TABLE esporte ADD COLUMN popularidade decimal(3,1) CHECK (popularidade >= 0 AND popularidade <= 10);

-- 3. Atualize os registros para definir a popularidade dos esportes inseridos anteriormente.
UPDATE esporte SET popularidade = 8
	WHERE id IN (1,3,5);
    
UPDATE esporte SET popularidade = 10
	WHERE id IN (2,4);
    
-- 4. Exiba os esportes ordenados por popularidade em ordem crescente.
SELECT * FROM esporte ORDER BY popularidade;

-- 5. Exiba apenas os esportes que estrearam nas Olimpíadas a partir do ano 2000.
SELECT * FROM esporte
	WHERE estreia < '2000-01-01';

-- 6. Crie uma checagem para que não possa ser inserido valores dentro de estreia que seja menor que 06 de abril de 1896 e depois da data atual.
ALTER TABLE esporte ADD CONSTRAINT chKNota CHECK ( estreia > '1896-04-06');

-- 7. Altere a tabela para excluir a regra de inserção de categoria, assim podendo colocar valores além de "Individual" ou "Coletivo".
ALTER TABLE esporte DROP CHECK chkcategoria; 

-- 8. Exiba apenas os esportes cujo nome do país de origem tenha "a" na segunda letra.
SELECT * FROM esporte
	WHERE pais LIKE '_a%';

-- 9. Exiba os dados onde o número de jogadores por equipe esteja entre 4 e 11.
SELECT * FROM esporte
	WHERE (participantes >= 4 AND participantes <= 11);
    
-- 10. Remova os registros onde id seja 1, 3 e 5.
DELETE FROM esporte 
	WHERE id in (1,3,5);


