--  Loja de Jogos
/* No MySQL Workbench, crie o banco de dados "game_store".
A loja de jogos “Game Store” estava passando dificuldades de organização pois o
dono Mário, um simpático senhor italiano aposentado que trabalhou com
encanamento durante sua juventude, não tinha controle do seu estoque de jogos.
Para ajudar Mário a organizar sua loja de jogos, um estudante da SPTech propôs
criar uma tabela chamada “jogo” que continha o id como número e chave primária
que se autoincrementa, o nome do jogo com tamanho máximo de 30 caracteres, o
nome do diretor do jogo com tamanho máximo de 30 caracteres, o gênero com
tamanho de 30 caracteres, a data de lançamento, a nota do jogo (entre 0-10) e um
campo para guardar a quantidade de unidades disponíveis.*/

USE sprint1;

CREATE TABLE jogostore(

id INT PRIMARY KEY auto_increment,
nome VARCHAR(30),
diretor VARCHAR(30),
genero VARCHAR(30),
lacamento DATE,
nota float,
CONSTRAINT checknota CHECK(nota >= 0 AND nota <= 10),
disponivel float

);


-- 1. Insira pelo menos 5 registros para a tabela.
INSERT INTO jogostore VALUES
	(default, 'Crash', 'Ronaldo', 'Aventura', '2010-05-21', 8, 4),
    (default, 'Bioshock', 'Bob', 'Terror', '2015-05-21', 8, 3),
    (default, 'Habbo', 'Jack', 'Diversão', '2016-05-21', 8, 2),
    (default, 'Transformice','Joca', 'Diversão', '2019-05-21', 8, 1),
    (default, 'Pou', 'Ellen', 'Suspense', '2008-05-21', 8, 1);
    
-- 2. Altere a tabela para inserir uma coluna que represente o tipo de mídia que deve armazenar o tipo de jogo apenas com os valores “física” ou “digital”.
ALTER TABLE jogostore ADD COLUMN midia VARCHAR(10), ADD CONSTRAINT chkmidia CHECK(midia IN('fisica','digital'));

-- 3. Atualize os registros dos jogos inseridos anteriormente.
UPDATE jogostore SET midia = 'fisica'
	WHERE id IN (1,3,5);
    
UPDATE jogostore SET midia = 'digital'
	WHERE id IN (2,4);
    
-- 4. Exiba apenas os jogos com data de lançamento a partir de 2015.
SELECT * FROM jogostore
	WHERE YEAR (lacamento) > 2015-01-01;


-- 5. Exiba os jogos que tenham a letra “a” em seu nome e são de mídia física.
SELECT nome FROM jogostore
	WHERE nome LIKE '%a%' and midia= 'fisica';

-- 6. Exiba os jogos onde o nome do diretor não contenha a letra “e”.
SELECT nome FROM jogostore
	WHERE diretor NOT LIKE '%e%';
    
-- 7. Altere a tabela para criar uma checagem na inserção da nota, onde o valor não pode ser menor que 0 e nem maior que 10.
ALTER TABLE jogostore ADD CONSTRAINT chknota CHECK (nota>= 0 AND nota <= 10);

-- 8. Exiba os jogos de um determinado gênero e que ainda esteja em estoque.
SELECT nome FROM jogostore
	WHERE Genero = 'Diversão' and disponivel <> 0;
    
-- 9. Exclua os jogos que não têm mais unidades disponíveis em estoque.
DELETE FROM jogostore WHERE disponivel = 0 AND id <= 0;
    
-- 10. Renomeie a coluna “diretor” para “criador” e exiba como ficou a estrutura da tabela. 
ALTER TABLE jogostore RENAME COLUMN diretor to criador;

/* – Esportes Olímpicos
No MySQL Workbench, crie o banco de dados "olimpiadas".
Casimiro, um fã apaixonado por esportes, decidiu que queria acompanhar de
perto as Olimpíadas. Ele pediu ajuda a um amigo para criar uma tabela que
armazenasse informações sobre os esportes praticados nas Olimpíadas.
Eles criaram uma tabela chamada "esporte" que continha id como número e chave
primária que se autoincrementa, nome que armazena o nome do esporte com
limite de 40 caracteres, a categoria do esporte com limite de 20 caracteres que
aceita apenas ("Individual" ou "Coletivo"), o número de jogadores que podem
participar por equipe, estreia que armazena a data de quando o esporte estreou
nas Olimpíadas e o nome do país de origem do esporte com até 30 caracteres. */


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

-- 2. Altere a tabela para adicionar uma coluna popularidade que armazene a popularidade do esporte como um valor decimal entre 0 e 10 e exiba como ficou a estrutura da tabela.
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
    
    
    
/* Desenhos Animados
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



/* Despensa do Scooby-Doo
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


/* Heróis
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