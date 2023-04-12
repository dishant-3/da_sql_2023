--use sample1;
--create table strings (name varchar(50));
--delete from strings;
--insert into strings values ('Ankit Bansal'),('Ram Kumar Verma'),('Akshay Kumar Ak k'),('Rahul');

SELECT * FROM strings;

SELECT name, replace(name,'Ak','') as name_rep,
(LEN(name)-LEN(replace(name,'Ak','')))/LEN('Ak') AS count_occur
FROM strings;