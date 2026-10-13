
CREATE database sprint2;
use sprint2;

CREATE TABLE time_futebol (
  id_time INT PRIMARY KEY,
  nome VARCHAR(45)
);

CREATE TABLE jogador (
  id_jogador INT PRIMARY KEY,
  nome VARCHAR(45),
  posicao VARCHAR(20),
  fk_time INT,
  FOREIGN KEY (fk_time) REFERENCES time_futebol (id_time)
);

INSERT INTO time_futebol VALUES
  (1, 'Corinthians'),
  (2, 'Palmeiras'),
  (3, 'Santos');

INSERT INTO jogador VALUES
  (100, 'Lucas',   'Atacante', 1),
  (101, 'Rafael',  'Goleiro',  2),
  (102, 'Thiago',  'Zagueiro', 1),
  (103, 'Gabriel', 'Atacante', 3),
  (104, 'Bruno',   'Goleiro',  NULL);
  
SELECT time_futebol.nome as t, jogador.nome as j FROM jogador 
join  time_futebol on fk_time = id_time;

SELECT jogador.nome as j, jogador.posicao, time_futebol.nome as t from jogador
join time_futebol on fk_time = id_time;

SELECT jogador.nome, time_futebol.nome FROM jogador
join time_futebol on fk_time = id_time
WHERE time_futebol.nome = 'Corinthians';


SELECT * FROM jogador
left join time_futebol on fk_time = id_time;



/*-----------------------------------------------------------------------*/

 
  CREATE TABLE sala (
  id_sala INT PRIMARY KEY,
  numero VARCHAR(10),
  andar INT,
  capacidade INT
);


CREATE TABLE turma (
  id_turma INT PRIMARY KEY,
  nome VARCHAR(45),
  periodo VARCHAR(10),
  fk_sala INT,
  FOREIGN KEY (fk_sala) REFERENCES sala(id_sala)
);

CREATE TABLE aluno (
  id_aluno INT PRIMARY KEY,
  nome VARCHAR(45),
  idade INT,
  fk_turma INT,
  FOREIGN KEY (fk_turma) REFERENCES turma(id_turma)
);

INSERT INTO sala VALUES
  (1, 'A101', 1, 40),
  (2, 'B205', 2, 30),
  (3, 'C310', 3, 50),
  (4, 'D402', 4, 25);

INSERT INTO turma VALUES
  (1, '1ADS-A', 'Manhã', 1),
  (2, '1ADS-B', 'Noite', 2),
  (3, '1CCO',   'Manhã', 3),
  (4, '1SIS',   'Noite', NULL);

INSERT INTO aluno VALUES
  (10, 'Ana',      19, 1),
  (11, 'Carlos',   22, 2),
  (12, 'Beatriz',  18, 1),
  (13, 'Diego',    25, 3),
  (14, 'Eduarda',  20, NULL),
  (15, 'Fernando', 21, 4);
  
  
  SELECT turma.nome, sala.numero from turma
  join sala on turma.fk_sala = sala.id_sala;
  

  
  SELECT a.nome,
  t.nome,
  s.numero from sala as s
  join turma as t on t.fk_sala = s.id_sala
  join aluno as a on a.fk_turma = t.id_turma;
  
  
  
  SELECT a.nome,
  t.nome,
  s.numero from sala as s
  join turma as t on t.fk_sala = s.id_sala
  join aluno as a on a.fk_turma = t.id_turma
  where s.andar = 1;
  
  
  SELECT a.nome,
  t.nome,
  s.numero from sala as s
  right join turma as t on t.fk_sala = s.id_sala
  join aluno as a on a.fk_turma = t.id_turma;
  
  
  
  
 SELECT a.nome, t.nome, s.numero
FROM aluno AS a
LEFT JOIN turma AS t ON t.id_turma = a.fk_turma
LEFT JOIN sala  AS s ON s.id_sala  = t.fk_sala;

/*----------------------------------------------------------------*/

CREATE TABLE filial (
  id_filial INT PRIMARY KEY,
  cidade VARCHAR(45)
);

CREATE TABLE departamento (
  id_depto INT PRIMARY KEY,
  nome VARCHAR(45),
  fk_filial INT,
  FOREIGN KEY (fk_filial) REFERENCES filial(id_filial)
);

CREATE TABLE funcionario (
  id_func INT PRIMARY KEY,
  nome VARCHAR(45),
  salario DECIMAL(8,2),
  fk_depto INT,
  fk_gerente INT,
  FOREIGN KEY (fk_depto) REFERENCES departamento(id_depto),
  FOREIGN KEY (fk_gerente) REFERENCES funcionario(id_func)
);

CREATE TABLE cracha (
  id_cracha INT PRIMARY KEY,
  codigo VARCHAR(10),
  fk_funcionario INT UNIQUE,     -- UNIQUE garante o 1:1
  FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id_func)
);

INSERT INTO filial VALUES
  (1, 'São Paulo'),
  (2, 'Campinas'),
  (3, 'Santos');

INSERT INTO departamento VALUES
  (1, 'TI',        1),
  (2, 'RH',        1),
  (3, 'Vendas',    2),
  (4, 'Marketing', NULL);

INSERT INTO funcionario VALUES
  (1, 'Paula',   9000, 1,    NULL),
  (2, 'Rodrigo', 6000, 1,    1),
  (3, 'Sofia',   5500, 2,    1),
  (4, 'Tiago',   4000, 3,    2),
  (5, 'Vanessa', 7000, 4,    NULL),
  (6, 'Wagner',  3500, NULL, 2);

INSERT INTO cracha VALUES
  (1, 'C-001', 1),
  (2, 'C-002', 2),
  (3, 'C-003', 4),
  (4, 'C-004', 5);
  
  SELECT f.nome, c.codigo from funcionario as f
  join cracha as c on f.id_func = c.fk_funcionario;
  
  SELECT func.nome, d.nome, f.cidade
  from filial as f
  join departamento as d on f.id_filial = d.fk_filial
  join funcionario as func on d.id_depto = func.fk_depto;
  
  
  SELECT func.nome, func.salario, d.nome 
  from filial as f
  join departamento as d on f.id_filial = d.fk_filial
  join funcionario as func on d.id_depto = func.fk_depto
  where func.salario > 500 and f.cidade = 'São Paulo';
  
  SELECT  f.nome as funcionario , g.nome as gerente
  FROM funcionario as f
  left join funcionario as g on g.id_func = f.fk_gerente;
  
  
  SELECT func.nome, d.nome, f.cidade, c.codigo FROM funcionario as func
  left join departamento as d on d.id_depto = func.fk_depto
  left join filial as f on f.id_filial = d.fk_filial
  left join cracha as c on func.id_func = c.fk_funcionario;
  
  
  
  
  
  SELECT f.cidade, d.nome, func.nome, func.salario from filial as f 
  left join departamento as d on f.id_filial = d.fk_filial
  left join funcionario as func on d.id_depto = func.fk_depto and func.salario > 5000;
  
  
  
  
  CREATE TABLE pessoa (
  id_pessoa INT PRIMARY KEY,
  nome VARCHAR(45),
  cidade VARCHAR(45),
  fk_mae INT,
  FOREIGN KEY (fk_mae) REFERENCES pessoa(id_pessoa)
);

INSERT INTO pessoa VALUES
  (1, 'Helena', 'São Paulo',      NULL),
  (2, 'Marta',  'São Paulo',      1),
  (3, 'Lúcia',  'Rio de Janeiro', 1),
  (4, 'Pedro',  'São Paulo',      2),
  (5, 'Júlia',  'Campinas',       2),
  (6, 'Caio',   'Rio de Janeiro', 3),
  (7, 'Renata', 'Belo Horizonte', NULL);
  
  SELECT m.nome as mae, f.nome as filha from pessoa as f
  join pessoa as m on m.id_pessoa = f.fk_mae;
   
   
SELECT ifnull(m.nome, 'não tem')as mae, f.nome as filha from pessoa as f
 left join pessoa as m on m.id_pessoa = f.fk_mae;
 
   SELECT m.nome as mae, f.nome as filha from pessoa as f
  join pessoa as m on m.id_pessoa = f.fk_mae
  where m.nome = 'Marta';
  
  
  
  
   SELECT m.nome as mae, m.cidade as cidadeM, f.nome as filha, f.cidade as cidadeF from pessoa as f
  join pessoa as m on m.id_pessoa = f.fk_mae
  where m.cidade <> f.cidade;
  
  SELECT m.nome as mae, ifnull(f.nome, 'não tem') as filha from pessoa as m
 left join pessoa as f on m.id_pessoa = f.fk_mae;
 
 
 
 
   CREATE TABLE categoria (
  id_categoria INT PRIMARY KEY,
  nome VARCHAR(45),
  qtd_produtos INT,
  fk_categoria_pai INT,
  FOREIGN KEY (fk_categoria_pai) REFERENCES categoria(id_categoria)
);

INSERT INTO categoria VALUES
  (1, 'Eletrônicos',         10, NULL),
  (2, 'Celulares',           25, 1),
  (3, 'Notebooks',            8, 1),
  (4, 'Smartphones Android', 40, 2),
  (5, 'iPhones',             15, 2),
  (6, 'Roupas',              30, NULL),
  (7, 'Camisetas',           50, 6),
  (8, 'Livros',              60, NULL);
  
  
  
SELECT f.nome as subCtg, p.nome as princCtg from categoria as f
join categoria as p on p.id_categoria = f.fk_categoria_pai;
  
  
  
  
    