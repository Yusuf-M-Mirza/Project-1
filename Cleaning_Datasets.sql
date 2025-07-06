-- Delete weather rows where Q_TG or Q_RR = 9
DELETE FROM london_bikes.weather
WHERE
    Q_TG = 9 OR
    Q_RR = 9;

-- Delete journeys rows where any critical field is NULL
DELETE FROM london_bikes.journeys
WHERE
    id IS NULL OR
    start_date IS NULL OR
    start_station_id IS NULL OR
    start_station_name IS NULL OR
    end_date IS NULL OR
    end_station_id IS NULL OR
    end_station_name IS NULL OR
    bike_id IS NULL OR 
    bike_model IS NULL OR
    ride_duration IS NULL OR
    ride_duration_ms IS NULL;

-- Find duplicate weather records by date
SELECT
    DATE,
    COUNT(DATE) AS Total
FROM london_bikes.weather
GROUP BY DATE
HAVING COUNT(DATE) > 1;

-- Delete duplicate journeys by id
DELETE FROM london_bikes.journeys
WHERE id IN (
    SELECT id
    FROM (
        SELECT id
        FROM london_bikes.journeys
        GROUP BY id
        HAVING COUNT(*) > 1
    ) dup
);

-- Delete ride journey lengths of 0 or less
DELETE FROM london_bikes.journeys
WHERE ride_duration_ms <= 0;
