/*Note: SQL is not case sensitive language as long as you write correct keywords it will execute the queries.

To select any table: */
SELECT * FROM table_name;

-- string --> 'String' inside the single quote


--To create database:
CREATE DATABASE test;  --(here test is name of database)

--To delete the database:
DROP DATABASE test;    --(here test is name of database)


--To run the queries on selected database:
USE test;

--To create table:
CREATE TABLE test (
  test_column int
);

--To change data in table we use alter:
ALTER TABLE test
ADD another_column VARCHAR(255);      --note here end is at the semicolon so even if we write ADD on row and another_column VARCHAR(255); it will run without any errors.
  
--like this:
ALTER TABLE test
ADD another_column
VARCHAR(255);

--To drop the table:
DROP TABLE test;


--To have atleast have one value inside the column of table use not null:
CREATE TABLE bands (
	id INT NOT NULL auto_increment,       --here auto_increment will increment the values just like we do in excel sheet
	name VARCHAR(255) NOT NULL
);

--to uniquely identify the column we add ID to it


--Primary key: primary identifing column for that table
CREATE TABLE bands(
	id INT NOT NULL auto_increment,
	name VARCHAR(255) NOT NULL,
        PRIMARY KEY(id)
);


--To refernce one table to another we use foreign key:
CREATE TABLE albums(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    release_year INT,
    band_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(band_id) REFERENCES bands(id)
);


--To insert data into the table:
INSERT INTO bands(name)
VALUES ('One Direction')

--To insert multiple data into the table:
INSERT INTO bands(name)
VALUES ('Young Blood'), ('Ware Wolf'), ('TimberWood');


--To see the data of table:
SELECT * FROM bands


--To limit the data in results:
SELECT * FROM bands LIMIT 2

--To get only specific column:
SELECT name FROM bands           --only returns name column and not the id column



--To change the name of column:
SELECT id as 'ID', name as 'BAND NAME'        --alias
FROM bands;

--To set values in order:
SELECT * FROM bands ORDER BY name;   --by default alphabetic order

--To set values in ascending order:
SELECT * FROM bands ORDER BY name ASC;  -- alphabetic order

--To set values in descending order:
SELECT * FROM bands ORDER BY name DESC;   -- reverse alphabetic order


--Insert multiple values in album table:
INSERT INTO albums(name, release_year, band_id) 
VALUES('Up All Night', '2011', '1'),
	  ('Take Me Home', '2012', '1'),
      ('Midnight Memories', '2013', '1'),
      ('Xero', '1996', '5'),
      ('Test Album', NULL, '3');
      
--To get only distinct values from table:
SELECT DISTINCT name FROM albums;
 
 
 --To update the values inside the table:
 UPDATE albums 
 SET release_year = '2010' WHERE id = '1';


--To filter data using WHERE:
SELECT * FROM albums 
WHERE release_year < 2012;


--To get the name of items before al and after al using LIKE:
SELECT * FROM albums
WHERE name LIKE '%al%';
 


--using OR in statement:
SELECT * FROM albums
WHERE name LIKE '%al%'OR band_id = '1';

--using AND in statement:
SELECT * FROM albums
WHERE name LIKE '%al%'AND band_id = '1';

--using BETWEEN in statement:
SELECT * FROM albums
WHERE release_year BETWEEN 1995 AND 2013;


--using IS in statment:
SELECT * FROM albums
WHERE release_year IS NULL;

--To delete values from table:
DELETE FROM albums WHERE id = '5';

--To join to tables using JOIN:
SELECT * FROM bands
JOIN albums ON bands.id = albums.band_id;

/*3 types of join:
inner join
left join
right join*/


--inner join:
SELECT * FROM bands   // whatever table name write here is left table --> bands
INNER JOIN albums ON bands.id = albums.band_id; // whatever table name write here is right table --> albums



--in left join all the values of left table will be returned even if the values are null
--left join:
SELECT * FROM bands
LEFT JOIN albums ON bands.id = albums.band_id;
 

--in left join all the values of right table will be returned even if the values are null
--right table:
SELECT * FROM bands
RIGHT JOIN albums ON bands.id = albums.band_id;
 
 
SELECT * FROM albums
RIGHT JOIN bands ON bands.id = albums.band_id;

--Note: for the most part you're going to use inner and left joins only.


/*What is an Aggregate Function in SQL?
An aggregate function in SQL returns one value after calculating multiple values of a column. We often use aggregate functions with the GROUP BY and HAVING clauses of the SELECT statement.

Various types of SQL aggregate functions are:

Count()
Sum()
Avg()
Min()
Max()*/


SELECT AVG(release_year) FROM albums;
SELECT SUM(release_year) FROM albums;
SELECT COUNT(release_year) FROM albums;
SELECT MIN(release_year) FROM albums;
SELECT MAX(release_year) FROM albums;



--GROUP BY:
SELECT band_id, COUNT(band_id) FROM albums // multiple albums from single band so need to use group by 
GROUP BY band_id;   

--Alias and Group by:
SELECT b.name AS band_name, COUNT(a.id) AS num_albums
FROM bands as b
LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id;


--Having: Used after agergate function anf group by. We can not use WHERE before the GROUP BY so we need to use HAVING:
SELECT b.name AS band_name, COUNT(a.id) AS num_albums
FROM bands as b
LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY b.id
HAVING num_albums = 1;



--WHERE and HAVING in same query:
SELECT b.name AS band_name, COUNT(a.id) AS num_albums
FROM bands as b
LEFT JOIN albums AS a ON b.id = a.band_id
WHERE b.name = 'Linken Park'
GROUP BY b.id
HAVING num_albums = 1;
