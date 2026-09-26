CREATE TABLE animal(
idAnimal int primary key auto_increment,
nome varchar(45),
especie varchar(45),
raca varchar(45),
idade int
);

CREATE TABLE ficha_medica(
idFicha int primary key,
data_ultima_consulta date,
peso int
vacina_em_dia tinyint
);