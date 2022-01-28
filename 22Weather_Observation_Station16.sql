/*
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. Round your answer to 4 decimal places.
*/

SELECT CAST(MIN(LAT_N) as DECIMAL(10,4)) FROM STATION WHERE LAT_N>38.7780;