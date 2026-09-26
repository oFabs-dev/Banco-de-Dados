USE sprint1;

CREATE TABLE professor(
idprofessor INT PRIMARY KEY,
nome VARCHAR(50),
especialidade VARCHAR(40),
dtNasc DATE


);

INSERT INTO professor VALUES
(01, 'Marcos', 'Matematica', '1997-12-21'),
(02, 'Antonio', 'Quimica', '2000-05-11'),
(03, 'Ana', 'Fisica', '1996-08-25'),
(04, 'Milton', 'Biologia', '1999-01-13'),
(05, 'Jonas', 'Ingles', '1980-04-04'),
(06, 'Renata', 'Artes', '2001-09-10');


-- a) Exibir todos os dados da tabela.
SELECT * FROM professor;

-- b) Adicionar o campo funcao do tipo varchar(50), onde a função só pode ser ‘monitor’,‘assistente’ ou ‘titular’;
ALTER TABLE professor ADD COLUMN funcao VARCHAR(50), ADD CONSTRAINT teste CHECK(funcao IN ('monitor', 'assistente', 'titular'));

-- c) Atualizar os professores inseridos e suas respectivas funções;
UPDATE professor SET funcao = 'monitor'
	WHERE idprofessor in (1,2);
    
UPDATE professor SET funcao = 'assistente'
	WHERE idprofessor in (3,4);
    
UPDATE professor SET funcao = 'titular'
	WHERE idprofessor in (5,6);
    
-- d) Inserir um novo professor;
INSERT INTO professor VALUES
 (08, 'Marcelo','P.I','2000-05-24' , 'titular');

-- e) Excluir o professor onde o idProfessor é igual a 5;
DELETE FROM professor WHERE idprofessor = 5;

-- f) Exibir apenas os nomes dos professores titulares;
SELECT nome FROM professor
	WHERE funcao = 'titular';
    
-- g) Exibir apenas as especialidades e as datas de nascimento dos professores monitores;
SELECT especialidade, dtNasc  FROM professor
	WHERE funcao = 'monitor';

-- h) Atualizar a data de nascimento do idProfessor igual a 3;
UPDATE professor SET dtNasc = '1900-10-10'
	WHERE idprofessor = '03';
    
-- i) Limpar a tabela Professor;
TRUNCATE professor;


    