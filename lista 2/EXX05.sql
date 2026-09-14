/*5 – Heróis
No MySQL Workbench, crie o banco de dados “vingadores”.
Crie uma tabela chamada “heroi”, onde terá um campo de nome contendo até 45
caracteres. O seu herói poderá ter uma versao, onde será armazenado o filme de
sua escolha, esse campo aceitará até 45 caracteres. Todo herói, tem uma
habilidade que se destaca entre os outros super-heróis. Todo herói tem uma
altura, esse campo aceitará valores inteiros representando centímetros. O id
deverá se autoincrementar.*/

USE sprint1;

CREATE TABLE heroi(
id INT PRIMARY KEY  auto_increment,
nome VARCHAR (45),
filme VARCHAR(45),
habilidade varchar(45),
altura INT

);


-- Insira 5 heróis para derrotar o vilão Doutor Destino.
INSERT INTO heroi VALUES

(default,'Homem de Ferro', 'Vingadores', 'Armadura tecnológica', 178),
(default,'Capitã Marvel', 'Vingadores', 'Voo e disparo de energia', 173),
(default,'Homem-Aranha', 'Homem-Aranha: De Volta ao Lar', 'Agilidade e teia', 178),
(default,'Pantera Negra', 'Pantera Negra', 'Força e garras de vibranium', 183),
(default,'Thor', 'Thor: Ragnarok', 'Controle de raios e força divina', 190);


-- 1. Exiba os dados inseridos na tabela
SELECT * FROM heroi;
-- 2. Adicione um campo de regeneração, onde ele aceitará apenas os valores booleanos de TRUE ou FALSE
ALTER TABLE heroi ADD COLUMN regeneracao tinyint,
	ADD constraint chkReg check(regeneracao in (1,0));
    
-- 3. Modifique o campo versão para aceitar até 100 caracteres.
ALTER TABLE heroi MODIFY COLUMN filme varchar(100);

-- 4. Remova o herói de id 3 pois ele se morreu em batalha.
DELETE FROM heroi
	WHERE id = 3;
-- 5. Chegou reforços, insira um novo herói para a equipe.
INSERT INTO heroi(nome,filme,habilidade,altura) VALUES
	('Deadpool','Deadpool 1', 'Imortalidade e armas',180);
    
-- 6. Exiba todos os dados inseridos na tabela onde o nome do herói começa com “C” ou “H”.
SELECT * FROM heroi
	WHERE nome LIKE 'c%' or nome LIKE 'h%';
    
-- 7. Exiba todos os dados inseridos na tabela onde o nome do herói não contém a letra “A” no campo nome.
SELECT * FROM heroi
	WHERE nome not like '%a%';
    
-- 8. Exiba apenas o nome do herói onde a altura for maior que 190.
SELECT * FROM heroi 
	where altura > 190;
    
-- 9. Exiba todos os dados da tabela de forma decrescente pelo nome onde a altura do herói for maior que 180.
SELECT * FROM heroi 
	WHERE altura > 180 order by nome desc ;
	
-- 10. Limpe os dados da tabela.

truncate heroi;