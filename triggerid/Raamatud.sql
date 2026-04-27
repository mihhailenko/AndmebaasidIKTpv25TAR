-- Andmebaaside loomine
CREATE DATABASE Raamatud;
USE Raamatud;


-- Tabeli raamat loomine
CREATE TABLE raamat (
raamatID INT IDENTITY(1,1) PRIMARY KEY,
raamat_nimi VARCHAR(50),
autori_nimi VARCHAR(30),
hind DECIMAL(10,2) 
);

-- Tabeli raamatu_logi loomine
CREATE TABLE raamatu_logi (
logiID INT IDENTITY(1,1) PRIMARY KEY,
kuupaev DATE,
andmed VARCHAR(250),
kasutaja VARCHAR(30)
);


-- Triger raamatu lisamise jaoks
CREATE TRIGGER trg_lisa_raamat
ON raamat
FOR INSERT
AS
INSERT INTO raamatu_logi(kuupaev, andmed, kasutaja)
SELECT
GETDATE(),
CONCAT('lisati raamat: ', inserted.raamat_nimi,
' | autor: ', inserted.autori_nimi,
' | hind: ', inserted.hind,
' | id: ', inserted.raamatID),
SYSTEM_USER
FROM inserted;

INSERT INTO raamat (raamat_nimi, autori_nimi, hind)
VALUES ('Kevade', 'Oskar Luts', 12.50);

SELECT * FROM raamat
SELECT * FROM raamatu_logi;


-- Trigger raamatu uuendamise jaoks
CREATE TRIGGER trig_uuenda_raamat
ON raamat
FOR UPDATE
AS
INSERT INTO raamatu_logi(kuupaev, andmed, kasutaja)
SELECT
GETDATE(),
CONCAT('vana raamatu andmed: ', d.raamat_nimi,
' | ', d.autori_nimi,
' | ', d.hind,
' | id: ', d.raamatID,
' uued raamatu andmed: ', i.raamat_nimi,
' | ', i.autori_nimi,
' | ', i.hind,
' | id: ', i.raamatID),
SYSTEM_USER
FROM deleted d
INNER JOIN inserted i
ON d.raamatID = i.raamatID;


UPDATE raamat SET hind = 15.00 WHERE raamatID = 1;

SELECT * FROM raamat;
SELECT * FROM raamatu_logi;

-- Õigusi andmine
GRANT SELECT ON raamat TO raamatupidaja;
GRANT INSERT ON raamat TO raamatupidaja;
GRANT UPDATE ON raamat TO raamatupidaja;

GRANT SELECT ON raamatu_logi TO raamatupidaja;

-- Tabeli laenutus loomine
CREATE TABLE laenutus (
laenutusID INT IDENTITY(1,1) PRIMARY KEY,
raamatID INT,
lugeja_nimi VARCHAR(30),
laenutus_kuupaev DATE,
tagastus_kuupaev DATE,
);

ALTER TABLE laenutus
ADD CONSTRAINT FK_laenutus_raamat FOREIGN KEY (raamatID)
REFERENCES raamat(raamatID);

-- Triger laenutuse lisamise jaoks
CREATE TRIGGER trg_lisa_laenutus
ON laenutus
FOR INSERT
AS
INSERT INTO raamatu_logi(kuupaev, andmed, kasutaja)
SELECT
GETDATE(),
CONCAT('lisati laenutus: raamatID ', inserted.raamatID,
' | lugeja: ', inserted.lugeja_nimi,
' | laenutus: ', inserted.laenutus_kuupaev,
' | tagastus: ', inserted.tagastus_kuupaev,
' | id: ', inserted.laenutusID),
SYSTEM_USER
FROM inserted;

-- Kontroll
INSERT INTO laenutus (raamatID, lugeja_nimi, laenutus_kuupaev, tagastus_kuupaev)
VALUES 
(1, 'Mati Tamm', '2026-04-15', '2026-04-22'),
(1, 'Dominic Toretto', '2026-03-10', '2026-03-17'),
(1, 'Jüri Vaitmaa', '2026-02-05', NULL);

SELECT * FROM laenutus;
SELECT * FROM raamatu_logi;

CREATE TRIGGER trg_uuenda_laenutus
ON laenutus
FOR UPDATE
AS
INSERT INTO raamatu_logi(kuupaev, andmed, kasutaja)
SELECT
GETDATE(),
CONCAT('vana laenutuse andmed: raamatID ', d.raamatID,
' | ', d.lugeja_nimi,
' | ', d.laenutus_kuupaev,
' | ', d.tagastus_kuupaev,
' | id: ', d.laenutusID,
' uued laenutuse andmed: raamatID ', i.raamatID,
' | ', i.lugeja_nimi,
' | ', i.laenutus_kuupaev,
' | ', i.tagastus_kuupaev,
' | id: ', i.laenutusID),
SYSTEM_USER
FROM deleted d
INNER JOIN inserted i
ON d.laenutusID = i.laenutusID;

-- Kontroll
UPDATE laenutus
SET tagastus_kuupaev = '2026-04-22'
WHERE laenutusID = 1;

SELECT * FROM laenutus;
SELECT * FROM raamatu_logi;
