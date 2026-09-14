USE sprint1;

CREATE TABLE curso(
idcurso INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50),
sigla CHAR (3),
coordenador VARCHAR(50)
);

INSERT INTO curso VALUES
	(default, 'Banco de dados', 'BDD', 'Jorge'),
    (default, 'Tecnologia da informação', 'TEI', 'Jorge'),
    (default, 'Algoritmos', 'ALG' , 'Ramom');
    
  
-- a) Exibir todos os dados da tabela.
SELECT * FROM curso;
-- b) Exibir apenas os coordenadores dos cursos.
SELECT coordenador FROM curso;
	
-- c) Exibir apenas os dados dos cursos de uma determinada sigla.  
SELECT * FROM curso
	WHERE sigla = 'ALG';
	    
-- d) Exibir os dados da tabela ordenados pelo nome do curso.
SELECT * FROM curso ORDER BY nome;
	
-- e) Exibir os dados da tabela ordenados pelo nome do coordenador em ordem decrescente.
   SELECT * FROM curso ORDER BY coordenador DESC;

-- f) Exibir os dados da tabela, dos cursos cujo nome comece com uma determinada letra.
SELECT * FROM curso
	WHERE nome LIKE 'a%';
    
-- g) Exibir os dados da tabela, dos cursos cujo nome termine com uma determinada letra.
SELECT * FROM curso
	WHERE nome LIKE '%o';
    
-- h) Exibir os dados da tabela, dos cursos cujo nome tenha como segunda letra uma determinada letra.
SELECT * FROM curso
	WHERE nome LIKE '_a%';
    
-- i) Exibir os dados da tabela, dos cursos cujo nome tenha como penúltima letra uma determinada letra.
SELECT * FROM curso
	WHERE nome LIKE '%o_'; 
    
-- j) Elimine a tabela.
DROP TABLE curso;





