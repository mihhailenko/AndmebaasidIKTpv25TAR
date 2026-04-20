INSERT INTO raamat (raamat_nimi, autori_nimi, hind)
VALUES ('Boxing 101', 'Connor Mcdonalds', 16.99),
('Kuidas olla parim laulja', 'Grigoriy Leps', 12.50);

UPDATE raamat
SET hind = 19.99
WHERE raamatID = 2;

SELECT * FROM raamat;
SELECT * FROM raamatu_logi;
