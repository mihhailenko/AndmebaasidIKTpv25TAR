CREATE DATABASE Mihhailenko;
use Mihhailenko;

CREATE TABLE firma(
    firmaID INT NOT NULL PRIMARY KEY identity(1,1),
    firmanimi VARCHAR(20),
    aadress VARCHAR(20),
    telefon VARCHAR(20)
);

INSERT INTO firma (firmanimi, aadress, telefon) VALUES
('Telia', 'Tallinn', '5551111'),
('Bolt', 'Tallinn', '5552222'),
('Elisa', 'Tallinn', '5553333'),
('Wolt', 'Tartu', '5554444'),
('Microsoft', 'Parnu', '5555555');

select * from firma;

CREATE TABLE praktikajuhendaja(
    praktikajuhendajaID INT PRIMARY KEY identity(1,1),
    eesnimi VARCHAR(20),
    perekonnanimi VARCHAR(20),
    synniaeg DATE,
    telefon VARCHAR(20)
);
INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) VALUES
('Mari', 'Speek', '1985-09-12', '5123456'),
('Irina', 'Krusell', '1978-10-03', '5123457'),
('Ingvar', 'Derešivski', '1990-11-25', '5123458'),
('Mihhail', 'Agapov', '1988-02-14', '5123467'),
('Mari-Liis', 'Peets', '1992-06-30', '5123469');

select * from praktikajuhendaja;

CREATE TABLE praktikabaas(
    praktikabaasID INT NOT NULL PRIMARY KEY identity(1,1),
    firmaID INT,
    praktikatingimused VARCHAR(20),
    arvutiprogramm VARCHAR(20),
    juhendajaID INT,
    FOREIGN KEY (firmaID) REFERENCES firma(firmaID),
    FOREIGN KEY (juhendajaID) REFERENCES praktikajuhendaja(praktikajuhendajaID)
);

INSERT INTO praktikabaas (firmaID, praktikatingimused, arvutiprogramm, juhendajaID) VALUES
(1, 'Võrkude haldus', 'Cisco Packet Tracer', 1),
(2, 'Backend arendus', 'Python, PostgreSQL', 3),
(3, 'Telekommunikatsioon', 'Linux', 1),
(4, 'Frontend arendus', 'React', 2),
(5, 'Tarkvaraarendus', 'C#', 4);

select * from praktikabaas;

SELECT * FROM firma
WHERE firmanimi LIKE '%a%';

SELECT *
FROM praktikabaas, firma
WHERE firma.firmaID = praktikabaas.firmaID
ORDER BY firmanimi;

SELECT firmanimi, COUNT(praktikabaasID) AS kogus
FROM praktikabaas, firma
WHERE firma.firmaID = praktikabaas.firmaID
GROUP BY firmanimi;

SELECT *
FROM praktikajuhendaja
WHERE MONTH(synniaeg) = 9 
   OR MONTH(synniaeg) = 10 
   OR MONTH(synniaeg) = 11;


SELECT *
FROM praktikajuhendaja
WHERE MONTH(synniaeg) IN (9, 10, 11);

SELECT eesnimi, perekonnanimi, COUNT(*) AS praktikaKohtade_Arv
FROM praktikajuhendaja, praktikabaas
WHERE praktikajuhendaja.praktikajuhendajaID = praktikabaas.juhendajaID
GROUP BY eesnimi, perekonnanimi;

ALTER TABLE praktikajuhendaja
ADD palk INT;

select * from praktikajuhendaja;

UPDATE praktikajuhendaja SET palk = 1300 + (praktikajuhendajaID * 100);

SELECT AVG(palk) AS keskmine_palk
FROM praktikajuhendaja;

SELECT SUM(palk) AS kogupalk
FROM praktikajuhendaja;

SELECT eesnimi, perekonnanimi, palk FROM praktikajuhendaja
ORDER BY palk DESC;


CREATE VIEW view_firma_praktikakohad AS
SELECT firmanimi, COUNT(praktikabaasID) AS kogus
FROM praktikabaas, firma
WHERE firma.firmaID = praktikabaas.firmaID
GROUP BY firmanimi;

select * from view_firma_praktikakohad;

CREATE VIEW view_sygisel_syndinud_juhendajad AS
SELECT *
FROM praktikajuhendaja
WHERE MONTH(synniaeg) IN (9, 10, 11);

select * from view_sygisel_syndinud_juhendajad;

CREATE PROCEDURE lisaFirma
    @firmanimi VARCHAR(20),
    @aadress VARCHAR(20),
    @telefon VARCHAR(20)
AS
BEGIN
	SELECT * FROM firma;

    INSERT INTO firma (firmanimi, aadress, telefon)
    VALUES (@firmanimi, @aadress, @telefon);

	SELECT * FROM firma;
END;

EXEC lisaFirma 'Google', 'Tallinn', '5559999';
