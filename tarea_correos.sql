--Tarea

--Table con atributos nombre, emails
create table contact_email(
	id_contact numeric(4) primary key,
	nombre varchar(40) not null,
	correo varchar(80) not null
);


create sequence id_contact_seq start 1 increment 1;
alter table contact_email alter column id_contact set default nextval('id_contact_seq');

--- multiple insert 
select * from contact_email ce;

insert into contact_email(nombre, correo) 
values
('Wanda Maximoff','wanda.maximoff@avengers.org'),
('Pietro Maximoff','pietro@mail.sokovia.ru'),
('Erik Lensherr','fuck_you_charles@brotherhood.of.evil.mutants.space'),
('Charles Xavier','i.am.secretely.filled.with.hubris@xavier-school-4-gifted-youngste.'),
('Anthony Edward Stark','iamironman@avengers.gov'),
('Steve Rogers','americas_ass@anti_avengers'),
('The Vision','vis@westview.sword.gov'),
('Clint Barton','bul@lse.ye'),
('Natasja Romanov','blackwidow@kgb.ru'),
('Thor','god_of_thunder-^_^@royalty.asgard.gov'),
('Logan','wolverine@cyclops_is_a_jerk.com'),
('Ororo Monroe','ororo@weather.co'),
('Scott Summers','o@x'),
('Nathan Summers','cable@xfact.or'),
('Groot','iamgroot@asgardiansofthegalaxyledbythor.quillsux'),
('Nebula', 'idonthaveelektras@complex.thanos'),
('Gamora','thefiercestwomaninthegalaxy@thanos.'),
('Rocket','shhhhhhhh@darknet.ru');

--Construyan un query que regrese emails inválidos.
-- correos invalidos:
------terminarn con punto
------correos groseros 
-- correos validos:
----  all email addresses must have the @ character
---- Dots don't matter in Gmail addresses

select ce.correo 
from contact_email ce
where ce.correo like '%@%' and ce.correo not like '%_.' or ce.correo like '%fuck%'
intersect 
select ce.correo 
from contact_email ce
where ce.correo like '%.gov' 
or ce.correo like '%.co' 
or ce.correo like '%.or' 
or ce.correo like '%.ru' 
or ce.correo like '%.ye'
or ce.correo like '%.com'
or ce.correo like '%.org'


-- ANEXO: solo que me regrese alfa-nuericos (no funciona)
select ce.correo 
from contact_email ce
where ce.correo like '%[^a-z0-9A-Z]%';






