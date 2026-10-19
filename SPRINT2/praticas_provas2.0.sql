-- =====================================================================
-- BANCO DE DADOS - EXERCÍCIOS SPRINT II
-- Tabelas (CREATE) e INSERTs dos exercícios 1 a 5 - MySQL
-- =====================================================================


-- =====================================================================
-- 1 - ESCOLA DE INGLÊS (MyEnglish)
-- aluno 1:1 endereco | o aluno existe sem endereço (FK fica em endereco)
-- =====================================================================
use sprint2;

CREATE TABLE aluno (
    idAluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    dtNascimento DATE,
    matricula CHAR(8) NOT NULL UNIQUE
);

CREATE TABLE endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(100),
    numero VARCHAR(10),
    bairro VARCHAR(60),
    cidade VARCHAR(60),
    estado VARCHAR(40),
    cep CHAR(8),
    fkAluno INT UNIQUE,  -- UNIQUE: cada aluno tem no máximo 1 endereço
    CONSTRAINT fkEnderecoAluno FOREIGN KEY (fkAluno) REFERENCES aluno(idAluno)
) AUTO_INCREMENT = 100;

INSERT INTO aluno (nome, dtNascimento, matricula) VALUES
('Lucas Ferreira',    '2003-04-12', '01251001'),
('Beatriz Souza',     '2002-09-30', '01251002'),
('Gustavo Lima',      '2004-01-18', '01251003'),
('Mariana Costa',     '2001-12-05', '01251004'),
('Rafael Oliveira',   '2003-07-22', '01251005'),
('Juliana Mendes',    '2002-03-14', '01251006'),
('Felipe Rocha',      '2004-11-02', '01251007'),
('Camila Ribeiro',    '2003-05-27', '01251008'),
('Thiago Nunes',      '2001-08-09', '01251009'),
('Eduardo Pinto',     '2002-10-16', '01251010');

INSERT INTO endereco (logradouro, numero, bairro, cidade, estado, cep, fkAluno) VALUES
('Rua Haddock Lobo',        '595',  'Cerqueira César', 'São Paulo',      'São Paulo',      '01414905', 1),
('Avenida Paulista',        '1000', 'Bela Vista',      'São Paulo',      'São Paulo',      '01310100', 2),
('Rua Tuiuti',              '120',  'Tatuapé',         'São Paulo',      'São Paulo',      '03081000', 3),
('Rua Clélia',              '350',  'Lapa',            'São Paulo',      'São Paulo',      '05042000', 4),
('Avenida Atlântica',       '1702', 'Copacabana',      'Rio de Janeiro', 'Rio de Janeiro', '22021001', 5),
('Rua Carolina Machado',    '88',   'Madureira',       'Rio de Janeiro', 'Rio de Janeiro', '21350000', 6),
('Rua XV de Novembro',      '45',   'Centro',          'Curitiba',       'Paraná',         '80020310', 7),
('Avenida Afonso Pena',     '900',  'Funcionários',    'Belo Horizonte', 'Minas Gerais',   '30130002', 8),
('Rua Domingos de Morais',  '2200', 'Vila Mariana',    'São Paulo',      'São Paulo',      '04036000', 9),
('Avenida Kennedy',         '700',  'Jardim do Mar',   'São Bernardo do Campo', 'São Paulo', '09726000', 10);

SELECT * FROM aluno
join endereco on fkAluno = idAluno;

UPDATE endereco set logradouro = 'Rua o', numero = '22' WHERE fkAluno = 4;

SELECT * FROM aluno
join endereco on fkAluno = idAluno
WHERE cidade = 'São paulo';

DELETE FROM endereco WHERE cidade = 'Rio de Janeiro' and idEndereco > 0;

ALTER TABLE endereco ADD COLUMN pais VARCHAR(50);

DELETE FROM endereco WHERE bairro LIKE '_a% and' and idEndereco > 0;

ALTER TABLE endereco rename column CEP TO codigoPostal;

SELECT * FROM aluno
join endereco on fkAluno = idAluno
ORDER BY nome;


SELECT * FROM aluno
left join endereco on fkAluno = idAluno
WHERE fkAluno IS NULL;

SELECT a.nome as nomeAluno , e.logradouro as logradouroEndereco from aluno as a 
join endereco as e ON a.idAluno = e.fkAluno;

SELECT * FROM aluno LIMIT 5;

SELECT * from aluno 
where nome not like '%a%';

truncate aluno;

alter table endereco drop constraint fkEnderecoAluno;




-- =====================================================================
-- 2 - ROCK IN RIO
-- palco 1:N participante (fkPalco NOT NULL - nunca fica sem palco)
-- participante responsável 1:N participante dependente (recursivo)
-- =====================================================================

CREATE TABLE palco (
    idPalco INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    artistaPrincipal VARCHAR(80),
    capacidade INT,
    precoIngresso DECIMAL(7,2)
);

CREATE TABLE participante (
    idParticipante INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    dtNascimento DATE,
    telefone VARCHAR(15),
    fkPalco INT NOT NULL,
    fkResponsavel INT,  -- id do participante responsável (NULL = não tem)
    CONSTRAINT fkParticipantePalco FOREIGN KEY (fkPalco) REFERENCES palco(idPalco),
    CONSTRAINT fkParticipanteResponsavel FOREIGN KEY (fkResponsavel) REFERENCES participante(idParticipante)
);

INSERT INTO palco (nome, artistaPrincipal, capacidade, precoIngresso) VALUES
('Palco Mundo',     'Iron Maiden',     100000, 450.00),
('Sunset',          'Pitty',            30000, 180.00),
('Espaço Favela',   'Ludmilla',         15000, 120.00),
('New Dance Order', 'Alok',             20000, 150.00),
('Supernova',       'Capital Inicial',  10000, 250.00);

-- Responsáveis / maiores de idade (sem responsável)
INSERT INTO participante (nome, cpf, dtNascimento, telefone, fkPalco, fkResponsavel) VALUES
('Carlos Andrade',   '11122233344', '1980-03-10', '11987650001', 1, NULL), -- 1
('Fernanda Lopes',   '22233344455', '1985-07-21', '11987650002', 2, NULL), -- 2
('Ricardo Alves',    '33344455566', '1978-11-30', '21987650003', 1, NULL), -- 3
('Patrícia Gomes',   '44455566677', '1990-02-14', '21987650004', 3, NULL), -- 4
('Bruno Martins',    '55566677788', '1995-06-05', '11987650005', 4, NULL), -- 5
('Aline Teixeira',   '66677788899', '1999-09-18', '31987650006', 5, NULL), -- 6
('Diego Carvalho',   '77788899900', '2001-12-01', '11987650007', 2, NULL), -- 7
('Larissa Moura',    '88899900011', '1997-04-25', '21987650008', 4, NULL); -- 8

-- Dependentes (menores de idade com responsável)
INSERT INTO participante (nome, cpf, dtNascimento, telefone, fkPalco, fkResponsavel) VALUES
('Pedro Andrade',    '99900011122', '2011-05-15', '11987650009', 1, 1),
('Sofia Andrade',    '10120230340', '2013-08-02', '11987650010', 1, 1),
('Enzo Lopes',       '20230340450', '2010-01-20', '11987650011', 2, 2),
('Valentina Alves',  '30340450560', '2012-10-11', '21987650012', 1, 3),
('Miguel Gomes',     '40450560670', '2014-03-07', '21987650013', 3, 4),
('Helena Gomes',     '50560670780', '2011-12-24', '21987650014', 3, 4),
('Arthur Martins',   '60670780890', '2009-07-30', '11987650015', 4, 5);


SELECT * FROM palco
JOIN participante on idPalco = fkPalco;

UPDATE palco set precoIngresso = '500' 
WHERE idPalco = 1;

SELECT * FROM palco
JOIN participante on idPalco = fkPalco
WHERE precoIngresso > '200';

ALTER TABLE participante ADD COLUMN email VARCHAR(255);

ALTER TABLE participante RENAME COLUMN telefone to contato;

SELECT * FROM palco
JOIN participante on idPalco = fkPalco
where fkResponsavel is null;

SELECT * FROM participante as p
join participante as dep on p.fkResponsavel = dep.idParticipante;





SELECT p.nome, p.capacidade FROM palco as p
JOIN participante as par on idPalco = fkPalco
where precoIngresso <= 150;


SELECT par.nome, p.nome FROM palco AS P
JOIN participante as par ON idPalco = fkPalco
where p.nome like 'S%';




-- =====================================================================
-- 3 - POKÉMON
-- treinador 1:1 treinador (mentor orienta apenas 1 discípulo -> UNIQUE)
-- treinador 1:N pokemon (pokémon pode ficar livre -> fkTreinador NULL)
-- =====================================================================
CREATE DATABASE pokemon;
USE pokemon;

CREATE TABLE treinador (
    idTreinador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    dtNascimento DATE NOT NULL,
    qtdMedalhas INT DEFAULT 0,
    cidadeOrigem VARCHAR(60),
    fkMentor INT UNIQUE,
    CONSTRAINT fkTreinadorMentor FOREIGN KEY (fkMentor) REFERENCES treinador(idTreinador),
    -- Mínimo de 14 anos. O MySQL não aceita CURDATE() dentro de CHECK,
    -- então usamos a data de hoje (16/10/2026) menos 14 anos.
    CONSTRAINT chkIdade CHECK (dtNascimento <= '2012-10-16')
);

CREATE TABLE pokemon (
    idPokemon INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    altura DECIMAL(4,2),   -- em metros
    peso DECIMAL(6,2),     -- em kg (NULL se for menor que 1 kg)
    lendario BOOLEAN,      -- o exercício 4 depois torna obrigatório
    tipo VARCHAR(10),
    fkTreinador INT,
    CONSTRAINT chkTipo CHECK (tipo IN ('Fogo', 'Água', 'Fantasma', 'Pedra', 'Elétrico', 'Lutador')),
    CONSTRAINT fkPokemonTreinador FOREIGN KEY (fkTreinador) REFERENCES treinador(idTreinador)
) AUTO_INCREMENT = 100;

-- Mentores primeiro (eles não têm mentor e não têm pokémons)
INSERT INTO treinador (nome, dtNascimento, qtdMedalhas, cidadeOrigem, fkMentor) VALUES
('Professor Carvalho', '1955-03-12', 8, 'Pallet',    NULL), -- 1 (mentor)
('Brock',              '1998-07-15', 8, 'Pewter',    NULL); -- 2 (mentor)

-- Treinadores (Ash e Misty têm mentor)
INSERT INTO treinador (nome, dtNascimento, qtdMedalhas, cidadeOrigem, fkMentor) VALUES
('Ash Ketchum',   '2000-05-22', 8, 'Pallet',    1),    -- 3
('Misty',         '2001-02-10', 3, 'Cerulean',  2),    -- 4
('Gary Carvalho', '2000-11-01', 10, 'Pallet',   NULL), -- 5
('Serena',        '2006-09-03', 2, 'Vaniville', NULL); -- 6

INSERT INTO pokemon (nome, altura, peso, lendario, tipo, fkTreinador) VALUES
('Pikachu',    0.40,   6.00, FALSE, 'Elétrico', 3),
('Charmander', 0.60,   8.50, FALSE, 'Fogo',     3),
('Squirtle',   0.50,   9.00, FALSE, 'Água',     3),
('Gyarados',   6.50, 235.00, FALSE, 'Água',     4),
('Lapras',     2.50, 220.00, FALSE, 'Água',     4),
('Arcanine',   1.90, 155.00, FALSE, 'Fogo',     5),
('Onix',       8.80, 210.00, FALSE, 'Pedra',    5),
('Gastly',     1.30,   NULL, FALSE, 'Fantasma', 5),   -- 0,1 kg -> NULL
('Haunter',    1.60,   NULL, FALSE, 'Fantasma', 6),   -- 0,1 kg -> NULL
('Machop',     0.80,  19.50, FALSE, 'Lutador',  6),
('Moltres',    2.00,  60.00, TRUE,  'Fogo',     3),
('Zapdos',     1.60,  52.60, TRUE,  'Elétrico', 4);


SELECT * FROM pokemon join treinador on idTreinador = fkTreinador;

ALTER TABLE pokemon MODIFY column lendario BOOLEAN not null;

SELECT ifnull(p.peso,'Muito leve') as peso , p.nome, t.nome FROM treinador as t
join pokemon as p on t.idTreinador = p.fkTreinador;


SELECT 





-- =====================================================================
-- 4 - TECHBUSTER (locadora)
-- cliente 1:N aluguel | produto 1:1 aluguel (UNIQUE em fkProduto:
-- um produto só pode estar vinculado a um único aluguel)
-- =====================================================================
CREATE DATABASE locadora;
USE locadora;

CREATE TABLE cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    rua VARCHAR(100),
    complemento VARCHAR(50),
    bairro VARCHAR(60),
    cidade VARCHAR(60),
    uf CHAR(2),
    telefone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE produto (
    idProduto INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(80) NOT NULL,
    anoLancamento INT,
    tipo VARCHAR(5),
    genero VARCHAR(30),
    plataforma VARCHAR(30),
    preco DECIMAL(6,2),
    condicaoProduto VARCHAR(30),
    CONSTRAINT chkTipoProduto CHECK (tipo IN ('jogo', 'filme'))
);

CREATE TABLE aluguel (
    idAluguel INT PRIMARY KEY AUTO_INCREMENT,
    fkCliente INT NOT NULL,
    fkProduto INT NOT NULL UNIQUE,
    dataRetirada DATE NOT NULL,
    dataDevolucao DATE,
    CONSTRAINT fkAluguelCliente FOREIGN KEY (fkCliente) REFERENCES cliente(idCliente),
    CONSTRAINT fkAluguelProduto FOREIGN KEY (fkProduto) REFERENCES produto(idProduto)
);

INSERT INTO cliente (nome, rua, complemento, bairro, cidade, uf, telefone, email) VALUES
('Ana Paula Reis',  'Rua Augusta, 1500',       'Apto 32',  'Consolação',   'São Paulo', 'SP', '11991110001', 'ana.reis@email.com'),
('Bruno Tavares',   'Rua Vergueiro, 800',      NULL,       'Liberdade',    'São Paulo', 'SP', '11991110002', 'bruno.tavares@email.com'),
('Carla Duarte',    'Avenida Brasil, 230',     'Casa 2',   'Jardins',      'São Paulo', 'SP', '11991110003', 'carla.duarte@email.com'),
('Daniel Freitas',  'Rua das Flores, 45',      NULL,       'Centro',       'Campinas',  'SP', '19991110004', 'daniel.freitas@email.com'),
('Elisa Monteiro',  'Rua do Catete, 310',      'Bloco B',  'Catete',       'Rio de Janeiro', 'RJ', '21991110005', 'elisa.monteiro@email.com'),
('Fábio Cardoso',   'Avenida Sete, 1020',      NULL,       'Barra',        'Salvador',  'BA', '71991110006', 'fabio.cardoso@email.com'),
('Gabriela Prado',  'Rua Oscar Freire, 900',   'Apto 101', 'Pinheiros',    'São Paulo', 'SP', '11991110007', 'gabriela.prado@email.com'); -- sem aluguel

INSERT INTO produto (titulo, anoLancamento, tipo, genero, plataforma, preco, condicaoProduto) VALUES
('Super Mario World',     1990, 'jogo',  'Plataforma', 'Super Nintendo', 12.00, 'Original'),
('Mortal Kombat II',      1993, 'jogo',  'Luta',       'Mega Drive',     18.00, 'Original'),
('International Superstar Soccer', 1994, 'jogo', 'Esporte', 'Super Nintendo', 16.50, 'Versão Premium'),
('FIFA 98',               1997, 'jogo',  'Esporte',    'PlayStation',    14.00, 'Original'),
('Metal Gear Solid',      1998, 'jogo',  'Ação',       'PlayStation',    20.00, 'Versão Premium'),
('Mario Kart 64',         1996, 'jogo',  'Corrida',    'Nintendo 64',    17.00, 'Original'),
('Matrix',                1999, 'filme', 'Ficção',     'DVD',            10.00, 'Edição de Colecionador'),
('De Volta para o Futuro',1985, 'filme', 'Aventura',   'VHS',             8.00, 'Original'),
('Jurassic Park',         1993, 'filme', 'Aventura',   'VHS',             9.00, 'Original'),
('Tony Hawk Pro Skater',  1999, 'jogo',  'Esporte',    'PlayStation',    15.50, 'Original');   -- não alugado

INSERT INTO aluguel (fkCliente, fkProduto, dataRetirada, dataDevolucao) VALUES
(1, 2, '2026-09-01', '2026-09-05'),
(1, 7, '2026-09-10', '2026-09-12'),
(2, 3, '2026-09-15', '2026-09-20'),
(3, 5, '2026-10-01', NULL),           -- em aberto
(4, 6, '2026-10-03', '2026-10-08'),
(5, 4, '2026-10-05', NULL),           -- em aberto
(6, 8, '2026-10-10', '2026-10-13'),
(2, 1, '2026-10-12', NULL);           -- em aberto


-- =====================================================================
-- 5 - HOGWARTS
-- casa 1:N aluno (aluno começa sem casa -> fkCasa NULL)
-- aluno monitor 1:N aluno (recursivo)
-- =====================================================================
CREATE DATABASE hogwarts;
USE hogwarts;

CREATE TABLE casa (
    idCasa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    fundador VARCHAR(50),
    professorResponsavel VARCHAR(50)
);

CREATE TABLE aluno (
    ra VARCHAR(5) PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    jogadorQuadribol VARCHAR(3),
    dtInicio DATE,
    dtTermino DATE,
    pet VARCHAR(40),       -- ajudante opcional
    patrono VARCHAR(40),   -- ajudante opcional
    fkCasa INT,            -- NULL até a Cerimônia de Seleção
    fkMonitor VARCHAR(5),  -- RA do aluno monitor
    CONSTRAINT chkQuadribol CHECK (jogadorQuadribol IN ('sim', 'não')),
    CONSTRAINT fkAlunoCasa FOREIGN KEY (fkCasa) REFERENCES casa(idCasa),
    CONSTRAINT fkAlunoMonitor FOREIGN KEY (fkMonitor) REFERENCES aluno(ra)
);

INSERT INTO casa (nome, fundador, professorResponsavel) VALUES
('Grifinória', 'Godric Gryffindor', 'Minerva McGonagall'),
('Sonserina',  'Salazar Slytherin', 'Severo Snape'),
('Corvinal',   'Rowena Ravenclaw',  'Fílio Flitwick'),
('Lufa-Lufa',  'Helga Hufflepuff',  'Pomona Sprout');

-- Alunos entram sem casa e sem monitor (exercícios 5, 8 e 12 fazem os vínculos)
INSERT INTO aluno (ra, nome, jogadorQuadribol, dtInicio, dtTermino, pet, patrono) VALUES
('A0001', 'Harry Potter',       'sim', '1991-09-01', '1998-06-30', 'Edwiges (coruja)',     'Cervo'),
('A0002', 'Hermione Granger',   'não', '1991-09-01', '1998-06-30', 'Bichento (gato)',      'Lontra'),
('A0003', 'Rony Weasley',       'sim', '1991-09-01', '1998-06-30', 'Perebas (rato)',       'Jack Russell Terrier'),
('A0004', 'Draco Malfoy',       'sim', '1991-09-01', '1998-06-30', 'Coruja-real',          NULL),
('A0005', 'Neville Longbottom', 'não', '1991-09-01', '1998-06-30', 'Trevo (sapo)',         NULL),
('A0006', 'Luna Lovegood',      'não', '1992-09-01', '1999-06-30', NULL,                   'Lebre'),
('A0007', 'Gina Weasley',       'sim', '1992-09-01', '1999-06-30', 'Arnaldo (mini-pufe)',  'Cavalo'),
('A0008', 'Cedrico Diggory',    'sim', '1989-09-01', '1995-06-30', NULL,                   NULL),
('A0009', 'Cho Chang',          'sim', '1990-09-01', '1997-06-30', NULL,                   'Cisne'),
('A0010', 'Ana Abbott',         'não', '1991-09-01', '1998-06-30', NULL,                   NULL),
('A0011', 'Percy Weasley',      'não', '1987-09-01', '1994-06-30', 'Hermes (coruja)',      NULL),
('A0012', 'Penélope Clearwater','não', '1987-09-01', '1994-06-30', NULL,                   NULL),
('A0013', 'Gemma Farley',       'não', '1987-09-01', '1994-06-30', 'Gato preto',           NULL),
('A0014', 'Ernesto Macmillan',  'não', '1991-09-01', '1998-06-30', NULL,                   NULL);