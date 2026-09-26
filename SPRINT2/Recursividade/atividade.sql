USE sprint2;

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

SELECT *, ifnull(raca, 'Raca não informada') as RAÇA from animal



