-- select kahe tabeli põhjal
CREATE DATABASE select2tabeli;
use select2tabeli;

-- laps/loom tabelid

CREATE TABLE laps(
lapsID int not null PRIMARY KEY identity(1,1),
nimi varchar(40) not null,
pikkus smallint,
synniaasta int null,
synnilinn varchar(15)
)


INSERT INTO laps(nimi, pikkus, synniaasta, synnilinn)
VALUES ('Kirill', 156, 2009, 'Tallinn'),
('Nikita', 166, 2005, 'Tallinn'),
('Oleg', 125, 2010, 'Tallinn'),
('Leena', 176, 2008, 'Tallinn'),
('Dominic', 175, 2009, 'Tallinn');


SELECT * FROM laps;

CREATE TABLE loom(
loomID int not null PRIMARY KEY identity(1,1),
nimi varchar(40) not null,
kaal smallint,
lapsID int,
FOREIGN KEY (lapsID) REFERENCES laps(lapsID)
)

INSERT INTO loom(nimi, kaal, lapsID)
VALUES
('koer Rex', 12, 1),
('kass Murka', 4, 3),
('kass Semjon', 1, 4),
('papagoi Kesha', 2, 2),
('kass Simba', 5, 5);

-- Alias nimede kasutamine
SELECT l.nimi, l.kaal FROM loom as l;

-- sisemine ühendamine
SELECT * FROM laps, loom; -- nii ei tohi kirjutada, sest 1 tabeli kirjad korrutakse 2. tabeli kirjaga

-- õige päring
SELECT * from laps, loom
WHERE loom.lapsID=laps.lapsID;

-- sama päring alias-nimedega
SELECT * from laps as lp, loom as lm
WHERE lm.lapsID=lp.lapsID;

-- kitsendame päringu
SELECT lp.nimi as lapsenimi, lm.nimi as loomanimi, lm.kaal, lp.synnilinn 
from laps as lp, loom as lm
WHERE lm.lapsID=lp.lapsID;


-- inner join ühendamine
SELECT * from laps INNER JOIN loom
ON loom.lapsID=laps.lapsID;

-- alias nimidega
SELECT lp.nimi as lapsenimi, lm.nimi as loomanimi, lm.kaal, lp.synnilinn 
from laps as lp INNER JOIN loom as lm
ON lm.lapsID=lp.lapsID;

-- LEFT JOIN -- näitab kõik lapsed isegi kui puudub loom
SELECT lp.nimi as lapsenimi, lm.nimi as loomanimi, lm.kaal, lp.synnilinn 
from laps as lp LEFT JOIN loom as lm
ON lm.lapsID=lp.lapsID;

-- RIGHT JOIN

SELECT lp.nimi as lapsenimi, lm.nimi as loomanimi, lm.kaal, lp.synnilinn 
from laps as lp RIGHT JOIN loom as lm
ON lm.lapsID=lp.lapsID;

-- CROSS JOIN korrutatud tabelid
SELECT lp.nimi as lapsenimi, lm.nimi as loomanimi, lm.kaal, lp.synnilinn 
from laps as lp CROSS JOIN loom as lm;

CREATE TABLE varjupaik(
varjupaikID int not null PRIMARY key identity(1,1),
koht varchar(50) not null,
firma varchar(30)
)

alter table loom add varjupaikID int;
alter table loom add constraint fk_varjupaik;
foreign key (varjupaikID) references varjupaik(varjpaikID);

insert into varjupaik(koht, firma)
values ('Paljassaare', 'Varjupaikade MTÜ')

SELECT * FROM varjupaik;


update loom set varjupaikID=1;

select * from loom;

-- select 3/ mitme tabelite põhjal

SELECT lp.nimi as lapsenimi, lm.nimi as loomanimi, v.koht
from laps as lp, loom as lm, varjupaik as v
WHERE lm.lapsID=lp.lapsID AND l.varjupaikID=v.varjupaikID;


-- sama inner joiniga
SELECT lp.nimi as lapsenimi, lm.nimi as loomanimi, v.koht
from (laps as lp INNER JOIN loom as lm ON lm.lapsID=lp.lapsID)
INNER JOIN varjupaik as v ON lm.varjupaikID=v.varjupaikID;
