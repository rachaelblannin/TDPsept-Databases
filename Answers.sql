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

USE world;
SELECT * FROM country; 
SHOW TABLES;
SELECT * FROM city;
SELECT * FROM country; 

SELECT * FROM city JOIN country ON city.ID=country.Capital WHERE country.Name="Spain";
#Madrid

SHOW TABLES;
SELECT * FROM countrylanguage;
SELECT * FROM country;
SELECT countrylanguage.Language FROM countrylanguage JOIN country ON countrylanguage.CountryCode=country.Code WHERE country.Region="Southeast Asia";





