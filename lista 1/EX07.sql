USE sprint1;

CREATE TABLE carro(

idcarro INT PRIMARY KEY auto_increment,
nome VARCHAR(40),
placa CHAR(7)

);

INSERT INTO carro VALUES
	(1000, 'Palio', 'QWE1234'),
    (default, 'Corsa', 'IED1234'),
    (default, 'Gol', 'FFD1234'),
    (default, 'Prisma', 'KDF1234');
    


-- • Exibir todos os dados da tabela.
SELECT * FROM carro;

-- • Insira mais 3 registros sem a placa dos carros.
INSERT INTO carro(idcarro,nome) VALUES
	(default,'Opala'),
    (default, 'Porsche'),
    (default, 'Fusca');
    
-- • Exibir novamente os dados da tabela.
SELECT * FROM carro;

-- • Exibir a descrição da estrutura da tabela.
DESCRIBE carro;

-- • Alterar a tabela para que a coluna nome possa ter no máximo 28 caracteres.
ALTER TABLE carro MODIFY COLUMN nome VARCHAR (28);

-- • Exibir novamente a descrição da estrutura da tabela, para verificar se alterou o tamanho da coluna;
DESCRIBE carro;

-- • Acrescentar a coluna ano à tabela, que é char(4);
ALTER TABLE carro ADD COLUMN ano CHAR(4);

-- • Atualizar todos os dados nulos da tabela;

UPDATE carro SET placa = 'EJF1244'
	WHERE idcarro = 1005;
    
UPDATE carro SET placa = 'EJF1244'
	WHERE idcarro = 1006;
    
UPDATE carro SET placa = 'EFF1249'
	WHERE idcarro = 1007;
    
UPDATE carro SET ano = '2010'
	WHERE idcarro in (1000,1001);
    
UPDATE carro SET ano = '2014'
	WHERE idcarro in (1002,1003);
    
UPDATE carro SET ano = '2009'
	WHERE idcarro in (1004,1005);
    
UPDATE carro SET ano = '2020'
	WHERE idcarro in (1006,1007);

