-- Query to show the average number of bike hires for both weekdays and weekends
SELECT
	w1.hour_of_day,
    w1.weekend,
    w2.weekday
FROM
	(SELECT
		HOUR(start_date) AS hour_of_day,
		COUNT(*) * 1.0 / COUNT(DISTINCT DATE(start_date)) AS weekend
	FROM london_bikes.journeys
	WHERE DAYOFWEEK(start_date) IN (1,7)
	GROUP BY hour_of_day
	ORDER BY hour_of_day) w1
    LEFT JOIN
    (SELECT
		HOUR(start_date) AS hour_of_day,
		COUNT(*) * 1.0 / COUNT(DISTINCT DATE(start_date)) AS weekday
	FROM london_bikes.journeys
	WHERE DAYOFWEEK(start_date) IN (2,3,4,5,6)
	GROUP BY hour_of_day
	ORDER BY hour_of_day) w2
    ON w1.hour_of_day=w2.hour_of_day
;
    
-- Query to show what percentage of riders ride during peak times on weekdays
SELECT
	ROUND(AVG(Avg_Percentage),2) AS Percentage
FROM
	(
	SELECT
		(COUNT(
			CASE
				WHEN HOUR(start_date) IN (6,7,8,9,16,17,18,19)
				THEN 1
			END) * 100.00 / COUNT(*)) AS Avg_Percentage
	FROM london_bikes.journeys
	WHERE DAYOFWEEK(start_date) IN (2,3,4,5,6)
	GROUP BY DATE(start_date)
	) AS thing
;

-- Query to show by what percentage the weekend decreased in total bike hires compared to the weekday
SELECT
	ROUND((1 - (SUM(w1.weekend) / SUM(w2.weekday))) * 100.0,2) AS Percentage
FROM
	(SELECT
		HOUR(start_date) AS hour_of_day,
		COUNT(*) * 1.0 / COUNT(DISTINCT DATE(start_date)) AS weekend
	FROM london_bikes.journeys
	WHERE DAYOFWEEK(start_date) IN (1,7)
	GROUP BY hour_of_day
	ORDER BY hour_of_day) w1
    LEFT JOIN
    (SELECT
		HOUR(start_date) AS hour_of_day,
		COUNT(*) * 1.0 / COUNT(DISTINCT DATE(start_date)) AS weekday
	FROM london_bikes.journeys
	WHERE DAYOFWEEK(start_date) IN (2,3,4,5,6)
	GROUP BY hour_of_day
	ORDER BY hour_of_day) w2
    ON w1.hour_of_day=w2.hour_of_day

