INSERT INTO monthStat(totalCases, totalHealed, totalDeath, sourceFileName) VALUES
(333,14,4,"2020-01"),
(333,14,4,"2020-05"),
(345,45,3,"2020-06"),
(368,86,2,"2020-07"),
(310,78,7,"2020-08"),
(188,42,6,"2020-10");

INSERT INTO dayStat(annoucementDate, numberOfTests, numberOfNewCases, numberOfContactCases,numberOfCommunityCases,numberOfHealed,numberOfDeaths,
 idMonth, extractionDate) VALUES
('2020-01-01', 68, 8, 15, 78, 35, 72, 1, NOW()),
('2020-01-03', 88, 10, 13, 76, 7, 93, 1, NOW()),
('2020-01-06', 84, 50, 5, 4, 9, 91, 1, NOW()),
('2020-01-07', 68, 71, 26, 99, 44, 47, 1, NOW()),
('2020-01-08', 13, 41, 89, 2, 52, 90, 1, NOW()),
('2020-01-10', 49, 88, 64, 62, 71, 26, 1, NOW()),
('2020-01-11', 81, 41, 13, 1, 88, 74, 1, NOW()),
('2020-01-12', 2, 2, 5, 57, 18, 42, 1, NOW()),
('2020-01-13', 32, 27, 50, 83, 70, 20, 1, NOW()),
('2020-01-16', 19, 16, 11, 26, 82, 32, 1, NOW()),
('2020-01-17', 66, 47, 81, 48, 44, 31, 1, NOW()),
('2020-01-18', 57, 18, 39, 70, 96, 37, 1, NOW()),
('2020-01-21', 80, 22, 51, 83, 3, 25, 1, NOW()),
('2020-01-23', 68, 10, 30, 87, 25, 36, 1, NOW()),
('2020-01-25', 52, 2, 53, 3, 89, 99, 1, NOW()),
('2020-01-26', 33, 35, 65, 28, 24, 51, 1, NOW()),
('2020-01-27', 37, 52, 58, 23, 92, 45, 1, NOW()),
('2020-01-28', 83, 68, 7, 18, 4, 62, 1, NOW()),
('2020-01-29', 85, 40, 74, 30, 4, 91, 1, NOW()),
('2020-01-30', 11, 47, 39, 96, 93, 34, 1, NOW()),
('2020-05-02', 52, 10, 4, 96, 5, 79, 2, NOW()),
('2020-05-04', 35, 50, 77, 11, 62, 57, 2, NOW()),
('2020-05-05', 96, 59, 15, 73, 16, 74, 2, NOW()),
('2020-05-09', 35, 44, 45, 59, 65, 45, 2, NOW()),
('2020-05-14', 12, 10, 5, 25, 19, 36, 2, NOW()),
('2020-05-15', 75, 16, 22, 30, 97, 50, 2, NOW()),
('2020-05-19', 20, 9, 73, 29, 57, 90, 2, NOW()),
('2020-05-20', 23, 56, 40, 35, 7, 13, 2, NOW()),
('2020-05-22', 77, 14, 7, 70, 2, 16, 2, NOW()),
('2020-05-24', 71, 46, 63, 63, 24, 46, 2, NOW()),
('2020-06-05', 96, 59, 15, 73, 16, 74, 3, NOW()),
('2020-06-06', 84, 50, 5, 4, 9, 91, 3, NOW()),
('2020-06-07', 68, 71, 26, 99, 44, 47, 3, NOW()),
('2020-06-08', 13, 41, 89, 2, 52, 90, 3, NOW()),
('2020-06-09', 35, 44, 45, 59, 65, 45, 3, NOW()),
('2020-06-21', 80, 22, 51, 83, 3, 25, 3, NOW()),
('2020-06-22', 77, 14, 7, 70, 2, 16, 3, NOW()),
('2020-06-23', 68, 10, 30, 87, 25, 36, 3, NOW()),
('2020-06-24', 71, 46, 63, 63, 24, 46, 3, NOW()),
('2020-06-25', 52, 2, 53, 3, 89, 99, 3, NOW()),
('2020-06-26', 33, 35, 65, 28, 24, 51, 3, NOW()),
('2020-06-30', 26, 23, 64, 12, 43, 50, 3, NOW());

INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(1, 2, 2),
(1, 10, 7),
(1, 1, 20);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(2, 8, 15),
(2, 1, 8),
(2, 44, 14);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(4, 1, 14),
(4, 2, 4),
(4, 9, 8);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(37, 1, 8),
(37, 5, 6),
(37, 44, 3);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(5, 22, 9);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(36, 17, 10),
(36, 1, 3),
(36, 37, 15),
(36, 13, 14);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(7, 21, 16);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(8, 33, 3),
(8, 20, 15),
(8, 43, 1),
(8, 28, 8),
(8, 1, 10),
(8, 36, 2);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(10, 15, 3);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(11, 7, 3),
(11, 7, 13),
(11, 11, 16),
(11, 10, 5),
(11, 1, 11),
(11, 3, 1),
(11, 16, 3);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(12, 21, 10),
(12, 38, 8);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(13, 8, 6),
(13, 18, 8),
(13, 4, 2),
(13, 14, 5),
(13, 4, 15),
(13, 36, 6),
(13, 1, 3);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(14, 5, 14),
(14, 3, 13),
(14, 10, 16),
(14, 38, 2),
(14, 17, 9);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(15, 2, 14),
(15, 45, 7),
(15, 21, 4),
(15, 19, 2),
(15, 42, 5);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(17, 16, 12),
(17, 39, 10),
(17, 17, 16),
(17, 12, 8);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(18, 24, 12),
(18, 27, 13);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(19, 24, 7),
(19, 23, 11),
(19, 1, 4),
(19, 32, 1),
(19, 34, 7);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(20, 29, 2),
(20, 31, 8),
(20, 14, 3),
(20, 35, 12),
(20, 26, 9),
(20, 13, 2),
(20, 14, 1),
(20, 1, 13);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(21, 45, 3),
(21, 4, 7),
(21, 13, 2),
(21, 5, 2),
(21, 5, 6),
(21, 1, 6),
(21, 22, 6);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(23, 16, 10),
(23, 25, 15);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(24, 45, 8),
(24, 9, 13),
(24, 32, 8),
(24, 7, 16),
(24, 40, 12),
(24, 9, 4),
(24, 2, 16),
(24, 1, 11);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(25, 11, 14),
(25, 13, 8);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(26, 42, 4);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(27, 32, 7),
(27, 2, 6),
(27, 25, 2);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(30, 5, 9),
(30, 25, 1),
(30, 1, 11),
(30, 37, 12),
(30, 34, 16),
(30, 12, 6),
(30, 44, 7);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(31, 35, 4),
(31, 1, 13),
(31, 13, 4),
(31, 32, 4),
(31, 41, 11),
(31, 1, 8);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(32, 8, 2);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(33, 7, 16),
(33, 8, 11),
(33, 42, 15),
(33, 12, 3);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(34, 1, 12),
(34, 38, 2),
(34, 43, 8),
(34, 13, 3),
(34, 18, 2);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(35, 9, 6);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(38, 12, 3),
(38, 1, 6),
(38, 22, 12),
(38, 31, 11),
(38, 40, 12),
(38, 18, 3);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(40, 29, 16),
(40, 33, 13),
(40, 22, 4),
(40, 33, 8),
(40, 36, 13),
(40, 42, 13),
(40, 4, 11);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(41, 1, 2),
(41, 22, 12),
(41, 13, 1),
(41, 18, 5),
(41, 40, 3),
(41, 2, 5),
(41, 31, 9);
INSERT INTO localityStat(idDay, idLocality, newCases) VALUES
(42, 39, 13);