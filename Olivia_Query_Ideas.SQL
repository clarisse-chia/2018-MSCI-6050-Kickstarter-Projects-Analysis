--Query IDEAS FOR DB MGMT PROJECT:
--1.	Which countries have had the highest % of successful kickstarter projects?
--2.	Which Main Category has had the highest % of successful projects?
--3.	Which Sub Category within this has had the highest % of successful projects?
--4.	Which Kickstarter has raised the most $?
--5.	Which Kickstarter has raised the most $ per backer?
--6.	Avg kickstarter $ raised per year
SELECT C.YEAR, AVG(P.PLEDGEDAMOUNT)AS AVG_PLEDGED
FROM PROJECT_T P, CALENDAR_T C
WHERE C.DATES = P.LAUNCHDATE
GROUP BY C.YEAR
ORDER BY C.YEAR ASC;
--7.	Avg kickstarter $ raised per month
SELECT C.MONTH, AVG(P.PLEDGEDAMOUNT)AS AVG_PLEDGED
FROM PROJECT_T P, CALENDAR_T C
WHERE C.DATES = P.LAUNCHDATE
GROUP BY C.MONTH
ORDER BY C.MONTH;

--8.	Avg goal
SELECT AVG(GOALAMOUNT) 
FROM PROJECT_T;

--9.	% of projects raising $0 --THIS DOESNT WORK YET!
SELECT *
FROM (SELECT COUNT(PROJECTID) FROM PROJECT_T WHERE PLEDGEDAMOUNT = 0);

SELECT *
FROM (SELECT COUNT(PROJECTID) FROM PROJECT_T);

--10.	I think it would be cool to do something with the %Like% function in the title but am unsure of what would make the most sense? Maybe like something sad or dramatic?

--11.   Avg $ raised per country
SELECT C.COUNTRYNAME, AVG(P.PLEDGEDAMOUNT)AS AVG_PLEDGED
FROM COUNTRY_T C, PROJECT_T P
WHERE C.COUNTRYCODE = P.COUNTRYCODE
GROUP BY c.countryname
ORDER BY AVG_PLEDGED DESC;

--12. Number of campaigns per year
SELECT C.YEAR, COUNT(P.PROJECTID)AS Number_of_campaigns
FROM PROJECT_T P, CALENDAR_T C
WHERE C.DATES = P.LAUNCHDATE
GROUP BY C.YEAR
ORDER BY C.YEAR ASC;