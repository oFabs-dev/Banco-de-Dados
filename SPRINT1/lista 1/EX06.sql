USE sprint1;

CREATE TABLE revista(

idrevista INT PRIMARY KEY auto_increment,
nome VARCHAR(40),
categoria VARCHAR(30)

);

INSERT INTO revista VALUES
	(default, 'Recreio', null),
    (default, 'Veja', null),
    (default, 'Fofoca', null);
    
-- • Exibir todos os dados da tabela.
SELECT * FROM revista;

-- • Atualize os dados das categorias das 3 revistas inseridas. Exibir os dados da tabela novamente para verificar se atualizou corretamente.
UPDATE revista SET categoria = 'infantil'
	WHERE idrevista = 1;
    
UPDATE revista SET categoria = 'Famosos'
	WHERE idrevista = 2;
    
UPDATE revista SET categoria = 'Noticias'
	WHERE idrevista = 3;
    
-- • Insira mais 3 registros completos.
INSERT INTO revista VALUES
	(default, 'sptechnews', 'Tecnologia'),
    (default, 'CNN', 'Noticias'),
    (default, 'G1', 'Noticias');
    
-- • Exibir novamente os dados da tabela.
SELECT * FROM revista;

-- • Exibir a descrição da estrutura da tabela.
DESCRIBE revista;

-- • Alterar a tabela para que a coluna categoria possa ter no máximo 40 caracteres.
ALTER TABLE revista MODIFY COLUMN categoria VARCHAR(40);

-- • Exibir novamente a descrição da estrutura da tabela, para verificar se alterou o tamanho da coluna categoria
DESCRIBE revista;

-- • Acrescentar a coluna periodicidade à tabela, que é varchar(15).
ALTER TABLE revista ADD COLUMN periodicidade VARCHAR(15); 

-- • Exibir os dados da tabela.
TRUNCATE revista;
    
-- • Excluir a coluna periodicidade da tabela.
ALTER TABLE revista DROP periodicidade;

    
    
