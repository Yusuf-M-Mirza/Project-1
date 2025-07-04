-- Query to find the net change of stations throughout the weekday for commuters
SELECT
    COALESCE(am.station, pm.station) AS station,
    ROUND(COALESCE(am.starts_am, 0) / 23, 1) AS avg_starts_am,
    ROUND(COALESCE(am.ends_am, 0) / 23, 1) AS avg_ends_am,
    ROUND(COALESCE(pm.starts_pm, 0) / 23, 1) AS avg_starts_pm,
    ROUND(COALESCE(pm.ends_pm, 0) / 23, 1) AS avg_ends_pm,
    ROUND((COALESCE(pm.ends_pm, 0) - COALESCE(am.starts_am, 0)) / 23, 1) AS avg_net_change
FROM
    (
        SELECT
            station_name AS station,
            SUM(CASE WHEN is_start = 1 THEN 1 ELSE 0 END) AS starts_am,
            SUM(CASE WHEN is_start = 0 THEN 1 ELSE 0 END) AS ends_am
        FROM (
            SELECT start_station_name AS station_name, 1 AS is_start
            FROM london_bikes.journeys
            WHERE HOUR(start_date) BETWEEN 6 AND 8
              AND DAYOFWEEK(start_date) BETWEEN 2 AND 6

            UNION ALL

            SELECT end_station_name AS station_name, 0 AS is_start
            FROM london_bikes.journeys
            WHERE HOUR(end_date) BETWEEN 6 AND 8
              AND DAYOFWEEK(end_date) BETWEEN 2 AND 6
        ) am_data
        GROUP BY station_name
    ) am
LEFT JOIN
    (
        SELECT
            station_name AS station,
            SUM(CASE WHEN is_start = 1 THEN 1 ELSE 0 END) AS starts_pm,
            SUM(CASE WHEN is_start = 0 THEN 1 ELSE 0 END) AS ends_pm
        FROM (
            SELECT start_station_name AS station_name, 1 AS is_start
            FROM london_bikes.journeys
            WHERE HOUR(start_date) BETWEEN 17 AND 19
              AND DAYOFWEEK(start_date) BETWEEN 2 AND 6

            UNION ALL

            SELECT end_station_name AS station_name, 0 AS is_start
            FROM london_bikes.journeys
            WHERE HOUR(end_date) BETWEEN 17 AND 19
              AND DAYOFWEEK(end_date) BETWEEN 2 AND 6
        ) pm_data
        GROUP BY station_name
    ) pm ON am.station = pm.station

UNION

-- Add PM-only stations with daily averages
SELECT
    pm.station,
    0 AS avg_starts_am,
    0 AS avg_ends_am,
    ROUND(COALESCE(pm.starts_pm, 0) / 23, 1),
    ROUND(COALESCE(pm.ends_pm, 0) / 23, 1),
    ROUND(COALESCE(pm.ends_pm, 0) / 23, 1) AS avg_net_change
FROM (
    SELECT
        station_name AS station,
        SUM(CASE WHEN is_start = 1 THEN 1 ELSE 0 END) AS starts_pm,
        SUM(CASE WHEN is_start = 0 THEN 1 ELSE 0 END) AS ends_pm
    FROM (
        SELECT start_station_name AS station_name, 1 AS is_start
        FROM london_bikes.journeys
        WHERE HOUR(start_date) BETWEEN 17 AND 19
          AND DAYOFWEEK(start_date) BETWEEN 2 AND 6

        UNION ALL

        SELECT end_station_name AS station_name, 0 AS is_start
        FROM london_bikes.journeys
        WHERE HOUR(end_date) BETWEEN 17 AND 19
          AND DAYOFWEEK(end_date) BETWEEN 2 AND 6
    ) pm_data
    GROUP BY station_name
) pm
LEFT JOIN (
    SELECT station FROM (
        SELECT start_station_name AS station
        FROM london_bikes.journeys
        WHERE HOUR(start_date) BETWEEN 6 AND 8
          AND DAYOFWEEK(start_date) BETWEEN 2 AND 6
        UNION
        SELECT end_station_name AS station
        FROM london_bikes.journeys
        WHERE HOUR(end_date) BETWEEN 6 AND 8
          AND DAYOFWEEK(end_date) BETWEEN 2 AND 6
    ) am_stations
) am ON am.station = pm.station
WHERE am.station IS NULL

ORDER BY avg_net_change DESC;
