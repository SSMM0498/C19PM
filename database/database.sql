DROP DATABASE IF EXISTS c19pm;
CREATE SCHEMA IF NOT EXISTS c19pm DEFAULT CHARACTER SET utf8;
USE c19pm;

DROP TABLE IF EXISTS locality;

CREATE TABLE IF NOT EXISTS locality (
  idLocality INT NOT NULL AUTO_INCREMENT,
  localityName VARCHAR(50) NULL,
  nbPopulation INT NULL,
  PRIMARY KEY (idLocality)
);

INSERT INTO locality (localityName, nbPopulation) VALUES
("Dakar",934498),
("Guédiawaye",155279),
("Pikine",773494),
("Rufisque",688808),
("Bambey",664383),
("Diourbel",922148),
("Mbacké",94691),
("Fatick",513367),
("Foundiougne",10118),
("Gossas",415224),
("Kaffrine",166659),
("Birkilane",143479),
("Koungheul",430154),
("Malem Hoddar",349777),
("Guinguinéo",111222),
("Kaolack",598377),
("Nioro du Rip",915994),
("Kédougou",10056),
("Salémata",17501),
("Saraya",29484),
("Kolda",676455),
("Médina Yoro Foulah",148268),
("Vélingara",61835),
("Kébémer",741693),
("Linguère",712343),
("Louga",851889),
("Kanel",953308),
("Matam",241231),
("Ranérou Ferlo",25426),
("Dagana",498771),
("Podor",493472),
("Saint-Louis",771323),
("Bounkiling",591804),
("Goudomp",683051),
("Sédhiou",283218),
("Bakel",216972),
("Goudiry",691342),
("Koumpentoum",625333),
("Tambacounda",341645),
("M'bour",675545),
("Thiès",353359),
("Tivaouane",200501),
("Bignona",260215),
("Oussouye",10805),
("Ziguinchor",343291);

DROP TABLE IF EXISTS distance;

CREATE TABLE IF NOT EXISTS distance (
  idDistance INT NOT NULL AUTO_INCREMENT,
  distance INT NULL,
  idLocality1 INT NOT NULL,
  idLocality2 INT NOT NULL,
  PRIMARY KEY (idDistance),
  CONSTRAINT fk_locs_loc1 FOREIGN KEY (idLocality1) REFERENCES locality (idLocality),
  CONSTRAINT fk_locs_loc2 FOREIGN KEY (idLocality2) REFERENCES locality (idLocality)
);


DROP TABLE IF EXISTS monthStat;

CREATE TABLE IF NOT EXISTS monthStat (
  idMonth INT NOT NULL AUTO_INCREMENT,
  totalCases INT NULL DEFAULT 0,
  totalHealed INT NULL DEFAULT 0,
  totalDeath INT NULL DEFAULT 0,
  sourceFileName VARCHAR(7) NULL,
  PRIMARY KEY (idMonth)
);

INSERT INTO monthStat(totalCases, totalHealed, totalDeath, sourceFileName) VALUES
(672,16,6,"2020-06"),
(512,31,9,"2020-07"),
(322,99,9,"2020-08");

DROP TABLE IF EXISTS dayStat;

CREATE TABLE IF NOT EXISTS dayStat (
  idDay INT NOT NULL AUTO_INCREMENT,
  annoucementDate INT NULL,
  numberOfTests INT NULL,
  numberOfNewCases INT NULL,
  numberOfContactCases INT NULL,
  numberOfCommunityCases INT NULL,
  numberOfHealed INT NULL,
  numberOfDeaths INT NULL,
  extractionDate DATE NULL,
  idMonth INT NOT NULL,
  PRIMARY KEY (idDay),
  CONSTRAINT fk_days_mont FOREIGN KEY (idMonth) REFERENCES monthStat (idMonth)
);

INSERT INTO dayStat(annoucementDate, numberOfTests, numberOfNewCases, numberOfContactCases,numberOfCommunityCases,numberOfHealed,numberOfDeaths,
 idMonth, extractionDate) VALUES
(01, 68, 8, 15, 78, 35, 72, 1, NOW()),(02, 52, 10, 4, 96, 5, 79, 2, NOW()),(03, 88, 10, 13, 76, 7, 93, 1, NOW()),(04, 35, 50, 77, 11, 62, 57, 2, NOW()),(05, 96, 59, 15, 73, 16, 74, 2, NOW()),(06, 84, 50, 5, 4, 9, 91, 1, NOW()),(07, 68, 71, 26, 99, 44, 47, 1, NOW()),(08, 13, 41, 89, 2, 52, 90, 1, NOW()),(09, 35, 44, 45, 59, 65, 45, 2, NOW()),(10, 49, 88, 64, 62, 71, 26, 1, NOW()),(11, 81, 41, 13, 1, 88, 74, 1, NOW()),(12, 2, 2, 5, 57, 18, 42, 1, NOW()),(13, 32, 27, 50, 83, 70, 20, 1, NOW()),(14, 12, 10, 5, 25, 19, 36, 2, NOW()),(15, 75, 16, 22, 30, 97, 50, 2, NOW()),(16, 19, 16, 11, 26, 82, 32, 1, NOW()),(17, 66, 47, 81, 48, 44, 31, 1, NOW()),(18, 57, 18, 39, 70, 96, 37, 1, NOW()),(19, 20, 9, 73, 29, 57, 90, 2, NOW()),(20, 23, 56, 40, 35, 7, 13, 2, NOW()),(21, 80, 22, 51, 83, 3, 25, 1, NOW()),(22, 77, 14, 7, 70, 2, 16, 2, NOW()),(23, 68, 10, 30, 87, 25, 36, 1, NOW()),(24, 71, 46, 63, 63, 24, 46, 2, NOW()),(25, 52, 2, 53, 3, 89, 99, 1, NOW()),(26, 33, 35, 65, 28, 24, 51, 1, NOW()),(27, 37, 52, 58, 23, 92, 45, 1, NOW()),(28, 83, 68, 7, 18, 4, 62, 1, NOW()),(29, 85, 40, 74, 30, 4, 91, 1, NOW()),(30, 11, 47, 39, 96, 93, 34, 2, NOW()),(05, 96, 59, 15, 73, 16, 74, 3, NOW()),(06, 84, 50, 5, 4, 9, 91, 3, NOW()),(07, 68, 71, 26, 99, 44, 47, 3, NOW()),(08, 13, 41, 89, 2, 52, 90, 3, NOW()),(09, 35, 44, 45, 59, 65, 45, 3, NOW()),(21, 80, 22, 51, 83, 3, 25, 3, NOW()),(22, 77, 14, 7, 70, 2, 16, 3, NOW()),(23, 68, 10, 30, 87, 25, 36, 3, NOW()),(24, 71, 46, 63, 63, 24, 46, 3, NOW()),(25, 52, 2, 53, 3, 89, 99, 3, NOW()),(26, 33, 35, 65, 28, 24, 51, 3, NOW()),
(31, 26, 23, 64, 12, 43, 50, 3, NOW());

DROP TABLE IF EXISTS localityStat;

CREATE TABLE IF NOT EXISTS localityStat (
  idLocalityStat INT NOT NULL AUTO_INCREMENT,
  newCases INT NULL,
  idDay INT NOT NULL,
  isRegion BOOLEAN DEFAULT false,
  idLocality INT NOT NULL,
  PRIMARY KEY (idLocalityStat),
  CONSTRAINT fk_locs_days FOREIGN KEY (idDay) REFERENCES dayStat (idDay),
  CONSTRAINT fk_locs_loc FOREIGN KEY (idLocality) REFERENCES locality (idLocality)
);

DROP TABLE IF EXISTS EvolutionStat;

CREATE TABLE IF NOT EXISTS EvolutionStat (
  idEvol INT NOT NULL AUTO_INCREMENT,
  Conc FLOAT,
  Prog FLOAT NULL DEFAULT 0,
  idMonth INT NOT NULL,
  idLocality INT NOT NULL,
  PRIMARY KEY (idEvol),
  CONSTRAINT fk_ev_mont FOREIGN KEY (idMonth) REFERENCES monthStat (idMonth),
  CONSTRAINT fk_ev_loc FOREIGN KEY (idLocality) REFERENCES locality (idLocality)
);

DROP TABLE IF EXISTS TransmissionLevel;

CREATE TABLE IF NOT EXISTS TransmissionLevel (
  idTrans INT NOT NULL AUTO_INCREMENT,
  transValue FLOAT NULL,
  idMonth INT NOT NULL,
  idLocality1 INT NOT NULL,
  idLocality2 INT NOT NULL,
  PRIMARY KEY (idTrans),
  CONSTRAINT fk_trans_mont FOREIGN KEY (idMonth) REFERENCES monthStat (idMonth),
  CONSTRAINT fk_trans_loc1 FOREIGN KEY (idLocality1) REFERENCES locality (idLocality),
  CONSTRAINT fk_trans_loc2 FOREIGN KEY (idLocality2) REFERENCES locality (idLocality)
);


CREATE TRIGGER after_localityStat_insert
AFTER INSERT
ON localityStat FOR EACH ROW
BEGIN
    DECLARE var_nbPopulation INT;

    DECLARE var_exist INT;

    DECLARE var_isFirstCase INT;

    DECLARE var_idMonth_Current INT;
    DECLARE var_month_Current VARCHAR(7);
    DECLARE var_idMonth_Previous INT;

    DECLARE var_Conc_Current FLOAT;
    DECLARE var_Conc_Previous FLOAT;
    DECLARE var_Prog_Current FLOAT;

    SELECT nbPopulation FROM locality WHERE idLocality = NEW.idLocality
    INTO var_nbPopulation;

    SELECT idMonth, sourceFileName FROM monthStat WHERE idMonth = (
        SELECT idMonth FROM dayStat WHERE idDay = NEW.idDay
    ) INTO var_idMonth_Current, var_month_Current;

    SET var_exist := 0;

    SELECT 1, Conc FROM EvolutionStat WHERE idMonth = var_idMonth_Current AND idLocality = NEW.idLocality
    INTO var_exist, var_Conc_Current;

    SET var_idMonth_Previous := 0;

    SELECT idMonth FROM monthStat WHERE sourceFileName = (
        DATE_FORMAT(STR_TO_DATE(CONCAT(var_month_Current,'-1'), '%Y-%m-%d') - INTERVAL 1 MONTH, '%Y-%m')
    ) INTO var_idMonth_Previous;

    SET var_Prog_Current := 0;
    SET var_Conc_Previous := 0;

    IF (var_exist = 0) THEN
        SET var_Conc_Current := (NEW.newCases / var_nbPopulation);

        IF (var_idMonth_Previous <> 0) THEN

            SELECT Conc FROM EvolutionStat WHERE idMonth = var_idMonth_Previous AND idLocality = NEW.idLocality
            INTO var_Conc_Previous;

            SET var_Prog_Current := ((var_Conc_Current - var_Conc_Previous) / var_nbPopulation);

        END IF;

        INSERT INTO EvolutionStat(Conc, Prog, idMonth, idLocality)
        VALUES (var_Conc_Current, var_Prog_Current, var_idMonth_Current, NEW.idLocality);

    ELSE

        SET var_Conc_Current := (var_Conc_Current + NEW.newCases) / var_nbPopulation;

        IF (var_idMonth_Previous <> 0) THEN

            SELECT Conc FROM EvolutionStat WHERE idMonth = var_idMonth_Previous AND idLocality = NEW.idLocality
            INTO var_Conc_Previous;

            SET var_Prog_Current := ((var_Conc_Current - var_Conc_Previous) / var_nbPopulation);

        END IF;

        UPDATE EvolutionStat SET Conc=var_Conc_Current, Prog=var_Prog_Current
        WHERE idMonth = var_idMonth_Current AND idLocality = NEW.idLocality;

    END IF;

END;

INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(1, 1, 20),(2, 8, 15),(2, 1, 8),(2, 44, 14),(3, 9, 4),(4, 1, 8),(4, 5, 6),(4, 44, 3),(5, 22, 9),(6, 17, 10),(6, 1, 3),(6, 37, 15),(6, 13, 14),(7, 21, 16),(8, 33, 3),(8, 20, 15),(8, 43, 1),(8, 28, 8),(8, 1, 10),(8, 36, 2),(10, 15, 3),(11, 7, 3),(11, 7, 13),(11, 11, 16),(11, 10, 5),(11, 1, 11),(11, 3, 1),(11, 16, 3),(12, 21, 10),(12, 38, 8),(13, 8, 6),(13, 18, 8),(13, 4, 2),(13, 14, 5),(13, 4, 15),(13, 36, 6),(13, 1, 3),(14, 5, 14),(14, 3, 13),(14, 10, 16),(14, 38, 2),(14, 17, 9),(15, 2, 14),(15, 45, 7),(15, 21, 4),(15, 19, 2),(15, 42, 5),(17, 16, 12),(17, 39, 10),(17, 17, 16),(17, 12, 8),(18, 24, 12),(18, 27, 13),(19, 24, 7),(19, 23, 11),(19, 1, 4),(19, 32, 1),(19, 34, 7),(20, 29, 2),(20, 31, 8),(20, 14, 3),(20, 35, 12),(20, 26, 9),(20, 13, 2),(20, 14, 1),(20, 1, 13),(21, 45, 3),(21, 4, 7),(21, 13, 2),(21, 5, 2),(21, 5, 6),(21, 1, 6),(21, 22, 6),(23, 16, 10),(23, 25, 15),(24, 45, 8),(24, 9, 13),(24, 32, 8),(24, 7, 16),(24, 40, 12),(24, 9, 4),(24, 2, 16),(24, 1, 11),(25, 11, 14),(25, 13, 8),(26, 42, 4),(27, 32, 7),(27, 2, 6),(27, 25, 2),(30, 5, 9),(30, 25, 1),(30, 1, 11),(30, 37, 12),(30, 34, 16),(30, 12, 6),(30, 44, 7),(31, 35, 4),(31, 1, 13),(31, 13, 4),(31, 32, 4),(31, 41, 11),(31, 1, 8),(32, 8, 2),(33, 7, 16),(33, 8, 11),(33, 42, 15),(33, 12, 3),(34, 1, 12),(34, 38, 2),(34, 43, 8),(34, 13, 3),(34, 18, 2),(35, 9, 6),(38, 12, 3),(38, 1, 6),(38, 22, 12),(38, 31, 11),(38, 40, 12),(38, 18, 3),(40, 29, 16),(40, 33, 13),(40, 22, 4),(40, 33, 8),(40, 36, 13),(40, 42, 13),(40, 4, 11),(41, 1, 2),(41, 22, 12),(41, 13, 1),(41, 18, 5),(41, 40, 3),(41, 2, 5),(41, 31, 9),(42, 39, 13);
INSERT INTO locationStat(idDay, idLocation, nbNewCases) VALUES
(1, 1, 20),(2, 8, 15),(2, 1, 8),(2, 44, 14),(3, 9, 4),(4, 1, 8),(4, 5, 6),(4, 44, 3),(5, 22, 9),(6, 17, 10),(6, 1, 3),(6, 37, 15),(6, 13, 14),(7, 21, 16),(8, 33, 3),(8, 20, 15),(8, 43, 1),(8, 28, 8),(8, 1, 10),(8, 36, 2),(10, 15, 3),(11, 7, 3),(11, 7, 13),(11, 11, 16),(11, 10, 5),(11, 1, 11),(11, 3, 1),(11, 16, 3),(12, 21, 10),(12, 38, 8),(13, 8, 6),(13, 18, 8),(13, 4, 2),(13, 14, 5),(13, 4, 15),(13, 36, 6),(13, 1, 3),(14, 5, 14),(14, 3, 13),(14, 10, 16),(14, 38, 2),(14, 17, 9),(15, 2, 14),(15, 45, 7),(15, 21, 4),(15, 19, 2),(15, 42, 5),(17, 16, 12),(17, 39, 10),(17, 17, 16),(17, 12, 8),(18, 24, 12),(18, 27, 13),(19, 24, 7),(19, 23, 11),(19, 1, 4),(19, 32, 1),(19, 34, 7),(20, 29, 2),(20, 31, 8),(20, 14, 3),(20, 35, 12),(20, 26, 9),(20, 13, 2),(20, 14, 1),(20, 1, 13),(21, 45, 3),(21, 4, 7),(21, 13, 2),(21, 5, 2),(21, 5, 6),(21, 1, 6),(21, 22, 6),(23, 16, 10),(23, 25, 15),(24, 45, 8),(24, 9, 13),(24, 32, 8),(24, 7, 16),(24, 40, 12),(24, 9, 4),(24, 2, 16),(24, 1, 11),(25, 11, 14),(25, 13, 8),(26, 42, 4),(27, 32, 7),(27, 2, 6),(27, 25, 2),(30, 5, 9),(30, 25, 1),(30, 1, 11),(30, 37, 12),(30, 34, 16),(30, 12, 6),(30, 44, 7),(31, 35, 4),(31, 1, 13),(31, 13, 4),(31, 32, 4),(31, 41, 11),(31, 1, 8),(32, 8, 2),(33, 7, 16),(33, 8, 11),(33, 42, 15),(33, 12, 3),(34, 1, 12),(34, 38, 2),(34, 43, 8),(34, 13, 3),(34, 18, 2),(35, 9, 6),(38, 12, 3),(38, 1, 6),(38, 22, 12),(38, 31, 11),(38, 40, 12),(38, 18, 3),(40, 29, 16),(40, 33, 13),(40, 22, 4),(40, 33, 8),(40, 36, 13),(40, 42, 13),(40, 4, 11),(41, 1, 2),(41, 22, 12),(41, 13, 1),(41, 18, 5),(41, 40, 3),(41, 2, 5),(41, 31, 9),(42, 39, 13);



-- recupérer les statistiques de tous les regions suivant une date
select locationName, nbNewCases, nbTests, nbCommunityCases, nbContactCases, nbHealed, nbDeath, extractionDate, nbPopulation, annoucementDate from
(
  select *
  from locationstat
  natural join location
) r1
natural join daystat
WHERE extractionDate = '2021-04-12'
\G;
