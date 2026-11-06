-- =====================================================================
-- EXERCÍCIO 1 - Biblioteca comunitária
-- =====================================================================
DROP DATABASE pratica_10;
CREATE DATABASE pratica_10;
USE pratica_10;
 
CREATE TABLE genero (
    idGenero INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);
 
CREATE TABLE livro (
    idLivro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    anoPublicacao INT,
    numPaginas INT,
    fkGenero INT,
    constraint fkLivro_Genero foreign key (FkGenero) references genero(idGenero)
);
 
CREATE TABLE leitor (
    idLeitor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    email VARCHAR(100),
    cidade VARCHAR(60)
);
 
CREATE TABLE clube (
    idClube INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    dataCriacao DATE
);
 
CREATE TABLE participacao (
    idParticipacao INT auto_increment,
    fkLeitor INT, 
    constraint fkLeitor_part foreign key (fkLeitor) references leitor(idLeitor),
    fkClube INT, 
    constraint fkClube_part foreign key (fkClube) references clube(idClube),-- FK -> clube(idClube)
    dataIngresso DATE,
    qtdEncontros INT,
    constraint pkComposta primary key( idParticipacao, fkLeitor, fkClube)
 
);
 
INSERT INTO genero (nome) VALUES
('Romance'), ('Fantasia'), ('Ficção Científica');
 
INSERT INTO livro (titulo, anoPublicacao, numPaginas, fkGenero) VALUES
('A Casa das Marés',      2018, 320, 1),
('O Último Farol',        2012, 280, 1),
('Crônicas de Vandria',   2016, 512, 2),
('A Espada de Cristal',   2020, 448, 2),
('Ecos do Vazio',         2015, 360, 3),
('Planeta Silencioso',    2021, 298, 3),
('Noites em Lisboa',      2009, 240, 1),
('O Dragão de Gelo',      2014, 410, 2),
('Corpos Celestes',       2019, 275, 3);
 
INSERT INTO leitor (nome, email, cidade) VALUES
('Ana Souza',      'ana.souza@email.com',      'São Paulo'),
('Bruno Lima',     'bruno.lima@email.com',     'Campinas'),
('Carla Mendes',   'carla.mendes@email.com',   'São Paulo'),
('Diego Rocha',    'diego.rocha@email.com',    'Santos'),
('Elisa Martins',  'elisa.martins@email.com',  'Guarulhos'),
('Felipe Costa',   'felipe.costa@email.com',   'Osasco');   -- sem clube
 
INSERT INTO clube (nome, dataCriacao) VALUES
('Clube das Letras',       '2022-03-10'),
('Leitores da Noite',      '2023-06-01'),
('Universos Fantásticos',  '2024-01-15');
 
INSERT INTO participacao (fkLeitor, fkClube, dataIngresso, qtdEncontros) VALUES
(1, 1, '2022-04-01', 15),
(2, 1, '2022-05-12', 10),
(3, 1, '2023-01-20', 8),
(4, 1, '2023-08-05', 4),
(1, 2, '2023-07-01', 9),
(5, 2, '2023-09-10', 6),
(2, 3, '2024-02-01', 7),
(3, 3, '2024-02-15', 5),
(5, 3, '2024-03-10', 3);
 

 SELECT l.nome, c.nome, p.dataIngresso FROM participacao as p
 join clube as c on p.fkClube = c.idClube
 join leitor as l on p.fkLeitor = l.idLeitor;
 
 SELECT l.titulo, g.nome FROM livro as l
 join genero as g on l.fkGenero = g.idGenero
 WHERE l.titulo LIKE 'a%' 
 order by l.numPaginas;
 
 SELECT count(idLivro), MIN(numPaginas), MAX(numPaginas), TRUNCATE(AVG(numPaginas),2) FROM li vro;
 
-- =====================================================================
-- EXERCÍCIO 2 - Academia
-- =====================================================================
DROP DATABASE IF EXISTS exercicio02;
CREATE DATABASE exercicio02;
USE exercicio02;
 
CREATE TABLE nivelIntensidade (
    idNivel INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);
 
CREATE TABLE modalidade (
    idModalidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    fkNivel INT -- FK -> nivelIntensidade(idNivel)
 
);
 
CREATE TABLE aluno (
    idAluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    dtNascimento DATE,
    email VARCHAR(100)
);
 
CREATE TABLE instrutor (
    idInstrutor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    valorAula DECIMAL(8,2)
);
 
CREATE TABLE aula (
    idAula INT PRIMARY KEY AUTO_INCREMENT,
    fkInstrutor INT,  -- FK -> instrutor(idInstrutor)
    fkModalidade INT, -- FK -> modalidade(idModalidade)
    diaSemana VARCHAR(15),
    duracaoMin INT
 
);
 
CREATE TABLE matricula (
    idMatricula INT PRIMARY KEY AUTO_INCREMENT,
    fkAluno INT,      -- FK -> aluno(idAluno)
    fkModalidade INT, -- FK -> modalidade(idModalidade)
    dtMatricula DATE
 
);
 
INSERT INTO nivelIntensidade (descricao) VALUES
('Leve'), ('Moderado'), ('Intenso');
 
INSERT INTO modalidade (nome, fkNivel) VALUES
('Yoga', 1),
('Pilates', 1),
('Musculação', 2),
('Spinning', 3),
('Crossfit', 3);
 
INSERT INTO aluno (nome, dtNascimento, email) VALUES
('Lucas Pereira',    '2000-03-15', 'lucas.pereira@email.com'),
('Mariana Alves',    '1998-07-22', 'mariana.alves@email.com'),
('Gustavo Ramos',    '2002-11-05', 'gustavo.ramos@email.com'),
('Juliana Freitas',  '1995-01-30', 'juliana.freitas@email.com'),
('Rodrigo Nunes',    '2001-09-12', 'rodrigo.nunes@email.com'),
('Beatriz Carvalho', '1999-05-18', 'beatriz.carvalho@email.com'),
('Thiago Moreira',   '2003-02-25', 'thiago.moreira@email.com'),   -- sem matrícula
('Larissa Teixeira', '1997-12-08', 'larissa.teixeira@email.com'); -- sem matrícula
 
INSERT INTO instrutor (nome, valorAula) VALUES
('Rafael Torres',   80.00),
('Camila Duarte',   70.00),
('Bruno Siqueira',  90.00),
('Fernanda Lopes',  65.00);
 
INSERT INTO aula (fkInstrutor, fkModalidade, diaSemana, duracaoMin) VALUES
(1, 3, 'Segunda', 60),
(1, 3, 'Quarta',  60),
(1, 5, 'Sexta',   50),
(2, 1, 'Terça',   60),
(2, 2, 'Quinta',  55),
(3, 5, 'Segunda', 45),
(3, 4, 'Quarta',  50),
(3, 3, 'Sábado',  90),
(4, 1, 'Sábado',  75),
(4, 2, 'Terça',   50),
(4, 4, 'Sexta',   45);
 
INSERT INTO matricula (fkAluno, fkModalidade, dtMatricula) VALUES
(1, 3, '2026-01-10'),
(2, 3, '2026-01-15'),
(3, 3, '2026-02-01'),
(4, 3, '2026-02-10'),
(5, 3, '2026-03-05'),
(1, 5, '2026-01-20'),
(2, 5, '2026-02-12'),
(6, 5, '2026-03-01'),
(3, 5, '2026-03-15'),
(4, 1, '2026-02-20'),
(6, 1, '2026-04-02'),
(5, 2, '2026-04-10'),
(2, 4, '2026-05-01'),
(6, 4, '2026-05-08');
 
 
-- =====================================================================
-- EXERCÍCIO 3 - Festival cultural
-- =====================================================================
DROP DATABASE IF EXISTS exercicio03;
CREATE DATABASE exercicio03;
USE exercicio03;
 
CREATE TABLE artista (
    idArtista INT PRIMARY KEY AUTO_INCREMENT,
    nomeArtistico VARCHAR(80) NOT NULL,
    paisOrigem VARCHAR(45),
    anoEstreia INT
);
 
CREATE TABLE palco (
    idPalco INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    capacidade INT
);
 
CREATE TABLE apresentacao (
    idApresentacao INT PRIMARY KEY AUTO_INCREMENT,
    dtApresentacao DATE,
    horaInicio TIME,
    duracaoMin INT,
    fkPalco INT -- FK -> palco(idPalco)
 
);
 
CREATE TABLE participacao (
    idParticipacao INT PRIMARY KEY AUTO_INCREMENT,
    fkArtista INT,      -- FK -> artista(idArtista)
    fkApresentacao INT, -- FK -> apresentacao(idApresentacao)
    cache DECIMAL(10,2)
 
);
 
INSERT INTO artista (nomeArtistico, paisOrigem, anoEstreia) VALUES
('Luna Vega',          'Espanha',  2015),
('Banda Maré Alta',    'Brasil',   2010),
('DJ Kairo',           'Angola',   2021),
('Trio Andaluz',       'Espanha',  2008),
('Mia Torres',         'México',   2019),
('The Northern Pines', 'Canadá',   2016),
('Kofi Mensah',        'Gana',     2022),
('Rita Campos',        'Portugal', 2012);
 
INSERT INTO palco (nome, capacidade) VALUES
('Palco Principal',   20000),
('Palco Sunset',       8000),
('Palco Eletrônico',   5000),
('Palco Acústico',     1500),
('Palco Alternativo',  3000); -- sem apresentações
 
INSERT INTO apresentacao (dtApresentacao, horaInicio, duracaoMin, fkPalco) VALUES
('2026-07-10', '18:00:00', 60, 1),
('2026-07-10', '20:00:00', 90, 1),
('2026-07-11', '19:00:00', 75, 1),
('2026-07-11', '21:30:00', 90, 1),
('2026-07-12', '20:00:00', 80, 1),
('2026-07-10', '16:00:00', 60, 2),
('2026-07-11', '16:30:00', 50, 2),
('2026-07-12', '17:00:00', 60, 2),
('2026-07-12', '18:30:00', 70, 2),
('2026-07-11', '23:00:00', 120, 3),
('2026-07-12', '23:30:00', 120, 3),
('2026-07-10', '15:00:00', 45, 4);
 
INSERT INTO participacao (fkArtista, fkApresentacao, cache) VALUES
(2, 1, 6000.00), (6, 1, 3500.00),
(1, 2, 4000.00),
(4, 3, 3000.00), (8, 3, 2500.00),
(2, 4, 5500.00),
(6, 5, 3800.00), (5, 5, 2800.00), (1, 5, 1500.00),
(1, 6, 4500.00),
(8, 7, 2000.00), (5, 7, 2200.00),
(4, 8, 3200.00),
(6, 9, 3600.00), (2, 9, 1800.00),
(3, 10, 2500.00), (7, 10, 1500.00),
(3, 11, 2800.00),
(4, 12, 1200.00), (8, 12, 900.00);
 
 
-- =====================================================================
-- EXERCÍCIO 4 - Laboratório de pesquisa
-- =====================================================================
DROP DATABASE IF EXISTS exercicio04;
CREATE DATABASE exercicio04;
USE exercicio04;
 
CREATE TABLE area (
    idArea INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(60) NOT NULL
);
 
CREATE TABLE titulacao (
    idTitulacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);
 
CREATE TABLE situacao (
    idSituacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);
 
CREATE TABLE pesquisador (
    idPesquisador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    fkArea INT,      -- FK -> area(idArea)
    fkTitulacao INT  -- FK -> titulacao(idTitulacao)
 
);
 
CREATE TABLE projeto (
    idProjeto INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    orcamentoPrevisto DECIMAL(12,2),
    dtInicio DATE,
    fkSituacao INT -- FK -> situacao(idSituacao)
 
);
 
CREATE TABLE participacao (
    idParticipacao INT PRIMARY KEY AUTO_INCREMENT,
    fkPesquisador INT, -- FK -> pesquisador(idPesquisador)
    fkProjeto INT,     -- FK -> projeto(idProjeto)
    horasDedicadas INT,
    valorHora DECIMAL(8,2)
 
);
 
INSERT INTO area (descricao) VALUES
('Biologia'), ('Química'), ('Engenharia');
 
INSERT INTO titulacao (descricao) VALUES
('Mestre'), ('Doutor'), ('Pós-doutor');
 
INSERT INTO situacao (descricao) VALUES
('Planejado'), ('Em andamento'), ('Concluído');
 
INSERT INTO pesquisador (nome, fkArea, fkTitulacao) VALUES
('Helena Prado',     1, 3),
('Marcos Vidal',     2, 2),
('Sofia Andrade',    1, 1),
('Ricardo Barros',   3, 2),
('Paula Monteiro',   2, 1),
('Eduardo Farias',   3, 3),  -- sem projeto
('Natália Rezende',  1, 2),  -- sem projeto
('Otávio Cardoso',   2, 1);  -- sem projeto
 
INSERT INTO projeto (titulo, orcamentoPrevisto, dtInicio, fkSituacao) VALUES
('Genoma Urbano',            50000.00,  '2025-03-01', 2),
('Energia Solar Flexível',   30000.00,  '2025-06-15', 2),
('Água Limpa',               20000.00,  '2024-02-10', 3),
('Robótica Agrícola',        80000.00,  '2026-12-01', 1),
('Microplásticos no Oceano', 15000.00,  '2025-09-20', 2),
('Vacinas Termoestáveis',    100000.00, '2027-01-10', 1); -- sem pesquisadores
 
INSERT INTO participacao (fkPesquisador, fkProjeto, horasDedicadas, valorHora) VALUES
(1, 1, 200,  80.00),
(2, 1, 150, 100.00),
(3, 1, 100,  60.00),
(2, 2, 120, 100.00),
(4, 2, 200,  90.00),
(5, 2,  50,  70.00),
(1, 3, 100,  80.00),
(3, 3,  80,  60.00),
(4, 4, 150,  90.00),
(5, 4, 100,  70.00),
(1, 5,  90,  80.00),
(5, 5,  60,  70.00);
 
 
-- =====================================================================
-- EXERCÍCIO 5 - Plataforma de cursos livres
-- =====================================================================
DROP DATABASE IF EXISTS exercicio05;
CREATE DATABASE exercicio05;
USE exercicio05;
 
CREATE TABLE area (
    idArea INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE especialidade (
    idEspecialidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE curso (
    idCurso INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    cargaHoraria INT,
    fkArea INT -- FK -> area(idArea)
 
);
 
CREATE TABLE estudante (
    idEstudante INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    email VARCHAR(100),
    cidade VARCHAR(60)
);
 
CREATE TABLE instrutor (
    idInstrutor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    fkEspecialidade INT -- FK -> especialidade(idEspecialidade)
 
);
 
CREATE TABLE atuacao (
    idAtuacao INT PRIMARY KEY AUTO_INCREMENT,
    fkInstrutor INT, -- FK -> instrutor(idInstrutor)
    fkCurso INT,     -- FK -> curso(idCurso)
    remuneracao DECIMAL(10,2)
 
);
 
CREATE TABLE inscricao (
    idInscricao INT PRIMARY KEY AUTO_INCREMENT,
    fkEstudante INT, -- FK -> estudante(idEstudante)
    fkCurso INT,     -- FK -> curso(idCurso)
    dtInscricao DATE,
    notaFinal DECIMAL(4,2),
    frequencia DECIMAL(5,2)
 
);
 
INSERT INTO area (nome) VALUES
('Tecnologia'), ('Negócios'), ('Design'), ('Idiomas');
 
INSERT INTO especialidade (nome) VALUES
('Desenvolvimento de Software'), ('Gestão'), ('Design Gráfico');
 
INSERT INTO curso (titulo, cargaHoraria, fkArea) VALUES
('Python para Iniciantes', 40, 1),
('Banco de Dados com SQL', 30, 1),
('Excel Avançado',         20, 2),
('Marketing Digital',      25, 2),
('UX Design',              35, 3),
('Inglês Instrumental',    40, 4); -- sem estudantes
 
INSERT INTO estudante (nome, email, cidade) VALUES
('Amanda Ribeiro',   'amanda.ribeiro@email.com',   'São Paulo'),
('Caio Fernandes',   'caio.fernandes@email.com',   'Campinas'),
('Daniela Moura',    'daniela.moura@email.com',    'Santo André'),
('Enzo Batista',     'enzo.batista@email.com',     'São Paulo'),
('Fabiana Cruz',     'fabiana.cruz@email.com',     'Sorocaba'),
('Gabriel Pinto',    'gabriel.pinto@email.com',    'Guarulhos'),
('Heloísa Barbosa',  'heloisa.barbosa@email.com',  'São Paulo'),
('Igor Castro',      'igor.castro@email.com',      'Osasco'),
('Jéssica Lopes',    'jessica.lopes@email.com',    'Santos'),
('Kauã Oliveira',    'kaua.oliveira@email.com',    'Barueri');
 
INSERT INTO instrutor (nome, fkEspecialidade) VALUES
('Marcelo Antunes', 1),
('Patrícia Gomes',  2),
('Renato Vieira',   3),
('Sabrina Melo',    1); -- sem cursos
 
INSERT INTO atuacao (fkInstrutor, fkCurso, remuneracao) VALUES
(1, 1, 3000.00),
(1, 2, 2500.00),
(1, 5, 1000.00),
(2, 3, 1800.00),
(2, 4, 2000.00),
(3, 5, 2800.00);
 
INSERT INTO inscricao (fkEstudante, fkCurso, dtInscricao, notaFinal, frequencia) VALUES
(1, 1, '2026-02-01', 8.50, 90.00),
(2, 1, '2026-02-01', 7.00, 80.00),
(3, 1, '2026-02-03', 6.00, 75.00),
(4, 1, '2026-02-05', 4.50, 85.00),
(5, 1, '2026-02-06', 9.00, 60.00),
(6, 1, '2026-02-10', NULL, NULL),
(1, 2, '2026-03-01', 9.50, 95.00),
(3, 2, '2026-03-02', 6.50, 78.00),
(7, 2, '2026-03-04', 5.50, 90.00),
(8, 2, '2026-03-05', 8.00, 70.00),
(9, 2, '2026-03-08', 7.50, 88.00),
(2, 3, '2026-04-01', 6.00, 100.00),
(4, 3, '2026-04-02', 7.00, 50.00),
(10, 3, '2026-04-05', NULL, NULL),
(5, 4, '2026-04-10', 3.50, 40.00),
(6, 4, '2026-04-12', 8.00, 82.00),
(7, 4, '2026-04-15', 6.80, 76.00),
(8, 5, '2026-05-01', 9.00, 95.00),
(9, 5, '2026-05-03', 5.00, 80.00),
(10, 5, '2026-05-04', 7.20, 65.00);
 
 
-- =====================================================================
-- EXERCÍCIO 6 - Clínicas veterinárias
-- =====================================================================
DROP DATABASE IF EXISTS exercicio06;
CREATE DATABASE exercicio06;
USE exercicio06;
 
CREATE TABLE tutor (
    idTutor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    telefone VARCHAR(20),
    cidade VARCHAR(60)
);
 
CREATE TABLE especie (
    idEspecie INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);
 
CREATE TABLE animal (
    idAnimal INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    peso DECIMAL(6,2),
    dtNascimento DATE,
    fkTutor INT,   -- FK -> tutor(idTutor)
    fkEspecie INT  -- FK -> especie(idEspecie)
 
);
 
CREATE TABLE especialidade (
    idEspecialidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE veterinario (
    idVeterinario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    fkEspecialidade INT -- FK -> especialidade(idEspecialidade)
 
);
 
CREATE TABLE situacao (
    idSituacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);
 
CREATE TABLE procedimento (
    idProcedimento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL
);
 
CREATE TABLE atendimento (
    idAtendimento INT PRIMARY KEY AUTO_INCREMENT,
    dtAtendimento DATE,
    fkSituacao INT,    -- FK -> situacao(idSituacao)
    fkAnimal INT,      -- FK -> animal(idAnimal)
    fkVeterinario INT  -- FK -> veterinario(idVeterinario)
 
);
 
CREATE TABLE atendimentoProcedimento (
    idAtendimentoProcedimento INT PRIMARY KEY AUTO_INCREMENT,
    fkAtendimento INT,  -- FK -> atendimento(idAtendimento)
    fkProcedimento INT, -- FK -> procedimento(idProcedimento)
    valorUnitario DECIMAL(10,2),
    quantidade INT
 
);
 
INSERT INTO tutor (nome, telefone, cidade) VALUES
('Cláudia Nogueira',  '(11) 98888-1111', 'São Paulo'),
('Roberto Assis',     '(11) 97777-2222', 'Santo André'),
('Vanessa Queiroz',   '(11) 96666-3333', 'São Paulo'),
('Henrique Leal',     '(19) 95555-4444', 'Campinas'),
('Tatiane Brito',     '(11) 94444-5555', 'Guarulhos'),
('Sérgio Matos',      '(13) 93333-6666', 'Santos');
 
INSERT INTO especie (nome) VALUES
('Cachorro'), ('Gato'), ('Coelho'), ('Ave');
 
INSERT INTO animal (nome, peso, dtNascimento, fkTutor, fkEspecie) VALUES
('Thor',    28.50, '2019-04-10', 1, 1),
('Mel',      4.20, '2021-08-22', 1, 2),
('Bidu',    12.00, '2018-01-15', 2, 1),
('Luna',     3.80, '2022-03-05', 3, 2),
('Pipoca',   1.90, '2023-06-18', 3, 3),
('Rex',     32.00, '2017-11-30', 4, 1),
('Nina',     5.10, '2020-09-09', 5, 2),
('Kiwi',     0.35, '2024-02-14', 5, 4),
('Paçoca',   2.10, '2023-10-01', 6, 3),  -- sem atendimentos
('Fred',     9.70, '2021-12-12', 2, 1);  -- sem atendimentos
 
INSERT INTO especialidade (nome) VALUES
('Clínica Geral'), ('Cirurgia'), ('Odontologia'), ('Animais Exóticos');
 
INSERT INTO veterinario (nome, fkEspecialidade) VALUES
('Dra. Marina Faria', 1),
('Dr. Paulo Sena',    2),
('Dra. Lívia Rangel', 3),
('Dr. André Tavares', 4);
 
INSERT INTO situacao (descricao) VALUES
('Agendado'), ('Realizado'), ('Cancelado');
 
INSERT INTO procedimento (nome) VALUES
('Consulta clínica'),
('Exame de sangue'),
('Vacinação'),
('Exame de ultrassom'),
('Castração'),
('Limpeza dentária');
 
INSERT INTO atendimento (dtAtendimento, fkSituacao, fkAnimal, fkVeterinario) VALUES
('2026-08-01', 2, 1, 1),
('2026-08-03', 2, 2, 1),
('2026-08-05', 2, 3, 2),
('2026-08-07', 3, 4, 2),
('2026-08-10', 2, 5, 3),
('2026-08-12', 2, 6, 1),
('2026-08-15', 2, 7, 4),
('2026-08-18', 1, 8, 3),
('2026-08-20', 2, 1, 2),
('2026-08-22', 2, 3, 1),
('2026-08-25', 2, 4, 3),
('2026-08-28', 3, 5, 4),
('2026-09-01', 2, 6, 2),
('2026-09-03', 2, 7, 1),  -- realizado sem procedimentos
('2026-09-05', 1, 2, 4);  -- agendado sem procedimentos
 
INSERT INTO atendimentoProcedimento (fkAtendimento, fkProcedimento, valorUnitario, quantidade) VALUES
(1, 1, 120.00, 1), (1, 2,  90.00, 1),
(2, 1, 120.00, 1), (2, 3,  80.00, 2),
(3, 5, 450.00, 1), (3, 2,  90.00, 1),
(4, 1, 120.00, 1),
(5, 6, 300.00, 1),
(6, 1, 120.00, 1), (6, 4, 150.00, 1), (6, 2, 90.00, 1),
(7, 3,  80.00, 3),
(8, 1, 120.00, 1),
(9, 4, 150.00, 1),
(10, 1, 130.00, 1), (10, 2, 95.00, 2),
(11, 6, 300.00, 1), (11, 1, 120.00, 1),
(13, 1, 120.00, 1);
 
 
-- =====================================================================
-- EXERCÍCIO 7 - Eventos acadêmicos
-- =====================================================================
DROP DATABASE IF EXISTS exercicio07;
CREATE DATABASE exercicio07;
USE exercicio07;
 
CREATE TABLE tipoParticipante (
    idTipo INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);
 
CREATE TABLE participante (
    idParticipante INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    email VARCHAR(100),
    fkTipo INT -- FK -> tipoParticipante(idTipo)
 
);
 
CREATE TABLE evento (
    idEvento INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    dtEvento DATE,
    duracaoHoras INT
);
 
CREATE TABLE tema (
    idTema INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE eventoTema (
    idEventoTema INT PRIMARY KEY AUTO_INCREMENT,
    fkEvento INT, -- FK -> evento(idEvento)
    fkTema INT   -- FK -> tema(idTema)
 
);
 
CREATE TABLE inscricao (
    idInscricao INT PRIMARY KEY AUTO_INCREMENT,
    fkParticipante INT, -- FK -> participante(idParticipante)
    fkEvento INT,       -- FK -> evento(idEvento)
    percPresenca DECIMAL(5,2) CHECK (percPresenca BETWEEN 0 AND 100),
    nota DECIMAL(4,2) NULL
 
);
 
INSERT INTO tipoParticipante (descricao) VALUES
('Aluno'), ('Professor'), ('Convidado'), ('Técnico-administrativo'); -- último sem participantes
 
INSERT INTO participante (nome, email, fkTipo) VALUES
('Alice Moreira',    'alice.moreira@email.com',    1),
('Bernardo Silva',   'bernardo.silva@email.com',   1),
('Cecília Ramos',    'cecilia.ramos@email.com',    1),
('Davi Fonseca',     'davi.fonseca@email.com',     1),
('Eduarda Pires',    'eduarda.pires@email.com',    1),
('Fábio Correia',    'fabio.correia@email.com',    1),
('Giovana Araújo',   'giovana.araujo@email.com',   1),
('Prof. Hugo Lemos', 'hugo.lemos@email.com',       2),
('Profa. Íris Dantas','iris.dantas@email.com',     2),
('Prof. Jonas Reis', 'jonas.reis@email.com',       2),
('Kátia Bastos',     'katia.bastos@email.com',     3),
('Leonardo Prates',  'leonardo.prates@email.com',  3);
 
INSERT INTO evento (titulo, dtEvento, duracaoHoras) VALUES
('Semana de Ciência de Dados',  '2026-03-10', 20),
('Workshop SQL Avançado',       '2026-04-05',  8),
('Fórum de Sustentabilidade',   '2026-04-22',  6),
('Hackathon de IA',             '2026-05-15', 24),
('Palestra Startups',           '2026-06-02',  2),
('Big Data na Saúde',           '2026-08-18',  4),
('Seminário de Inovação',       '2026-09-10',  5),  -- sem avaliações
('Mostra de Projetos',          '2026-10-20',  6);  -- sem avaliações
 
INSERT INTO tema (nome) VALUES
('Ciência de Dados'),
('Inteligência Artificial'),
('Banco de Dados'),
('Sustentabilidade'),
('Empreendedorismo'),
('Ética'); -- sem eventos
 
INSERT INTO eventoTema (fkEvento, fkTema) VALUES
(1, 1), (1, 2),
(2, 3), (2, 1),
(3, 4),
(4, 2), (4, 5),
(5, 5),
(6, 1), (6, 3), (6, 4),
(7, 5), (7, 2),
(8, 4), (8, 5);
 
INSERT INTO inscricao (fkParticipante, fkEvento, percPresenca, nota) VALUES
(1, 1, 100.00, 9.50),
(2, 1,  90.00, 9.00),
(3, 1,  85.00, 8.50),
(4, 1, 100.00, 9.00),
(5, 1,  80.00, NULL),
(6, 1,  95.00, 8.00),
(1, 2,  75.00, 7.00),
(7, 2,  60.00, 6.50),
(8, 2, 100.00, 8.00),
(9, 2,   0.00, NULL),
(2, 3, 100.00, 9.00),
(10, 3, 50.00, NULL),
(11, 3, 80.00, 7.50),
(3, 4,  90.00, 9.00),
(4, 4,  85.00, 8.50),
(7, 4, 100.00, 9.50),
(8, 4,  95.00, 9.00),
(12, 4, 70.00, 8.00),
(5, 5,   0.00, NULL),
(6, 5,  60.00, 7.00),
(1, 6, 100.00, 10.00),
(9, 6,  80.00, 8.00),
(10, 6, 90.00, 7.00),
(11, 6,  0.00, NULL),
(2, 7, 100.00, NULL),
(12, 7, 85.00, NULL),
(8, 7,   0.00, NULL),
(3, 8,  70.00, NULL);
 
 
-- =====================================================================
-- EXERCÍCIO 8 - Organização ambiental
-- =====================================================================
DROP DATABASE IF EXISTS exercicio08;
CREATE DATABASE exercicio08;
USE exercicio08;
 
CREATE TABLE regiao (
    idRegiao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);
 
CREATE TABLE situacao (
    idSituacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);
 
CREATE TABLE areaAtuacao (
    idArea INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE setor (
    idSetor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE projeto (
    idProjeto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    orcamento DECIMAL(12,2),
    fkRegiao INT,   -- FK -> regiao(idRegiao)
    fkSituacao INT  -- FK -> situacao(idSituacao)
 
);
 
CREATE TABLE voluntario (
    idVoluntario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    cidade VARCHAR(60),
    fkArea INT -- FK -> areaAtuacao(idArea)
 
);
 
CREATE TABLE instituicao (
    idInstituicao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    fkSetor INT -- FK -> setor(idSetor)
 
);
 
CREATE TABLE participacao (
    idParticipacao INT PRIMARY KEY AUTO_INCREMENT,
    fkVoluntario INT, -- FK -> voluntario(idVoluntario)
    fkProjeto INT,    -- FK -> projeto(idProjeto)
    horasTrabalhadas INT,
    dtIngresso DATE
 
);
 
CREATE TABLE apoio (
    idApoio INT PRIMARY KEY AUTO_INCREMENT,
    fkInstituicao INT, -- FK -> instituicao(idInstituicao)
    fkProjeto INT,     -- FK -> projeto(idProjeto)
    valor DECIMAL(12,2),
    dtContribuicao DATE
 
);
 
INSERT INTO regiao (nome) VALUES
('Sudeste'), ('Sul'), ('Nordeste'), ('Norte'), ('Centro-Oeste');
 
INSERT INTO situacao (descricao) VALUES
('Planejado'), ('Ativo'), ('Finalizado');
 
INSERT INTO areaAtuacao (nome) VALUES
('Biologia'), ('Educação Ambiental'), ('Logística'), ('Comunicação');
 
INSERT INTO setor (nome) VALUES
('Privado'), ('Público'), ('Terceiro Setor');
 
INSERT INTO projeto (nome, orcamento, fkRegiao, fkSituacao) VALUES
('Reflorestamento Mata Atlântica', 120000.00, 1, 2),
('Limpeza de Praias',               40000.00, 3, 2),
('Proteção do Pantanal',            90000.00, 5, 2),
('Nascentes Vivas',                 30000.00, 2, 3),
('Amazônia Sustentável',           200000.00, 4, 2),
('Hortas Urbanas',                  15000.00, 1, 1),  -- sem apoio
('Mangue Vivo',                     25000.00, 3, 1),  -- sem apoio
('Araucárias do Sul',               50000.00, 2, 2);
 
INSERT INTO voluntario (nome, cidade, fkArea) VALUES
('Aline Barreto',   'São Paulo',     1),
('Bruno Galvão',    'Recife',        2),
('Carolina Dias',   'Curitiba',      1),
('Douglas Faria',   'Manaus',        3),
('Estela Ramos',    'Salvador',      4),
('Fernando Luz',    'Campo Grande',  1),
('Gisele Prado',    'Porto Alegre',  2),
('Henrique Sales',  'Florianópolis', 3),
('Isabela Neves',   'Belo Horizonte',4),  -- sem participação
('João Vitor Paz',  'Belém',         1);  -- sem participação
 
INSERT INTO instituicao (nome, fkSetor) VALUES
('Banco Verde S.A.',         1),
('Fundação Terra Viva',      3),
('Secretaria do Meio Ambiente', 2),
('Instituto Raízes',         3),
('EcoIndústria Ltda.',       1);
 
INSERT INTO participacao (fkVoluntario, fkProjeto, horasTrabalhadas, dtIngresso) VALUES
(1, 1, 40, '2026-01-10'),
(2, 1, 35, '2026-01-15'),
(3, 1, 30, '2026-02-01'),
(4, 2, 20, '2026-02-10'),
(5, 2, 25, '2026-02-12'),
(1, 3, 50, '2026-03-01'),
(6, 3, 30, '2026-03-05'),
(7, 3, 40, '2026-03-10'),
(2, 4, 60, '2025-06-01'),
(8, 4, 45, '2025-06-15'),
(3, 5, 80, '2026-04-01'),
(4, 5, 30, '2026-04-05'),
(5, 5, 20, '2026-04-10'),
(6, 6, 10, '2026-10-01'),
(7, 8, 25, '2026-05-01'),
(8, 8, 15, '2026-05-10');
 
INSERT INTO apoio (fkInstituicao, fkProjeto, valor, dtContribuicao) VALUES
(1, 1, 50000.00, '2026-01-05'),
(2, 1, 40000.00, '2026-01-20'),
(3, 1, 30000.00, '2026-02-15'),
(1, 2, 15000.00, '2026-02-01'),
(4, 2, 10000.00, '2026-02-20'),
(2, 3, 60000.00, '2026-03-01'),
(3, 4, 30000.00, '2025-05-10'),
(5, 4,  5000.00, '2025-06-01'),
(4, 5, 80000.00, '2026-03-20'),
(5, 5, 50000.00, '2026-04-01'),
(1, 8, 20000.00, '2026-04-25'),
(2, 8, 10000.00, '2026-05-05');
 
 
-- =====================================================================
-- EXERCÍCIO 9 - Estúdio de jogos
-- =====================================================================
DROP DATABASE IF EXISTS exercicio09;
CREATE DATABASE exercicio09;
USE exercicio09;
 
CREATE TABLE genero (
    idGenero INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);
 
CREATE TABLE situacao (
    idSituacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);
 
CREATE TABLE especialidade (
    idEspecialidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE nivelExperiencia (
    idNivel INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);
 
CREATE TABLE jogo (
    idJogo INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    orcamento DECIMAL(12,2),
    fkGenero INT,   -- FK -> genero(idGenero)
    fkSituacao INT  -- FK -> situacao(idSituacao)
 
);
 
CREATE TABLE desenvolvedor (
    idDesenvolvedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    valorHora DECIMAL(8,2),
    fkEspecialidade INT -- FK -> especialidade(idEspecialidade)
 
);
 
CREATE TABLE testador (
    idTestador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    fkNivel INT -- FK -> nivelExperiencia(idNivel)
 
);
 
CREATE TABLE participacao (
    idParticipacao INT PRIMARY KEY AUTO_INCREMENT,
    fkDesenvolvedor INT, -- FK -> desenvolvedor(idDesenvolvedor)
    fkJogo INT,          -- FK -> jogo(idJogo)
    horasTrabalhadas INT
 
);
 
CREATE TABLE avaliacao (
    idAvaliacao INT PRIMARY KEY AUTO_INCREMENT,
    fkTestador INT, -- FK -> testador(idTestador)
    fkJogo INT,     -- FK -> jogo(idJogo)
    nota DECIMAL(4,2) CHECK (nota BETWEEN 0 AND 10),
    qtdProblemas INT,
    dtAvaliacao DATE,
    UNIQUE (fkTestador, fkJogo) -- no máximo uma avaliação por testador em cada jogo
 
);
 
INSERT INTO genero (nome) VALUES
('RPG'), ('Ação'), ('Corrida'), ('Simulação'), ('Aventura');
 
INSERT INTO situacao (descricao) VALUES
('Planejamento'), ('Desenvolvimento'), ('Lançado');
 
INSERT INTO especialidade (nome) VALUES
('Programação'), ('Arte 3D'), ('Game Design'), ('Áudio');
 
INSERT INTO nivelExperiencia (descricao) VALUES
('Júnior'), ('Pleno'), ('Sênior');
 
INSERT INTO jogo (titulo, orcamento, fkGenero, fkSituacao) VALUES
('Lâmina Sombria',      150000.00, 1, 3),
('Corrida Neon',         80000.00, 3, 3),
('Fazenda Feliz',        60000.00, 4, 2),
('Arena Galáctica',     120000.00, 2, 3),
('Mistério na Mansão',   40000.00, 5, 1),  -- sem avaliações
('Torre de Cristal',     50000.00, 1, 1);  -- sem avaliações e sem devs
 
INSERT INTO desenvolvedor (nome, valorHora, fkEspecialidade) VALUES
('Arthur Menezes',  120.00, 1),
('Bianca Torres',   100.00, 2),
('César Lacerda',    90.00, 3),
('Diana Coelho',     80.00, 1),
('Elias Fontes',    150.00, 1),
('Flávia Quintana',  70.00, 4),
('Gustavo Pacheco', 110.00, 2),  -- sem participação
('Helena Brandão',   95.00, 3);  -- sem participação
 
INSERT INTO testador (nome, fkNivel) VALUES
('Igor Sampaio',     3),
('Joana Viana',      2),
('Kevin Rocha',      3),
('Lorena Cavalcanti',1),
('Mateus Guerra',    2),
('Nicole Paiva',     1),
('Otávio Ramalho',   2);
 
INSERT INTO participacao (fkDesenvolvedor, fkJogo, horasTrabalhadas) VALUES
(1, 1, 500), (2, 1, 400), (5, 1, 200),
(2, 2, 300), (3, 2, 400), (4, 2, 200),
(4, 3, 300), (6, 3, 200),
(1, 4, 600), (5, 4, 300), (3, 4, 100),
(6, 5, 100);
 
INSERT INTO avaliacao (fkTestador, fkJogo, nota, qtdProblemas, dtAvaliacao) VALUES
(1, 1, 9.00,  2, '2026-03-10'),
(2, 1, 8.50,  3, '2026-03-12'),
(3, 1, 9.50,  1, '2026-03-15'),
(4, 1, 8.00,  4, '2026-03-18'),
(1, 2, 6.50,  8, '2026-04-02'),
(5, 2, 7.00,  6, '2026-04-05'),
(6, 2, 5.50, 10, '2026-04-08'),
(2, 3, 5.00, 12, '2026-06-01'),
(7, 3, 4.50, 15, '2026-06-03'),
(3, 4, 8.00,  5, '2026-07-10'),
(4, 4, 7.50,  7, '2026-07-12'),
(5, 4, 9.00,  3, '2026-07-15');
 
 
-- =====================================================================
-- EXERCÍCIO 10 - Centro de formação profissional
-- =====================================================================
DROP DATABASE IF EXISTS exercicio10;
CREATE DATABASE exercicio10;
USE exercicio10;
 
CREATE TABLE area (
    idArea INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE programa (
    idPrograma INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cargaHoraria INT,
    fkArea INT -- FK -> area(idArea)
 
);
 
-- Autorrelacionamento: fkSupervisor aponta para outro instrutor
CREATE TABLE instrutor (
    idInstrutor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    valorHora DECIMAL(8,2),
    fkSupervisor INT NULL -- FK -> instrutor(idInstrutor)
 
);
 
CREATE TABLE patrocinador (
    idPatrocinador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);
 
CREATE TABLE atuacao (
    idAtuacao INT PRIMARY KEY AUTO_INCREMENT,
    fkInstrutor INT, -- FK -> instrutor(idInstrutor)
    fkPrograma INT,  -- FK -> programa(idPrograma)
    horasMinistradas INT,
    notaDesempenho DECIMAL(4,2) CHECK (notaDesempenho BETWEEN 0 AND 10)
 
);
 
CREATE TABLE patrocinio (
    idPatrocinio INT PRIMARY KEY AUTO_INCREMENT,
    fkPrograma INT,     -- FK -> programa(idPrograma)
    fkPatrocinador INT, -- FK -> patrocinador(idPatrocinador)
    valor DECIMAL(12,2)
 
);
 
INSERT INTO area (nome) VALUES
('Tecnologia da Informação'), ('Gestão'), ('Indústria');
 
INSERT INTO programa (nome, cargaHoraria, fkArea) VALUES
('Desenvolvimento Web',        40, 1),
('Liderança e Gestão',         60, 2),
('Automação Industrial',       30, 3),
('Análise de Dados',           80, 1),
('Segurança do Trabalho',      50, 3),  -- sem patrocinador
('Atendimento ao Cliente',     20, 2);  -- sem patrocinador
 
-- supervisores primeiro (sem supervisor), depois os subordinados
INSERT INTO instrutor (nome, valorHora, fkSupervisor) VALUES
('Márcia Valente',   150.00, NULL),  -- 1
('Roberto Quadros',  140.00, NULL),  -- 2
('Sílvia Arantes',   100.00, 1),     -- 3
('Tiago Bezerra',     90.00, 1),     -- 4
('Úrsula Campos',     85.00, 1),     -- 5
('Vítor Medeiros',    80.00, 2),     -- 6
('Wesley Rangel',     75.00, 2),     -- 7
('Yasmin Toledo',     70.00, 3);     -- 8 (sem atuação; supervisora 3 tem subordinado sem programas)
 
INSERT INTO patrocinador (nome) VALUES
('TechNova'), ('Grupo Horizonte'), ('Indústrias Atlas'), ('Banco Futuro');
 
INSERT INTO atuacao (fkInstrutor, fkPrograma, horasMinistradas, notaDesempenho) VALUES
(3, 1, 25, 8.50),
(4, 1, 20, 9.00),
(1, 2, 30, 9.50),
(5, 2, 20, 7.50),
(6, 3, 20, 8.00),
(7, 3, 15, 7.00),
(3, 3,  5, 9.00),
(2, 4, 40, 9.00),
(4, 4, 30, 8.00),
(5, 5, 30, 6.50),
(6, 5, 25, 7.50),
(7, 6, 10, 8.50);
 
INSERT INTO patrocinio (fkPrograma, fkPatrocinador, valor) VALUES
(1, 1,  3000.00),
(1, 2,  2000.00),
(2, 3,  4000.00),
(3, 1,  1500.00),
(3, 4,  1000.00),
(4, 2, 10000.00);
 
 
-- =====================================================================
-- EXERCÍCIO 11 - Pesquisa clínica hospitalar
-- =====================================================================
DROP DATABASE IF EXISTS exercicio11;
CREATE DATABASE exercicio11;
USE exercicio11;
 
CREATE TABLE situacao (
    idSituacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);
 
CREATE TABLE especialidade (
    idEspecialidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE categoria (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE projeto (
    idProjeto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    orcamento DECIMAL(12,2),
    dtInicio DATE,
    fkSituacao INT -- FK -> situacao(idSituacao)
 
);
 
CREATE TABLE profissional (
    idProfissional INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    valorHora DECIMAL(8,2),
    fkEspecialidade INT -- FK -> especialidade(idEspecialidade)
 
);
 
CREATE TABLE equipamento (
    idEquipamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    custoHora DECIMAL(8,2),
    fkCategoria INT -- FK -> categoria(idCategoria)
 
);
 
CREATE TABLE participacao (
    idParticipacao INT PRIMARY KEY AUTO_INCREMENT,
    fkProfissional INT, -- FK -> profissional(idProfissional)
    fkProjeto INT,      -- FK -> projeto(idProjeto)
    horasDedicadas INT
 
);
 
CREATE TABLE utilizacao (
    idUtilizacao INT PRIMARY KEY AUTO_INCREMENT,
    fkEquipamento INT, -- FK -> equipamento(idEquipamento)
    fkProjeto INT,     -- FK -> projeto(idProjeto)
    horasUso INT,
    qtdSessoes INT
 
);
 
INSERT INTO situacao (descricao) VALUES
('Planejado'), ('Em andamento'), ('Concluído');
 
INSERT INTO especialidade (nome) VALUES
('Cardiologia'), ('Genética'), ('Neurologia'), ('Enfermagem'), ('Farmácia');
 
INSERT INTO categoria (nome) VALUES
('Imagem'), ('Laboratório'), ('Monitoramento');
 
INSERT INTO projeto (nome, orcamento, dtInicio, fkSituacao) VALUES
('Pesquisa de Biomarcadores Cardíacos', 80000.00,  '2025-02-01', 2),
('Pesquisa em Terapia Gênica',          150000.00, '2025-05-10', 2),
('Estudo de Reabilitação Pós-AVC',       40000.00, '2024-03-15', 3),
('Pesquisa de Novos Antibióticos',       60000.00, '2025-09-01', 2),
('Ensaio Clínico Diabetes Tipo 2',       30000.00, '2026-12-01', 1),  -- sem equipamentos
('Pesquisa sobre Sono e Memória',        20000.00, '2024-06-20', 3),
('Avaliação de Telemedicina',            10000.00, '2027-01-15', 1);  -- sem participações e utilizações
 
INSERT INTO profissional (nome, valorHora, fkEspecialidade) VALUES
('Dr. Alberto Neves',    200.00, 1),
('Dra. Bruna Salles',    180.00, 2),
('Dr. Caio Moraes',      160.00, 3),
('Enf. Denise Prado',     90.00, 4),
('Farm. Emílio Duarte',  120.00, 5),
('Dra. Fátima Rios',     190.00, 1),
('Enf. Gilberto Lins',    85.00, 4),
('Dr. Hélio Vasques',    170.00, 2),
('Dra. Ingrid Matos',    150.00, 3),  -- sem projeto
('Farm. Júlio Araújo',   110.00, 5);  -- sem projeto
 
INSERT INTO equipamento (nome, custoHora, fkCategoria) VALUES
('Ressonância Magnética',     500.00, 1),
('Tomógrafo',                 400.00, 1),
('Ultrassom',                 150.00, 1),
('Sequenciador de DNA',       350.00, 2),
('Centrífuga',                 50.00, 2),
('Microscópio Eletrônico',    300.00, 2),
('Monitor Multiparamétrico',   40.00, 3),  -- não utilizado
('Polissonógrafo',            120.00, 3);
 
INSERT INTO participacao (fkProfissional, fkProjeto, horasDedicadas) VALUES
(1, 1, 120), (4, 1, 200), (6, 1, 80),
(2, 2, 300), (8, 2, 250), (4, 2, 100),
(3, 3, 150), (7, 3, 180),
(5, 4, 200), (2, 4, 100), (7, 4, 60),
(6, 5, 50),
(3, 6, 80),  (4, 6, 50);
 
INSERT INTO utilizacao (fkEquipamento, fkProjeto, horasUso, qtdSessoes) VALUES
(1, 1, 10,  5),
(3, 1, 20, 10),
(5, 1, 15,  6),
(4, 2, 30, 12),
(5, 2, 20,  8),
(6, 2, 10,  4),
(2, 3,  5,  3),
(5, 4, 10,  5),
(6, 4,  5,  2),
(8, 6, 30, 15),
(1, 6,  4,  2);
 
 
-- =====================================================================
-- EXERCÍCIO 12 - Missões humanitárias
-- =====================================================================
DROP DATABASE IF EXISTS exercicio12;
CREATE DATABASE exercicio12;
USE exercicio12;
 
CREATE TABLE pais (
    idPais INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE situacao (
    idSituacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);
 
CREATE TABLE especialidade (
    idEspecialidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE area (
    idArea INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);
 
CREATE TABLE missao (
    idMissao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    orcamentoPrevisto DECIMAL(12,2),
    fkPais INT,     -- FK -> pais(idPais)
    fkSituacao INT  -- FK -> situacao(idSituacao)
 
);
 
-- Autorrelacionamento: fkCoordenador aponta para outro profissional
CREATE TABLE profissional (
    idProfissional INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    custoHora DECIMAL(8,2),
    fkEspecialidade INT,      -- FK -> especialidade(idEspecialidade)
    fkCoordenador INT NULL    -- FK -> profissional(idProfissional)
 
);
 
CREATE TABLE organizacao (
    idOrganizacao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    fkPais INT -- FK -> pais(idPais)
 
);
 
CREATE TABLE participacao (
    idParticipacao INT PRIMARY KEY AUTO_INCREMENT,
    fkProfissional INT, -- FK -> profissional(idProfissional)
    fkMissao INT,       -- FK -> missao(idMissao)
    horasTrabalhadas INT,
    notaDesempenho DECIMAL(4,2) CHECK (notaDesempenho BETWEEN 0 AND 10)
 
);
 
CREATE TABLE financiamento (
    idFinanciamento INT PRIMARY KEY AUTO_INCREMENT,
    fkOrganizacao INT, -- FK -> organizacao(idOrganizacao)
    fkMissao INT,      -- FK -> missao(idMissao)
    valorRepassado DECIMAL(12,2),
    dtContribuicao DATE
 
);
 
CREATE TABLE missaoArea (
    idMissaoArea INT PRIMARY KEY AUTO_INCREMENT,
    fkMissao INT, -- FK -> missao(idMissao)
    fkArea INT   -- FK -> area(idArea)
 
);
 
INSERT INTO pais (nome) VALUES
('Brasil'), ('Haiti'), ('Moçambique'), ('Síria'),
('Bangladesh'), ('Suíça'), ('Estados Unidos'), ('Noruega');
 
INSERT INTO situacao (descricao) VALUES
('Planejada'), ('Em andamento'), ('Concluída');
 
INSERT INTO especialidade (nome) VALUES
('Medicina'), ('Enfermagem'), ('Engenharia'), ('Educação'), ('Logística');
 
INSERT INTO area (nome) VALUES
('Saúde'), ('Educação'), ('Infraestrutura'), ('Saneamento'), ('Nutrição');
 
INSERT INTO missao (nome, orcamentoPrevisto, fkPais, fkSituacao) VALUES
('Saúde no Haiti',               200000.00, 2, 3),
('Escolas em Moçambique',        150000.00, 3, 3),
('Água Potável na Síria',        180000.00, 4, 2),
('Abrigos em Bangladesh',        120000.00, 5, 3),
('Vacinação na Amazônia',         90000.00, 1, 2),
('Reconstrução do Haiti',        250000.00, 2, 1),  -- sem financiamento e participação
('Nutrição Infantil Moçambique',  80000.00, 3, 3),
('Capacitação Médica na Síria',  100000.00, 4, 1);  -- sem financiamento e participação
 
-- coordenadores primeiro (sem coordenador), depois os subordinados
INSERT INTO profissional (nome, custoHora, fkEspecialidade, fkCoordenador) VALUES
('Ana Ribeiro',     150.00, 1, NULL),  -- 1
('Carlos Mendes',   120.00, 3, NULL),  -- 2
('Júlia Santos',     80.00, 2, 1),     -- 3
('Pedro Alves',     140.00, 1, 1),     -- 4
('Mariana Costa',    70.00, 4, 1),     -- 5
('Lucas Ferreira',  110.00, 3, 2),     -- 6
('Beatriz Lima',     60.00, 5, 2),     -- 7
('Rafael Souza',     75.00, 2, NULL),  -- 8
('Camila Rocha',     65.00, 4, 2),     -- 9
('Thiago Martins',   90.00, 5, 4),     -- 10
('Larissa Dias',     85.00, 2, 8),     -- 11 (sem participação)
('Gabriel Nunes',   100.00, 3, 8);     -- 12 (sem participação)
 
INSERT INTO organizacao (nome, fkPais) VALUES
('Médicos Unidos',        6),
('Fundação Aurora',       7),
('Aliança Global',        8),
('Instituto Esperança',   1),
('Rede Solidária',        6),
('Mãos Dadas',            8);
 
INSERT INTO participacao (fkProfissional, fkMissao, horasTrabalhadas, notaDesempenho) VALUES
(1, 1, 200, 9.50), (3, 1, 300, 8.50), (4, 1, 150, 9.00),
(5, 2, 250, 8.00), (9, 2, 200, 7.50), (2, 2, 100, 8.50),
(2, 3, 180, 9.00), (6, 3, 220, 8.00), (7, 3, 150, 7.00),
(6, 4, 160, 8.50), (7, 4, 200, 9.00), (10, 4, 120, 7.50),
(3, 5, 100, 9.00), (4, 5,  80, 8.00), (8, 5, 150, 8.50),
(1, 7, 100, 9.00), (5, 7, 120, 8.50), (10, 7, 90, 8.00);
 
INSERT INTO financiamento (fkOrganizacao, fkMissao, valorRepassado, dtContribuicao) VALUES
(1, 1, 50000.00, '2025-01-15'),
(1, 4, 30000.00, '2025-03-10'),
(1, 5, 20000.00, '2026-02-01'),
(1, 7, 15000.00, '2025-08-20'),
(2, 1, 40000.00, '2025-01-30'),
(2, 2, 25000.00, '2025-04-12'),
(2, 3, 60000.00, '2026-01-05'),
(3, 2, 10000.00, '2025-05-01'),
(3, 3, 20000.00, '2026-02-18'),
(4, 5, 15000.00, '2026-03-03'),
(5, 4, 15000.00, '2025-03-25'),
(5, 7, 10000.00, '2025-09-02'),
(6, 1, 10000.00, '2025-02-14');
 
INSERT INTO missaoArea (fkMissao, fkArea) VALUES
(1, 1), (1, 4),
(2, 2), (2, 3),
(3, 4), (3, 3),
(4, 3), (4, 1),
(5, 1),
(6, 3),
(7, 5), (7, 1), (7, 2),
(8, 1), (8, 2);