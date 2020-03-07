-- 	Airplanes with listed speeds:
	
    SELECT 
		COUNT(*)
		FROM planes
		where speed > 0;
        --  Minimum listed Speed:
	
    SELECT 
		MIN(speed)
        FROM planes;

-- 	Maximum listed Speed:

    SELECT 
		MAX(speed)
        FROM planes;
        
-- 	Question 2:
-- 	Total dist flown by all planes in January 2013
SELECT
    SUM(distance) AS 'Total Distance'
    FROM flights
	WHERE (
		year = 2013
		AND month = 1);	

	
/* 	Total dist flown by all planes in January 2013 where the 
    tailnum is missing:										*/

	SELECT
    SUM(distance) AS 'Total NULL Distance'
    FROM flights
	WHERE (
		year = 2013
		AND month = 1
		AND tailnum IS NULL);
        
-- Question 3:
SELECT 
        planes.manufacturer,
        SUM(distance) AS 'Total Dist'
	FROM flights
	INNER JOIN planes
		ON flights.tailnum = planes.tailnum
		WHERE (
			flights.year = 2013 
            AND flights.month = 7 
            AND flights.day = 5)
		GROUP BY manufacturer;

-- 	Outer join:
    SELECT 
        planes.manufacturer,
        SUM(distance) AS 'Total Dist'
	FROM flights
	LEFT OUTER JOIN planes
		ON flights.tailnum = planes.tailnum
		WHERE (
			flights.year = 2013 
            AND flights.month = 7 
            AND flights.day = 5)
		GROUP BY manufacturer;
        
-- Question 4:
CREATE INDEX indexFlights ON flights (arr_delay, carrier, year, month, day);
	CREATE INDEX indexWeather ON weather (year, month, day);

	SELECT 
        airlines.name,
        flights.origin,
        AVG(flights.arr_delay) as 'Average_Delay'
        FROM flights
		LEFT JOIN weather ON (
			flights.year = weather.year
            AND flights.month = weather.month
            AND flights.day = weather.day
            AND flights.origin = weather.origin)
		LEFT JOIN airlines ON (
			flights.carrier = airlines.carrier)
		WHERE 
			weather.visib > 9
			and arr_delay > 0
		GROUP BY flights.origin, airlines.name
        ORDER BY Average_Delay DESC LIMIT 10;
        
	DROP INDEX indexFlights ON flights; 
    DROP INDEX indexWeather ON weather;
