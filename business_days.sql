use sample1;
--create table tickets
--(
--ticket_id varchar(10),
--create_date date,
--resolved_date date
--);
--delete from tickets;
--insert into tickets values
--(1,'2022-08-01','2022-08-03')
--,(2,'2022-08-01','2022-08-12')
--,(3,'2022-08-01','2022-08-16');
--create table holidays
--(
--holiday_date date
--,reason varchar(100)
--);
--delete from holidays;
--insert into holidays values
--('2022-08-11','Rakhi'),('2022-08-15','Independence day');

SELECT * FROM tickets;
SELECT * FROM holidays;

-- Task is to calculate business days between create_date and resolved_date

-- Step1 Exclude weekends
SELECT *, DATEDIFF(day,create_date,resolved_date) AS actual_days,
DATEDIFF(week,create_date,resolved_date) AS week_diff,
DATEDIFF(day,create_date,resolved_date)-2*DATEDIFF(week,create_date,resolved_date) AS excluded_weekend
FROM tickets;

-- SELECT DATEPART(week,CAST('2023-01-22' AS DATE)) AS week_part;
 SELECT DATEPART(WEEKDAY,'2023-01-01' ) AS sun_weekday_part; --o/p 1
 SELECT DATEPART(WEEKDAY,'2023-01-07') AS sat_weekday_part;  --o/p 7
 SELECT DATEPART(week, '2007-04-21 '), DATEPART(weekday, '2007-04-21 ')
 SELECT DATEDIFF(DAY,'2023-01-19','2023-01-23') AS no_of_days
-- Step 2 Remove holidays
WITH  festive_holi AS
(
SELECT ticket_id,create_date,resolved_date,COUNT(holiday_date) AS cnt_holidays
FROM tickets AS t
LEFT JOIN holidays AS h
ON h.holiday_date BETWEEN create_date AND resolved_date
GROUP BY ticket_id,create_date,resolved_date
)
SELECT ticket_id,create_date,resolved_date,DATEDIFF(day,create_date,resolved_date)-2*DATEDIFF(week,create_date,resolved_date)-cnt_holidays AS bus_days_to_resolve
FROM festive_holi;

-- IF holiday_dates are on weekends
SELECT CASE WHEN DATEPART(WEEKDAY,holiday_date) IN (1,7) THEN 1 ELSE 0 END AS weekend_holid_flag
FROM holidays

-- JUST ADD THE ABOVE FLAG AND TAKE ONLY HOLIDAYS WHEN flag = 0