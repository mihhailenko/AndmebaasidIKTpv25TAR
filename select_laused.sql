CREATE DATABASE selectMihhailenko;
use selectMihhailenko;

--mockaroo.com - andmete genereerimiseks

create table auto (
	autoId INT PRIMARY KEY,
	autoNumber CHAR(6),
	mark VARCHAR(50) not null,
	mudel VARCHAR(50) not null,
	varv VARCHAR(50),
	v_aasta int
);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (1, 'SA3328', 'Ford', 'F-Series Super Duty', 'Teal', 2007);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (2, 'AI1305', 'Volvo', 'V70', 'Indigo', 2007);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (3, 'WN7757', 'Scion', 'tC', 'Aquamarine', 2008);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (4, 'UA9501', 'Audi', '90', 'Blue', 1990);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (5, 'LH6753', 'Mercury', 'Topaz', 'Fuscia', 1992);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (6, 'AF8357', 'Saturn', 'Ion', 'Purple', 2006);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (7, 'SK2032', 'Lamborghini', 'Aventador', 'Khaki', 2012);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (8, 'KE9265', 'Aston Martin', 'Vantage', 'Pink', 2011);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (9, 'KL6764', 'Porsche', '944', 'Green', 1990);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (10, 'DL4421', 'Cadillac', 'Escalade EXT', 'Orange', 2008);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (11, 'CX5757', 'Ford', 'Expedition EL', 'Fuscia', 2008);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (12, 'LH6305', 'Audi', '5000CS', 'Maroon', 1988);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (13, 'KE1844', 'Chevrolet', 'Suburban 2500', 'Orange', 1994);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (14, 'SA3946', 'Kia', 'Sephia', 'Violet', 1996);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (15, 'BA6981', 'Volvo', '740', 'Indigo', 1992);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (16, 'KE6581', 'GMC', 'Yukon XL 2500', 'Yellow', 2005);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (17, 'NH4965', 'Mercury', 'Mystique', 'Green', 1998);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (18, 'LH9617', 'Volvo', 'C70', 'Goldenrod', 2010);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (19, 'AC5234', 'Chevrolet', 'Colorado', 'Puce', 2009);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (20, 'UA7542', 'Ford', 'Explorer', 'Red', 2011);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (21, 'CX9713', 'Buick', 'Skyhawk', 'Red', 1988);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (22, 'KL4053', 'Saturn', 'S-Series', 'Maroon', 1994);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (23, 'QR3479', 'Ford', 'Country', 'Turquoise', 1967);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (24, 'LA2799', 'Dodge', 'D250 Club', 'Indigo', 1993);
insert into auto (autoId, autoNumber, mark, mudel, varv, v_aasta) values (25, 'LA9967', 'Ford', 'Fusion', 'Purple', 2012);


-- andmete sorteerimine
-- kasvavas järjekorras (ASC)
SELECT * FROM auto
ORDER BY v_aasta;


--kahanevas järjekorras
SELECT * FROM auto
ORDER BY v_aasta DESC;

-- kuvab ainult kaks veergu
SELECT mark, mudel from auto;

-- kordavate väärtuste välistamine DISTINCT
SELECT DISTINCT mark FROM auto;


-- võrdlemine
-- 1. suurem kui >, väiksem kui <, võrdub =
-- leia kõik autod, kus on v_aasta 2000 peale

SELECT mark, mudel, v_aasta FROM auto WHERE v_aasta>=2000;


-- leia kõik autod mis on v_aasta vahemikus 2000-2005
SELECT mark, mudel, v_aasta FROM auto WHERE v_aasta BETWEEN 2000 AND 2005;

SELECT mark, mudel, v_aasta FROM auto WHERE v_aasta >= 2000 AND v_aasta <= 2005;

-- 2. võrdlemine tekst või sümboliga

SELECT mark, mudel, v_aasta FROM auto WHERE mark LIKE 'Ford';

-- IN lause kuvab vastavus loetelus - соответствие перечислению
SELECT mark, mudel, v_aasta FROM auto WHERE mark IN ('Ford', 'Audi', 'Kia');


-- ilma IN
SELECT mark, mudel, v_aasta FROM auto WHERE mark LIKE 'Ford' or mark LIKE 'Audi' OR mark LIKE 'Kia';

-- vastavus mustrile - шаблон
-- algab F tähega

SELECT mark, mudel, v_aasta FROM auto WHERE mark LIKE 'F%';

-- lõpeb p - tähega
SELECT mark, mudel, v_aasta FROM auto WHERE mark LIKE '%p';

-- siseldab ä-täht
SELECT mark, mudel, v_aasta FROM auto WHERE mark LIKE '%a%';


-- kuvada esimest 5 mudeli
SELECT TOP 5 mudel, varv
FROM auto
WHERE varv like 'red'
order by varv;


-- agregaat funktsioonid: SUM, MIN, MAX, AGV, COUNT
SELECT COUNT(*) AS autodeArv FROM auto;

SELECT MAX(v_aasta) AS suuremAasta from auto;

-- keerulisem variant
SELECT mark, AVG(v_aasta) AS kesmineAasta
from auto
GROUP BY mark;

