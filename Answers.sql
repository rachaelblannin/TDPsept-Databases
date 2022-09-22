USE world;
SHOW TABLES;
SELECT * FROM city;
SELECT * FROM country;
SELECT * count(*) FROM city WHERE countrycode = "USA";
SELECT count(*) FROM city WHERE countrycode = "USA";
#274

SHOW TABLES;
SELECT * from country;

SELECT population FROM country WHERE Name="Argentina";
#37032000

SELECT * FROM country ORDER BY LifeExpectancy DESC;
#Highest Life expectancy is Andorra




