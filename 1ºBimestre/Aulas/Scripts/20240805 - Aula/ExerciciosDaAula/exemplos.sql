create table func2 (
mat int identity(1,-1),
uf varchar(10),
getor int)

insert into func2 values ('Ana', null),
('Pedro', 1),
('Maria', 1),
('Zanana', 3),
('Wilquison', 2)

select * from func2

create table perguntas(
pergunta varchar(100) )

select f.nome, g.nome
from func f left join func g
on f.getor = g.mat;

insert into perguntas values ('O gestor é legal?')
insert into perguntas values ('O gestor faz reunião?')
insert into perguntas values ('Você gosta das festas da empresa?')

select * from func;
select * from perguntas

select * from func, perguntas order by nome;



select a.nome
from aluno a, 
join disc d
on a.ra = d.ra
where d.nomedisc = 'BD';


select a.nome
from aluno a, disc d
where a.ra = d.ra
and d.nomedisc = 'BD';

select f.nome, g.nome
from func f, func g
where f.getor += g.mat;
