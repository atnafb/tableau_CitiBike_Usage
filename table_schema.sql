-- creating the table to load the csv file 
CREATE TABLE bike_trips (
    trip_duration INT,
    start_time TIMESTAMP,
    stop_time TIMESTAMP,
    start_station_id INT,
    start_station_name TEXT,
    start_station_latitude FLOAT,
    start_station_longitude FLOAT,
    end_station_id INT,
    end_station_name TEXT,
    end_station_latitude FLOAT,
    end_station_longitude FLOAT,
    bike_id INT,
    user_type TEXT,
    gender TEXT,
    age FLOAT
);
-- Checking the table structure 
SELECT * FROM bike_trips;

-- number of row inserted in bike_trips table 
SELECT COUNT(*) FROM bike_trips; -- 460.318

