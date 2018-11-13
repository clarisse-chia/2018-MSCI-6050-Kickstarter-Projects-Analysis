

--Hutan, Slide 8, KS project count grouped by country
select pro.countrycode, count(pro.projectid)
FROM PROJECT_T PRO, COUNTRY_T COU, CATEGORY_T CAT, CALENDAR_T CAL
WHERE PRO.CATEGORYID = CAT.CATEGORYID
    AND PRO.COUNTRYCODE = COU.COUNTRYCODE
    AND PRO.DEADLINE = CAL.DATES
group by pro.countrycode
order by count(pro.projectid) desc

--Hutan, Slide 9, KS project avg pledged by country
select pro.countrycode, round(avg(pro.pledgedamount),2) as "Avg pledge by Country"
FROM PROJECT_T PRO, COUNTRY_T COU, CATEGORY_T CAT, CALENDAR_T CAL
WHERE PRO.CATEGORYID = CAT.CATEGORYID
    AND PRO.COUNTRYCODE = COU.COUNTRYCODE
    AND PRO.DEADLINE = CAL.DATES
group by pro.countrycode
order by round(avg(pro.pledgedamount),2) desc

--Sayo, Slide 5, figure 3, /* Average Pledged amounts and backers by Year */
SELECT CAL.YEAR, AVG(PRO.PLEDGEDAMOUNT), AVG(PRO.BACKERS)
FROM PROJECT_T PRO, COUNTRY_T COU, CATEGORY_T CAT, CALENDAR_T CAL
WHERE PRO.CATEGORYID = CAT.CATEGORYID
    AND PRO.COUNTRYCODE = COU.COUNTRYCODE
    AND PRO.DEADLINE = CAL.DATES
GROUP BY CAL.YEAR
ORDER BY AVG(PRO.PLEDGEDAMOUNT) DESC, AVG(PRO.BACKERS) DESC;

--Sayo, Slide 6, figure 4, /* Countries that have had campaigns and the number of projects by country */
SELECT COU.COUNTRYCODE, COUNT (PRO.PROJECTID)
FROM PROJECT_T PRO, COUNTRY_T COU, CATEGORY_T CAT, CALENDAR_T CAL
WHERE PRO.CATEGORYID = CAT.CATEGORYID
    AND PRO.COUNTRYCODE = COU.COUNTRYCODE
    AND PRO.DEADLINE = CAL.DATES
GROUP BY COU.COUNTRYCODE
ORDER BY COUNT(PRO.PROJECTID) DESC;

