use kordamineIKT25;

-- connect to db - (localdb)\MSSQLLocalDB


Create TABLE opilane(
opilaneId int primary key identity(1,1),
nimi varchar(50),
isikukood char(11) not null,
ryhmId int
);

Create TABLE ryhm(
ryhmId int Primary Key identity(1,1),
ryhmNimi char(10) Unique,
opilasteArv int);

-- välisvõti - FK
ALTER TABLE opilane ADD FOREIGN KEY (ryhmId) REFERENCES ryhm(ryhmId);

-- tabeli kustutamine
drop table ...


-- õiguse määramine varem tehtud kasutajale
grant select to opilaneArtjom; -- saab vaadata kõik tabeleid
grant insert on opilane to opilaneArtjom; 

deny delete to opilaneArtjom;


-- eraldi
select * from opilane, ryhm
where opilane.ryhmId = ryhm.ryhmId;

delete from opilane;

insert into opilane values ('Nikita', '123654456', 1);
