-- Query to provide data on number of bikes hired, mean temperature and total rainfall for all 31 days
SELECT
	w.Day,
    w.Temperature,
    w.Rainfall,
    j.Total_Rides/100 AS Total_Rides
FROM
	(SELECT
		DAY(DATE) AS Day,
		TG AS Temperature,
        RR AS Rainfall
	FROM london_bikes.weather
	WHERE YEAR(DATE)=2023 AND MONTH(DATE)=8 AND DAYOFWEEK(DATE) IN (1,2,3,4,5,6,7)
	ORDER BY DAY) AS w
    LEFT JOIN
    (SELECT
		DAY(start_date) AS Day,
		COUNT(start_date) AS Total_Rides
	FROM london_bikes.journeys
    WHERE DAYOFWEEK(start_date) IN (1,2,3,4,5,6,7)
	GROUP BY Day) AS j
    ON w.Day=j.Day
;
