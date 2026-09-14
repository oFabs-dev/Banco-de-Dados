/*4 – Despensa do Scooby-Doo
No MySQL Workbench, crie o banco de dados "estoque".
A turma do Scooby Doo percebeu que os alimentos guardados no armário estavam
sumindo de forma muito rápida. Para ter um melhor controle, Fred propôs criar
um banco de dados que registrasse os dados de entrada e saída dos alimentos do
armário.
Ele criou uma tabela chamada "MisteriosSA", que possui os campos id um número
inteiro chave primária, nome um campo de texto para armazenar o nome do
produto, data da compra para armazenar a data na qual o produto foi comprado,
preço valor numérico com casas decimais, peso um valor numérico que armazena
o peso em gramas e data de retirada para armazenar a data em que o produto foi
consumido.*/

USE sprint1;

CREATE TABLE MisteriosSA (

id INT PRIMARY KEY auto_increment,
produto VARCHAR(50),
compra DATE,
VALOR decimal,
peso INT,
retirada DATE,
consumido DATE

);


-- 1. Insira na tabela, no mínimo 5 compras de alimentos com datas diferentes. Por agora, não preencha a coluna referente a "data de retirada".
INSERT INTO MisteriosSA(id,produto,compra,VALOR,peso) VALUES
(default,'biscoito','2026-08-20', 25.0, 500),
(default,'biscoito','2025-08-25', 40.0, 1000),
(default,'pizza','2026-05-26', 25.0, 500),
(default,'hamburguer','2025-05-20', 50.0, 800),
(default,'batata','2024-02-05', 20.0, 1000);

-- 2. Verifique se os valores foram inseridos corretamente.
SELECT * FROM MisteriosSA;

-- 3. Exiba os nomes, as datas de compra e retirada e o id dos alimentos ordenados a partir da data de compra mais antiga.
SELECT * FROM MisteriosSA order by compra;

-- 4. Alguém comeu uma caixa de biscoitos, atualize a data de retirada da caixa de “Biscoitos Scooby” que foi comprada a mais tempo.
UPDATE MisteriosSA SET retirada = '2026-08-24'
	WHERE id = 2;
    
-- 5. Altere o nome da coluna id para idComida.
ALTER TABLE MisteriosSA RENAME COLUMN id TO idcomida;

-- 6. Altere o tipo do check para que os alimentos só possam ser “Biscoitos Scooby” ou “Cachorro-quente”.
ALTER TABLE MisteriosSA ADD CONSTRAINT chkAlimento check (produto IN ('Biscoitos Scooby','Cachorro-quente'));

-- 7. Exiba os produtos onde o nome seja "Biscoitos Scooby" de forma que o nome das colunas dataCompra apareça como "data da compra"
-- e dataRetirada apareça como "data da retirada".

SELECT produto, compra AS 'data_da_compra', retirada AS data_da_retirada FROM  MisteriosSA
	WHERE produto = 'biscoito';


-- 8. Exiba os alimentos que foram comprados antes do dia 25 de julho de 2024.
SELECT * FROM MisteriosSA
	WHERE compra < '2024-7-25';
    
-- 9. Exiba os alimentos que possuem um preço acima ou igual a 30.50.
SELECT * FROM MisteriosSA
	WHERE valor >= 30.50 ;


-- 10. Limpe a tabela.
TRUNCATE MisteriosSA;