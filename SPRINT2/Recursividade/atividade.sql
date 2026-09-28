USE sprint2;

/*Clínica Veterinária -- Relacionamento 1:1*/

/*Parte 1 -- Criar as Tabelas com Constraints*/

CREATE TABLE animal(
idAnimal int primary key auto_increment,
nome varchar(45),
especie varchar(45),
raca varchar(45),
idade int
);

CREATE TABLE ficha_medica(
idFicha int primary key auto_increment,
data_ultima_consulta date,
peso int,
vacina_em_dia tinyint,
constraint checkVacina CHECK (vacina_em_dia in(0,1)),
observacao VARCHAR(100),
fkAnimal INT UNIQUE,
constraint fkAnimalFicha Foreign key (fkAnimal) references animal(idAnimal)
);

/*Parte 2 -- Inserir Dados de Exemplo
Escreva e execute os comandos para:

Inserir pelo menos 5 animais na tabela animal.
Inserir uma ficha médica para cada animal, associando via fk_animal. Deixe pelo menos um animal sem ficha médica (para testar o LEFT JOIN depois).
Exibir todos os dados das duas tabelas com SELECT para verificar os dados inseridos.
Tentar inserir uma segunda ficha médica para o mesmo animal e observar o erro gerado pelo banco de dados.*/

INSERT INTO animal VALUES
(default,'Luna','Cachorro','Vira-lata',5),
(default,'Jorge','Porco','rosa',8),
(default,'Rume','Gato','Laranja',3),
(default,'Iris','Gato','Cinza',6),
(default,'Bob','Capivara',null,5);

INSERT INTO ficha_medica VALUES
(default,'2026-06-22', 80, 1, 'Esta muito gorda, fazer dieta',1),
(default,'2026-08-20', 100, 0, 'Ta vesgo, cirurgia',2),
(default,'2026-07-24', 30, 0, 'Quebrou a perna',3),
(default,'2026-05-01', 25, 1, 'Esta muito magro, comer mais',4),
(default,null,null, null, null ,5);


SELECT * from ficha_medica
JOIN animal on idAnimal = fkAnimal;

INSERT INTO ficha_medica VALUES
(default,'2026-08-22', 85, 1, 'Esta muito gorda, muitoo gordaaa, fazer dieta',1);

/*Parte 3 -- Consultas com SELECT
Escreva e execute os comandos para:

Exibir o nome e a especie de todos os animais.
Exibir as fichas médicas dos animais com vacina em atraso.
Exibir os animais ordenados pela idade em ordem decrescente.
Exibir apenas os animais da especie Cachorro (ou a especie que você inseriu).*/

SELECT nome,especie FROM animal;

SELECT concat(animal.nome, '  |  ',animal.especie) as Animal,
case
when vacina_em_dia = 0 then 'atrasada'
else 'vacinado'
end as VACINA
from ficha_medica
JOIN animal on fkAnimal = idAnimal;

SELECT * from animal ORDER BY idade desc;

SELECT * from animal
WHERE especie = 'Cachorro';

/*Parte 4 -- Consultas com AS (Renomear Colunas)
Escreva e execute os comandos para:

Exibir o nome do animal como 'Pet' e a especie como 'Tipo'.
Exibir o peso da ficha médica como 'Peso (kg)' e a data_ultima_consulta como 'Ultima Consulta'.
Exibir a idade multiplicada por 7 como 'Idade Humana Aproximada' para cada animal.
Exibir o nome do animal e a raca, renomeando para 'Nome do Pet' e 'Raca/Tipo'.*/

SELECT nome AS PET, especie AS TIPO from animal;

SELECT ficha_medica.peso AS PESO_KG, ficha_medica.data_ultima_consulta AS ULTIMA_CONSULTA from ficha_medica;

SELECT idade * 7 AS IDADE_HUMANA, nome AS PET from animal;

SELECT nome AS NOME_DO_PET, raca AS raca_tipo from animal;

/*Parte 5 -- Consultas com CASE
Escreva e execute os comandos para:

Exibir o nome do animal e uma coluna 'fase_vida' usando CASE: animais com menos de 2 anos devem exibir 'Filhote', entre 2 e 7 anos devem exibir 'Adulto', e os demais devem exibir 'Idoso'.
Exibir o nome do animal e uma coluna 'vacinacao' (usando JOIN com ficha_medica): quando a vacina estiver em dia, exibir 'Vacinado'; caso contrario, exibir 'Pendente'.
Exibir o peso e uma coluna 'porte': animais com menos de 5 kg devem exibir 'Pequeno', entre 5 kg e 20 kg devem exibir 'Médio', e os demais devem exibir 'Grande'.
Exibir o nome do animal e uma coluna 'especie_tipo': Cachorros devem exibir 'Canino', Gatos devem exibir 'Felino', e os demais devem exibir 'Outro'.*/

SELECT *,
case
	when idade < 2 then 'FILHOTE'
    when idade < 7 then 'ADULTO'
    else 'IDOSO'
end as fase 
FROM animal;

SELECT animal.nome as PET,
case
when vacina_em_dia = 0 then 'PENDENTE'
else 'VACINADO'
end as Vacinacao
from ficha_medica
JOIN animal on fkAnimal = idAnimal;

/*Parte 6 -- Consultas com IFNULL e JOIN
Escreva e execute os comandos para:

Exibir o nome do animal e substituir o campo observacao nulo por 'Nenhuma observação' (usando JOIN com ficha_medica).
Fazer um LEFT JOIN entre animal e ficha_medica e substituir a data da ultima consulta por 'SEM FICHA' quando o animal não tiver ficha médica.
Fazer um INNER JOIN entre animal e ficha_medica para exibir o nome do animal, o peso e a data da ultima consulta.
Fazer um INNER JOIN entre animal e ficha_medica e combinar as colunas em uma unica coluna chamada 'resumo', no formato "Animal - Especie - Peso kg".
Exibir todos os animais e substituir o campo raca nulo por 'Raca não informada' usando IFNULL.*/

SELECT animal.nome, ifnull(ficha_medica.observacao, 'Nenhuma observação') as Observacao from ficha_medica
join animal on fkAnimal = idAnimal;

SELECT *,
CASE 
	when data_ultima_consulta is null then 'Sem ficha Técnica'
    else 'Tem ficha Técnica'
end as FichaCheck
FROM ficha_medica
LEFT JOIN animal on fkAnimal = idAnimal;

SELECT animal.nome, ficha_medica.peso, ficha_medica.data_ultima_consulta from ficha_medica
join animal on fkAnimal = idAnimal;

SELECT concat(animal.raca, ' | ', animal.especie,' | ', ficha_medica.peso) as RESUMO from ficha_medica
join animal on fkAnimal = idAnimal;

SELECT *, ifnull(raca, 'Raca não informada') as RAÇA from animal;


/*Farmácia -- Relacionamentos 1:1 e 1:N*/

USE sprint2;

/*Parte 1 -- Criar as Tabelas com Constraints
Escreva e execute os comandos para criar as tabelas abaixo. Para cada coluna, escolha o tipo de dado e as constraints mais adequadas de acordo com a descrição.*/


CREATE TABLE farmacia(
idFarmacia INT primary key auto_increment,
nome VARCHAR(45),
cnpj char(14) UNIQUE
);

CREATE TABLE endereco(
idEndereco INT primary key auto_increment,
rua VARCHAR(45),
numero INT,
bairro VARCHAR(45),
cidade VARCHAR(45),
fkFarmacia INT UNIQUE,
constraint fkFarmacia_endereco foreign key (fkfarmacia) references farmacia(idFarmacia)
);

CREATE TABLE farmaceutico(
idFarmaceutico INT primary key auto_increment,
nome VARCHAR(45),
crf VARCHAR(45),
turno VARCHAR(45),
CONSTRAINT chkTurno CHECK ( turno in ('Manhã','Tarde','Noite')),
fkFarmacia INT,
constraint fkFarmacia_farmaceutico foreign key (fkfarmacia) references farmacia(idFarmacia)
);


INSERT INTO farmacia VALUES
(default,'Farmácia Popular', '11222333000144'),
(default,'Drogaria Saúde+', '22333444000155'),
(default,'Farmácia Vida Nova', '33444555000166');

INSERT INTO endereco VALUES
(default,'Rua das Flores', 120, 'Centro', 'São Paulo', 1),
(default,'Avenida Brasil', 450, 'Jardim América', 'Campinas', 2),
(default, null, null, null, null,null);



INSERT INTO farmaceutico VALUES
(default,'Paulinho', '12345', 'Manhã', 1),
(default,'Carlos', '23456', 'Tarde', 1),
(default,'Joca', '34567', 'Noite', 2),
(default,'paulão', '45678', 'Manhã', 2),
(default,'Mariana', '56789', 'Tarde', 3);


SELECT * FROM farmacia
JOIN endereco on endereco.fkFarmacia = idFarmacia
JOIN farmaceutico on farmaceutico.fkFarmacia = idFarmacia;

INSERT INTO endereco VALUES 
(default,'Rua O', 450, 'Jardim vitoria', 'taipas', 2);


/*Parte 3 -- Consultas com SELECT
Escreva e execute os comandos para:

Exibir o nome e o cnpj de todas as farmácias.
Exibir apenas os farmacêuticos que trabalham no turno da Noite.
Exibir os endereços ordenados pela cidade em ordem alfabética.
Exibir o nome e o CRF de todos os farmacêuticos.*/

SELECT * FROM farmacia;

SELECT * FROM farmaceutico
WHERE turno = 'Noite';

SELECT * FROM endereco ORDER BY cidade;

SELECT nome, crf FROM  farmaceutico;

/*Parte 4 -- Consultas com AS (Renomear Colunas)
Escreva e execute os comandos para:

Exibir o nome da farmácia como 'Estabelecimento' e o cnpj como 'Documento'.
Exibir o nome do farmacêutico como 'Profissional' e o turno como 'Horario de Trabalho'.
Exibir a rua e o numero do endereço como 'Logradouro' e 'Num.'.
Combinar a rua e o numero em uma unica coluna chamada 'Endereço Completo'.*/


SELECT nome as Estabelecimento, cnpj as Documento FROM farmacia;

SELECT nome as Profissional, turno as Horario_de_trabalho FROM farmaceutico;

SELECT rua as Logradouro, numero as Num FROM endereco;

SELECT concat(rua,numero) as Endereco_completo from endereco;

/*Parte 5 -- Consultas com CASE
Escreva e execute os comandos para:

Exibir o nome do farmacêutico e uma coluna 'periodo' usando CASE: farmacêuticos do turno da Manhã devem exibir '06h-12h', do turno da Tarde devem exibir '12h-18h', e os demais devem exibir '18h-00h'.
Exibir o nome da farmácia e uma coluna 'tipo_cnpj': verifique o primeiro caractere do CNPJ -- se for '1', exibir 'Matriz'; caso contrario, exibir 'Filial'.
Exibir o bairro do endereço e uma coluna 'zona': escolha pelo menos 2 bairros que você inseriu e classifique-os como 'Zona Norte', 'Zona Sul', etc. Use ELSE para os demais bairros com o valor 'Outra'.
Exibir o nome do farmacêutico e uma coluna 'carga_horaria': farmacêuticos do turno da Noite devem exibir 'Adicional Noturno'; os demais devem exibir 'Normal'.*/

SELECT *,
case
	when turno = 'Manhã' then '06h-12h'
    when turno = 'Tarde' then '12h-18h'
    else '18h-00h'
end as periodo
FROM farmaceutico;

SELECT *,
case
	when cnpj like '1%' = true then 'Matriz'
    else 'Filial'
end as tipo_cnpj
from farmacia;

SELECT *, 
case 
	when bairro = 'Jardim América' then 'Zona sul'
    when bairro = 'Centro' then 'Zona norte'
    else 'Outra'
end as zona
from endereco;

SELECT nome,
case
	when turno = 'Noite' then 'Adicional Noturno'
    else 'Normal'
end as carga_horaria
from farmaceutico;

/*Parte 6 -- Consultas com IFNULL e JOIN
Escreva e execute os comandos para:

Fazer um LEFT JOIN entre farmacia e endereco e substituir a rua por 'SEM ENDERECO' quando a farmácia não tiver endereço cadastrado.
Fazer um INNER JOIN entre farmaceutico e farmacia para exibir o nome do farmacêutico, o CRF e o nome da farmácia.
Fazer um JOIN entre as tres tabelas (farmacia, endereco, farmaceutico) para exibir: nome da farmácia, cidade do endereço e nome do farmacêutico.
Fazer um INNER JOIN entre farmaceutico e farmacia e combinar as colunas em uma unica coluna chamada 'info', no formato "Farmacêutico - CRF - Farmácia".
Usar IFNULL para substituir o campo bairro nulo por 'Bairro não informado' na tabela endereco.*/


SELECT *, ifnull(rua,'Sem endereço') FROM endereco
LEFT JOIN farmacia on fkFarmacia = idFarmacia;

SELECT farmaceutico.nome, farmaceutico.nome, farmaceutico.crf, farmacia.nome FROM farmaceutico
join farmacia on fkFarmacia = idFarmacia;

SELECT farmacia.nome, endereco.cidade, farmaceutico.nome FROM farmacia
JOIN endereco on endereco.fkFarmacia = idFarmacia
JOIN farmaceutico on farmaceutico.fkFarmacia = idFarmacia;

SELECT concat(farmaceutico.nome, ' | ', farmaceutico.crf, ' | ', farmacia.nome) as info From farmaceutico
join farmacia on fkFarmacia = idFarmacia;

SELECT rua, ifnull(bairro,'Sem endereço') as bairro FROM endereco;

/*3. Streaming de Música*/

/*Parte 1 -- Criar as Tabelas com Constraints
Escreva e execute os comandos para criar as tabelas abaixo. Para cada coluna, escolha o tipo de dado e as constraints mais adequadas de acordo com a descrição.*/

CREATE TABLE artista(
idArtista INT PRIMARY KEY auto_increment,
nome VARCHAR(45),
genero_musica VARCHAR(45),
pais VARCHAR(45),
ativo TINYINT,
constraint chkAtivo check (ativo in (1,0))
);

CREATE TABLE musica(
idMusica int primary key auto_increment,
titulo VARCHAR(45),
duracao_segundos INT,
ano_lancamento YEAR,
fkArtista INT,
constraint fkArtistaMusica foreign key (fkArtista) references artista(idArtista)
);

/*Parte 2 -- Inserir Dados de Exemplo
Escreva e execute os comandos para:

Inserir pelo menos 3 artistas na tabela artista. Deixe o campo pais de um artista como nulo.
Inserir pelo menos 5 músicas, associando cada uma a um artista existente. Deixe pelo menos uma música sem artista (campo fk_artista nulo).
Exibir todos os dados das duas tabelas com SELECT.*/

INSERT INTO artista VALUES
(default,'Legião Urbana', 'Rock', 'Brasil', 1),
(default,'Michael Jackson', 'POP', NULL, 0),
(default,'Adele', 'Pop', 'Reino Unido', 1);

INSERT INTO musica VALUES
(default,'Tempo Perdido', 280, 1985, 1),
(default,'Faroeste Caboclo', 540, 1987, 1),
(default,'Beat it', 248, 2013, 2),
(default,'Chicago', 320, 2000, 2),
(default,'Hello', 295, 2015, 3),
(default,'Gunslinger', 200, 2020, NULL);

SELECT * FROM musica
join artista on fkArtista = idArtista;


/*Parte 3 -- Consultas com SELECT
Escreva e execute os comandos para:

Exibir o titulo e a duracao_segundos de todas as músicas.
Exibir as músicas lancadas apos o ano 2020.
Exibir os artistas ordenados pelo nome em ordem alfabética.
Exibir apenas as músicas com duração superior a 200 segundos.*/




SELECT titulo, duracao_segundos FROM musica;

SELECT * FROM musica
WHERE ano_lancamento= 2020 ;

SELECT * FROM artista ORDER BY nome;

SELECT * FROM musica
WHERE duracao_segundos > 200;

/*Parte 4 -- Consultas com AS (Renomear Colunas)
Escreva e execute os comandos para:

Exibir o titulo da música como 'Nome da Música' e o ano_lancamento como 'Ano'.
Exibir o nome do artista como 'Cantor/Banda' e o genero_musical como 'Estilo'.
Exibir a duracao_segundos dividida por 60 como 'Duração (min)'.
Exibir o titulo e o ano_lancamento, renomeando para 'Faixa' e 'Lançamento'.*/

SELECT titulo as NOME_DA_MUSICA, ano_lancamento as ANO FROM musica;

SELECT nome as Cantor_Banda, genero_musica as Estilo from artista;

SELECT duracao_segundos / 60 as 'Duração (min)' from musica;

SELECT titulo as Faixa, ano_lancamento as Lancamento from musica;

/*Parte 5 -- Consultas com CASE
Escreva e execute os comandos para:

Exibir o titulo da música e uma coluna 'era' usando CASE: músicas lancadas antes de 2000 devem exibir 'Clássico', músicas lancadas entre 2000 e 2015 devem exibir 'Moderno', e as demais devem exibir 'Atual'.
Exibir o nome do artista e uma coluna 'status': artistas ativos devem exibir 'Em atividade'; os demais devem exibir 'Inativo'.
Exibir o titulo e uma coluna 'tamanho': músicas com menos de 180 segundos devem exibir 'Curta', entre 180 e 300 segundos devem exibir 'Normal', e as demais devem exibir 'Longa'.
Exibir o nome do artista e uma coluna 'origem': artistas do Brasil devem exibir 'Nacional'; os demais devem exibir 'Internacional'. */

SELECT titulo, 
case
	when ano_lancamento < 2000 then 'Classico'
    when ano_lancamento < 2015 then 'Moderno'
    else 'Atual'
end as ERA
FROM musica;

SELECT nome, 
case
	when ativo = 0 then 'Inativo'
    else 'Ativo'
end as STATUSS
from artista;


SELECT titulo, 
case
	when duracao_segundos < 180 then 'Curta'
    when duracao_segundos < 300 then 'Normal'
    else 'Longa'
end as tamanho
from musica;

SELECT nome,
case 
	when pais = 'Brasil' then 'Nacional'
    else 'Internacional'
end as origem
from artista;



/*Parte 6 -- Consultas com IFNULL e JOIN
Escreva e execute os comandos para:

Exibir o nome do artista e substituir o campo pais nulo por 'Pais desconhecido' usando IFNULL.
Fazer um LEFT JOIN entre musica e artista e substituir o nome do artista por 'ARTISTA DESCONHECIDO' quando não houver associação.
Fazer um INNER JOIN entre musica e artista para exibir o título da música, o ano e o nome do artista.
Fazer um INNER JOIN entre musica e artista e combinar as colunas em uma unica coluna chamada 'catalogo', no formato "Título - Artista - Ano".
Fazer um RIGHT JOIN entre musica e artista para exibir todos os artistas, inclusive os que não possuem músicas cadastradas.*/

SELECT nome, ifnull(pais, 'Pais Desconhecido') as Pais from artista;

SELECT *, ifnull(artista.nome, 'ARTISTA DESCONHECIDO') as nome FROM musica 
left join artista on fkArtista = idArtista;

SELECT musica.titulo, musica.ano_lancamento, artista.nome from musica
 join artista on fkArtista = idArtista;

SELECT concat(musica.titulo, ' | ',artista.nome,' | ',musica.ano_lancamento) as 'Catalago' from musica
join artista on fkArtista = idArtista;

SELECT * from musica
right join artista on fkArtista = idArtista;

/*4. Oficina Mecânica*/

/*Parte 1 -- Criar as Tabelas com Constraints
Escreva e execute os comandos para criar as tabelas abaixo. Para cada coluna, escolha o tipo de dado e as constraints mais adequadas de acordo com a descrição.*/

USE sprint2;

CREATE TABLE cliente(
idCliente INT primary key auto_increment,
nome VARCHAR(45),
telefone char(9),
email VARCHAR(45)
);

CREATE TABLE veiculo(
idVeiculo int primary key auto_increment,
placa char(7),
marca VARCHAR(45),
modelo VARCHAR(45),
ano YEAR,
fkCliente INT UNIQUE,
CONSTRAINT fkClienteVeiculo foreign key (fkCliente) references cliente(idCliente)
);

/*Parte 2 -- Inserir Dados de Exemplo
Escreva e execute os comandos para:

Inserir pelo menos 3 clientes na tabela cliente. Deixe o campo email de um cliente como nulo.
Inserir pelo menos 5 veículos, associando cada um a um cliente existente. Deixe pelo menos um veículo sem cliente (campo fk_cliente nulo).
Exibir todos os dados das duas tabelas com SELECT.*/

INSERT INTO cliente VALUES
(DEFAULT, 'Aninha', '912345678','ana@email.com'),
(DEFAULT, 'Brunão', '923456789', 'bruno@email.com'),
(DEFAULT, 'Carlão', '934567890', NULL),
(DEFAULT, 'Dieguinho','945678901', 'diego@email.com'),
(DEFAULT, 'Ellen', '956789012', 'ellen@email.com');


INSERT INTO veiculo VALUES
(DEFAULT, 'ABC1D23', 'Toyota','Corolla',2020, 1),
(DEFAULT, 'DEF4G56', 'Honda','Civic',2019, 2),
(DEFAULT, 'GHI7J89', 'Volkswagen','Gol', 2015, 3),
(DEFAULT, 'JKL0M12', 'Fiat','Argo', 2022, 4),
(DEFAULT, 'MNO3P45', 'Chevrolet','Onix', 2021, NULL);


SELECT * FROM veiculo
join cliente on fkCliente = idCliente;


/*Parte 3 -- Consultas com SELECT
Escreva e execute os comandos para:

Exibir a placa, a marca e o modelo de todos os veículos.
Exibir apenas os veículos da marca Fiat (ou a marca que você inseriu).
Exibir os veículos ordenados pelo ano em ordem decrescente.
Exibir apenas os veículos com ano anterior a 2015.*/

SELECT placa, marca, modelo FROM veiculo;

SELECT * FROM veiculo
WHERE marca = 'Fiat';

SELECT * FROM veiculo ORDER BY ano;

SELECT * FROM veiculo
WHERE ano < 2015;

/*Parte 4 -- Consultas com AS (Renomear Colunas)
Escreva e execute os comandos para:

Exibir a placa do veículo como 'Placa do Veículo' e o modelo como 'Modelo do Carro'.
Exibir o nome do cliente como 'Proprietario' e o telefone como 'Contato'.
Exibir o ano e calcular a idade do veículo (ano atual menos o ano do veículo) como 'Idade do Veículo'.
Combinar a marca e o modelo em uma unica coluna chamada 'Veículo Completo'.*/

SELECT placa as 'Placa do Veiculo', modelo as 'Modelo do Carro' from veiculo;

SELECT nome as 'Proprietario', telefone as 'Contato' from cliente;

SELECT concat(marca, ' | ',modelo) as 'Veiculo completo' from veiculo;

/*Parte 5 -- Consultas com CASE
Escreva e execute os comandos para:

Exibir a placa e uma coluna 'classificação' usando CASE: veículos do ano 2020 em diante devem exibir 'Novo', veículos entre 2010 e 2019 devem exibir 'Seminovo', e os demais devem exibir 'Antigo'.
Exibir o modelo e uma coluna 'tipo_marca': marcas nacionais (Fiat, Chevrolet e Volkswagen) devem exibir 'Nacional'; as demais devem exibir 'Importado'.
Exibir o nome do cliente e uma coluna 'possui_email': quando o campo email estiver preenchido, exibir 'Sim'; caso contrario, exibir 'Não'.
Exibir a placa e uma coluna 'decada': veículos entre 2000 e 2009 devem exibir 'Anos 2000', entre 2010 e 2019 devem exibir 'Anos 2010', e os demais devem exibir 'Anos 2020'.*/


SELECT placa,
case 
	when ano > 2020 then 'Novo'
    when ano > 2010 then 'Seminovo'
    else 'Antigo'
end as classificacao
from veiculo;

SELECT modelo,
case
	when marca = 'Fiat' and marca = 'Chevrolet' and marca = 'Volkswagen' then 'Nacional'
    else 'Importado'
end as tipo_marca
from veiculo;

SELECT nome, 
case
	when email is not null then 'Sim'
    Else 'Não'
end as possui_email
from cliente;

SELECT placa, 
case
	when ano >= 2000 and ano <= 2009 then 'Anos 2000'
	when ano >= 2010 and ano <= 2019 then 'Anos 2010'
    else 'Anos 2020'
end as decada
from veiculo;

/*Parte 6 -- Consultas com IFNULL e JOIN
Escreva e execute os comandos para:

Exibir o nome do cliente e substituir o campo email nulo por 'Email não cadastrado' usando IFNULL.
Fazer um LEFT JOIN entre veiculo e cliente e substituir o nome do cliente por 'SEM DONO' quando não houver associação.
Fazer um INNER JOIN entre veiculo e cliente para exibir a placa, o modelo e o nome do proprietario.
Fazer um INNER JOIN entre veiculo e cliente e combinar as colunas em uma unica coluna chamada 'registro', no formato "Placa - Modelo - Proprietario".
Fazer um RIGHT JOIN entre veiculo e cliente para exibir todos os clientes, inclusive os que não possuem veículos cadastrados.*/

SELECT *, IFNULL(email, 'Email não cadastro') as email from cliente;

SELECT *, ifnull(cliente.nome, 'SEM DONO') as dono from veiculo
left join cliente on fkCliente = idCliente;

SELECT veiculo.placa, veiculo.modelo, cliente.nome from veiculo
join cliente on fkCliente = idCliente;

SELECT concat(veiculo.placa, ' | ' ,veiculo.modelo, ' | ' ,cliente.nome) as registro from veiculo
join cliente on fkCliente = idCliente;

SELECT * from veiculo
right join cliente on fkCliente = idCliente;



