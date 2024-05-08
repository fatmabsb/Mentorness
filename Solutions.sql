-- check NULL values
SELECT *
FROM CORONA.`corona virus dataset`
Where `Province` is NULL
or `Country/Region` is NULL 
or `Latitude` is NULL 
or `Longitude` is NULL
or `Confirmed` is NULL
or `Deaths` is NULL
or `Recovered` is NULL ;



-- Q2. If NULL values are present, update them with zeros for all columns. 
-- NO NULL values

UPDATE CORONA.`corona virus dataset`
SET 
    `Province` = COALESCE(`Province`, '0'),
    `Country/Region` = COALESCE(`Country/Region`, '0'),
    `Latitude` = COALESCE(`Latitude`, '0'),
    `Longitude` = COALESCE(`Longitude`, '0'),
    `Confirmed` = COALESCE(`Confirmed`, '0'),
    `Deaths` = COALESCE(`Deaths`, '0'),
    `Recovered` = COALESCE(`Recovered`, '0');
    
-- Q3. check total number of rows

Select count(*) as  `Total number of rows`
FROM CORONA.`corona virus dataset`;

-- The total number of rows is 78386

-- Q4. Check what is start_date and end_date

-- We need to fix the dates format in order to be able to change the datatype of the column DATE unto DATETIME 

UPDATE CORONA.`corona virus dataset`
SET `Date` = STR_TO_DATE(`Date`, '%d-%m-%Y');

-- Now We change the column type into Datetime in order to be able to retrieve the correct dates

ALTER TABLE CORONA.`corona virus dataset`
MODIFY COLUMN `Date` DATE;

-- Now we can queery the start_date and end_date

Select  min(`Date`) as start_date, max(`Date`) as end_date
from CORONA.`corona virus dataset` ;

-- Q5. Number of month present in dataset

SELECT COUNT(DISTINCT CONCAT(YEAR(`Date`), '-', MONTH(`Date`))) AS NumberOfMonths
FROM CORONA.`corona virus dataset`;



-- Q6. Find monthly average for confirmed, deaths, recovered
 
SELECT 
    YEAR(`Date`) AS Year,
    MONTH(`Date`) AS Month,
    AVG(`Confirmed`) AS AvgConfirmed,
    AVG(`Deaths`) AS AvgDeaths,
    AVG(`Recovered`) AS AvgRecovered
FROM 
    CORONA.`corona virus dataset`
GROUP BY 
    YEAR(`Date`), MONTH(`Date`)
ORDER BY 
    YEAR(`Date`), MONTH(`Date`);
    
-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
-- Not solved yet !!

SELECT
    MONTH(Date) AS Month,
    YEAR(Date) AS Year,
    SUBSTRING_INDEX(GROUP_CONCAT(Confirmed ORDER BY confirmed DESC), ',', 1) AS MostFrequentConfirmed,
    SUBSTRING_INDEX (GROUP_CONCAT(Deaths ORDER BY deaths DESC), ',', 1) AS MostFrequentDeaths,
    SUBSTRING_INDEX(GROUP_CONCAT(Recovered ORDER BY recovered DESC), ',', 1) AS MostFrequentRecovered
FROM CORONA.`corona virus dataset`
GROUP BY Month, Year
ORDER BY Year, Month;
  
 
-- Q8. Find minimum values for confirmed, deaths, recovered per year

SELECT 
    YEAR(`Date`) AS Year,
    MIN(`Confirmed`) AS MinConfirmed,
    MIN(`Deaths`) AS MinDeaths,
    MIN(`Recovered`) AS MinRecovered
FROM 
    CORONA.`corona virus dataset`
GROUP BY 
    YEAR(`Date`)
ORDER BY 
    YEAR(`Date`);


-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(`Date`) AS Year,
    MAX(`Confirmed`) AS MaxConfirmed,
    MAX(`Deaths`) AS MaxDeaths,
    MAX(`Recovered`) AS MaxRecovered
FROM 
    CORONA.`corona virus dataset`
GROUP BY 
    YEAR(`Date`)
ORDER BY 
    YEAR(`Date`);
    
-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT 
    YEAR(`Date`) AS Year,
    MONTH(`Date`) AS Month,
    SUM(`Confirmed`) AS TotalConfirmed,
    SUM(`Deaths`) AS TotalDeaths,
    SUM(`Recovered`) AS TotalRecovered
FROM 
    CORONA.`corona virus dataset`
GROUP BY 
    YEAR(`Date`), MONTH(`Date`)
ORDER BY 
    YEAR(`Date`), MONTH(`Date`);


-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
    YEAR(`Date`) AS Year,
    MONTH(`Date`) AS Month,
    SUM(`Confirmed`) AS TotalConfirmed,
    AVG(`Confirmed`) AS AvgConfirmed,
    VARIANCE(`Confirmed`) AS VarianceConfirmed,
    STDDEV(`Confirmed`) AS STDDEVConfirmed
FROM
    CORONA.`corona virus dataset`
GROUP BY
    YEAR(`Date`), MONTH(`Date`)
ORDER BY
    YEAR(`Date`), MONTH(`Date`);

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT
    YEAR(`Date`) AS Year,
    MONTH(`Date`) AS Month,
    SUM(`Deaths`) AS TotalDeaths,
    AVG(`Deaths`) AS AvgDeaths,
    VARIANCE(`Deaths`) AS VarianceDeaths,
    STDDEV(`Deaths`) AS STDDEVDeaths
FROM
    CORONA.`corona virus dataset`
GROUP BY
    YEAR(`Date`), MONTH(`Date`)
ORDER BY
    YEAR(`Date`), MONTH(`Date`);
    
-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT
    YEAR(`Date`) AS Year,
    MONTH(`Date`) AS Month,
    SUM(`Recovered`) AS TotalRecovered,
    AVG(`Recovered`) AS AvgRecovered,
    VARIANCE(`Recovered`) AS VarianceRecovered,
    STDDEV(`Recovered`) AS STDDEVRecovered
FROM
    CORONA.`corona virus dataset`
GROUP BY
    YEAR(`Date`), MONTH(`Date`)
ORDER BY
    YEAR(`Date`), MONTH(`Date`);
    

-- Q14. Find Country having highest number of the Confirmed case
SELECT
    `Country/Region`,
    SUM(`Confirmed`) AS TotalConfirmed
FROM
    CORONA.`corona virus dataset`
GROUP BY
    `Country/Region`
ORDER BY
    TotalConfirmed DESC
LIMIT 1;

-- Q15. Find Country having lowest number of the death case
SELECT
    `Country/Region`,
    SUM(`Deaths`) AS TotalDeaths
FROM
    CORONA.`corona virus dataset`
GROUP BY
    `Country/Region`
ORDER BY
    TotalDeaths asc
LIMIT 1;

-- Q16. Find top 5 countries having highest recovered case
SELECT
    `Country/Region`,
    SUM(`Recovered`) AS TotalRecovered
FROM
    CORONA.`corona virus dataset`
GROUP BY
    `Country/Region`
ORDER BY
    TotalRecovered Desc
LIMIT 5;