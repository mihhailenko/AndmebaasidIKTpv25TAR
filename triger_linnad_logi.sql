CREATE DATABASE trigerMihhailenko;
use trigerMihhailenko;


--tabel linnad
CREATE TABLE linnad(
linnId int primary key identity(1,1),
linnanimi varchar(50) unique,
rahvaarv int not null);

--tabel logi
CREATE TABLE logi(
Id int primary key identity(1,1),
kuupaev datetime,
andmed TEXT);

--Insert Triger
CREATE TRIGGER linnalisamine
ON linnad
FOR INSERT
AS
INSERT INTO logi(kuupaev, andmed)
SELECT
    getdate(), inserted.linnanimi
FROM inserted;

--kontrollimiseks tuleb lisada uus linn tabelisse linnad
INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Keila', 60000)
SELECT * FROM linnad;
SELECT * FROM logi;


-- kustutame triger
drop trigger linnalisamine;

CREATE TRIGGER linnaLisamine
ON linnad
FOR INSERT
AS
INSERT INTO logi(kuupaev, andmed)
SELECT
GETDATE(),
CONCAT('lisatud linn: ', inserted.linnanimi,
' | rahvaarv: ', inserted.rahvaarv, ' | id: ', inserted.linnId)
FROM inserted;

SELECT * FROM linnad;
SELECT * FROM logi;


-- DELETE TRIGGER
CREATE TRIGGER linnaKustutamine
ON linnad
FOR DELETE
AS
INSERT INTO logi(kuupaev, andmed)
SELECT
GETDATE(),
CONCAT('kustutatud linn: ', deleted.linnanimi,
' | rahvaarv: ', deleted.rahvaarv, ' | id: ', deleted.linnId)
FROM deleted;

delete from linnad where linnId=1;
SELECT * FROM linnad;
SELECT * FROM logi;

-- UPDATE TRIGGER
CREATE TRIGGER linnaUuendamine
ON linnad
FOR UPDATE
AS
INSERT INTO logi(kuupaev, andmed)
SELECT
getdate(),
CONCAT('vana linna andmed: ', d.linnanimi,
' | ', d.rahvaarv, ' | id: ', d.linnId,
' uued linna andmed: ', i.linnanimi,
' | ', i.rahvaarv, ' | id: ', i.linnId)
FROM deleted d INNER JOIN inserted i
ON d.linnId = i.linnId;

SELECT * FROM linnad;

UPDATE linnad SET linnanimi='Tapa uus', rahvaarv=25
WHERE linnId=2;
SELECT * FROM linnad;
SELECT * FROM logi;


-- lisame kasutajaNimi logi tabelisse
ALTER TABLE logi add kasutaja varchar(40);

-- INSERT, DELETE trigger
CREATE TRIGGER linnaLisamineKustutamine
ON linnad
FOR INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;

	INSERT INTO logi(kuupaev, andmed, kasutaja)
	SELECT
	getdate(),
	CONCAT('lisatud linn: ', inserted.linnanimi,
	' rahvaarv: ', inserted.rahvaarv, ' | id: ', inserted.linnId),
	SYSTEM_USER
	FROM inserted
	UNION ALL
	
	SELECT
	getdate(),
	CONCAT('kustutatud linn: ', deleted.linnanimi,
	' rahvaarv: ', deleted.rahvaarv, ' | id: ', deleted.linnId),
	SYSTEM_USER
	FROM deleted

END;

-- deaktiveerime linnalisamine ja linnakustutamine
DISABLE TRIGGER linnaLisamine on linnad;
DISABLE TRIGGER linnaKustutamine on linnad;

-- kontroll
INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Keila34', 60000)
SELECT * FROM linnad;
SELECT * FROM logi;

DELETE FROM linnad WHERE linnId=5;







-- tabel Auto
CREATE TABLE Auto(
AutoID int primary key identity(1,1),
autoNR varchar(20),
Omanik varchar(30),
mark varchar(20),
aasta int);

-- tabel logiAutod
CREATE TABLE logiAutod(
Id int primary key identity(1,1),
kuupaev datetime,
andmed TEXT);

-- INSERT TRIGGER
CREATE TRIGGER autoLisamine
ON Auto
FOR INSERT
AS
INSERT INTO logiAutod(kuupaev, andmed)
SELECT
GETDATE(),
CONCAT('lisatud auto: ', inserted.autoNR,
' | omanik: ', inserted.Omanik,
' | mark: ', inserted.mark,
' | aasta: ', inserted.aasta,
' | id: ', inserted.AutoID)
FROM inserted;

-- kontrollimiseks lisame auto
INSERT INTO Auto(autoNR, Omanik, mark, aasta)
VALUES ('456FDF', 'Artjom Mihhailenko', 'Lamborghini', 2027)

SELECT * FROM Auto;
SELECT * FROM logiAutod;

-- DELETE TRIGGER
CREATE TRIGGER autoKustutamine
ON Auto
FOR DELETE
AS
INSERT INTO logiAutod(kuupaev, andmed)
SELECT
GETDATE(),
CONCAT('kustutatud auto: ', deleted.autoNR,
' | omanik: ', deleted.Omanik,
' | mark: ', deleted.mark,
' | aasta: ', deleted.aasta,
' | id: ', deleted.AutoID)
FROM deleted;

-- kontrollimiseks kustutame auto
DELETE FROM Auto WHERE AutoID=1

SELECT * FROM Auto;
SELECT * FROM logiAutod;

-- UPDATE TRIGGER
CREATE TRIGGER autoUuendamine
ON Auto
FOR UPDATE
AS
INSERT INTO logiAutod(kuupaev, andmed)
SELECT
GETDATE(),
CONCAT('vana auto andmed: ', d.autoNR,
' | ', d.Omanik,
' | ', d.mark,
' | ', d.aasta,
' | id: ', d.AutoID,
' uued auto andmed: ', i.autoNR,
' | ', i.Omanik,
' | ', i.mark,
' | ', i.aasta,
' | id: ', i.AutoID)
FROM deleted d INNER JOIN inserted i
ON d.AutoID = i.AutoID;

-- kontrollimiseks uuendame auto
UPDATE Auto SET Omanik='Maksim Oguzkov', mark='Volkswagen', aasta=1995
WHERE AutoID=2

SELECT * FROM Auto;
SELECT * FROM logiAutod;

