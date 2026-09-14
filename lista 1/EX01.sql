USE sprint1;

 CREATE TABLE atleta (
 idAtleta INT PRIMARY KEY,   
 nome VARCHAR(40),
 modalidade VARCHAR(40),
 qtdMedalha INT
 );
 
 INSERT INTO atleta VALUES
	(01, 'Jorge', 'Futebol', 6),
    (02, 'Matheus', 'Vôlei', 3),
    (03, 'Marcos', 'Luta', 2),
    (04, 'Marcola', 'Luta', 3),
    (05, 'Jorge', 'Futebol', 4),
    (06, 'Jorginho', 'Futebol', 5);
    
-- • Exibir todos os dados da tabela.   
SELECT * FROM atleta;

-- Atualizar a quantidade de medalhas do atleta com id=1;
UPDATE atleta SET qtdMedalha = 3
	WHERE idAtleta = 1;  
    
-- • Atualizar a quantidade de medalhas do atleta com id=2 e com o id=3;
UPDATE atleta set qtdMedalha = 2
	WHERE idAtleta IN (1,2);

-- • Atualizar o nome do atleta com o id=4;
UPDATE atleta set nome = 'VOLPE'
	WHERE idAtleta = 4;  
    
-- • Adicionar o campo dtNasc na tabela, com a data de nascimento dos atletas, tipo date; 
ALTER TABLE atleta ADD COLUMN dtNasc DATE;

-- • Atualizar a data de nascimento de todos os atletas;
UPDATE atleta set dtNasc = '2005-05-21'
	WHERE idAtleta IN (1,2,3,4,5,6);
 
-- • Excluir o atleta com o id=5;   
DELETE FROM atleta
	WHERE idAtleta = 05;
    
-- • Exibir os atletas onde a modalidade é diferente de natação;
SELECT * FROM atleta
	WHERE modalidade <> 'Luta';
    
-- • Exibir os dados dos atletas que tem a quantidade de medalhas maior ou igual a 3;
SELECT * FROM atleta
	WHERE qtdMedalha >= 3;
    
-- • Modificar o campo modalidade do tamanho 40 para o tamanho 60;
ALTER TABLE atleta MODIFY COlUMN modalidade VARCHAR (60);

-- • Descrever os campos da tabela mostrando a atualização do campo modalidade;
DESCRIBE atleta;

-- • Limpar os dados da tabela;
TRUNCATE atleta;
    









    
    
   
    
