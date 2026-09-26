USE sprint2;

CREATE TABLE funcionario (
idfuncionario INT PRIMARY key auto_increment,
nome varchar(45),
areaFuncionario varchar(45),
salario decimal (10,2),
fkSupervisor INT,
CONSTRAINT fkFuncSuper
	foreign key(fkSupervisor)
		references funcionario(idFuncionario)
);

insert into funcionario(nome,salario, fkSupervisor) values
('Brandão', 100.00, null),
('Vivian', 99.00, 1),
('Matheus', 96.00, 1),
('Pedro', 101.00, 2);

select * from funcionario
join funcionario AS Supervisor on funcionario.fkSupervisor = supervisor.idFuncionario;

select funcionario.nome as nomefunc, supervisor.nome as nomesuper
from funcionario join funcionario as supervisor
on funcionario.fkSupervisor = supervisor.idFuncionario;


select funcionario.nome as nomefunc, ifnull(supervisor.nome, 'Supervisor') as nomesuper
from funcionario left join funcionario as supervisor
on funcionario.fkSupervisor = supervisor.idFuncionario;

create table dependente(
idDependente INT,
fkFuncionario INT,
CONSTRAINT pkComposta primary key (idDependente, fkFuncionario),
nome VARCHAR(45),
parentesco VARCHAR(45),
CONSTRAINT fkDepFunc FOREIGN KEY (fkFuncionario)
REFERENCES funcionario (idFuncionario)
);

insert into dependente VALUES 
	(1, 2,'Cintia', 'namorada'),
    (1, 3,'Lola', 'pet'),
    (2, 3,'Sebastian', 'pet'),
    (1, 4,'Eliane', 'mãe');
    
    
select funcionario.nome as Funcionario, dependente.nome as Dependente
from funcionario join dependente
	on idfuncionario = fkFuncionario;
    
select funcionario.nome as Funcionario, dependente.nome as Dependente
from funcionario left join dependente
	on idfuncionario = fkFuncionario
    where fkFuncionario is null;
    
    select funcionario.nome as Funcionario, supervisor.nome as Supervisor, dependente.nome as Dependente from funcionario
    left join Dependente on idfuncionario = fkfuncionario
    join funcionario as supervisor on funcionario.fkSupervisor = supervisor.idFuncionario;
 



