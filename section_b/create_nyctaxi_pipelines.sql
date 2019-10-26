USE nyc_taxi;

CREATE PIPELINE drivers
AS LOAD DATA KAFKA 'public-kafka.memcompute.com:9092/drivers'
BATCH_INTERVAL 2500
REPLACE
INTO TABLE drivers
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY '';

CREATE PIPELINE trips
AS LOAD DATA KAFKA 'public-kafka.memcompute.com:9092/trips'
BATCH_INTERVAL 2500
REPLACE
INTO TABLE trips
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY '';

-- terminated by tab as the the polygons contain commas
CREATE PIPELINE neighborhoods
AS LOAD DATA S3 'memsql-datafeeds/nyc-taxi-data/'
REPLACE
INTO TABLE neighborhoods
FIELDS TERMINATED BY '\t' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY '';
