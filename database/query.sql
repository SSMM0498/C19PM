-- recupérer les statistiques de departement suivant une date
select
  r1.localityName as localityName,
  r1.newCases as newCases,
  r1.regionName as regionName, 
  r1.nbPopulation as nbPopulation,
  daystat.numberOfNewCases,
  daystat.numberOfTests,
  daystat.numberOfCommunityCases,
  daystat.numberOfContactCases,
  daystat.numberOfHealed,
  daystat.numberOfDeaths,
  daystat.extractionDate,
  daystat.annoucementDate
from
(
  SELECT *
  FROM localityStat
  NATURAL JOIN locality
) r1
join daystat
WHERE (daystat.annoucementDate = '2020-01-01' AND r1.idDay = daystat.idDay) \G;