---- ***********************
---- Name: Khyati Panchal
---- ID: 132297169
---- Date: May 23rd, 2017
---- Purpose: the use of SELECT command and learning the interfaces for both SQL Developer and
---- SQL*PLUS and introduces the use of single-line functions.
---- ***********************

select * FROM EMPLOYEES;
select * from LOCATIONS;

---- QUES-1.Write a query to display the tomorrow’s date in the following format:
---- September 28th of year 2016
---- Your result will depend on the day when you RUN/EXECUTE this query.  Label the column Tomorrow.
---- Advanced Option:  Define an SQL variable called “tomorrow”, assign it a value of tomorrow’s date, use it in an SQL statement. 
---- Don’t forget to undefine it!


SELECT TO_CHAR
    (SYSDATE + 1, 'Month dd"th of year "YYYY"') AS "TOMORROW"
     FROM DUAL ;
     
     
---- QUES-2.For each employee in departments 20, 50 and 60 display last name, first name, 
---- salary, and salary increased by 5% and expressed as a whole number.  Label the column Good Salary.  
---- Also add a column that subtracts the old salary from the new salary and multiplies by 12. 
---- Label the column "Annual Pay Increase".

select 
    last_name AS "LAST_NAME", first_name AS "FIRST_NAME" , 
    salary AS "SALARY", salary+(salary *0.05) AS "GOOD SALARY",
    ((salary+(salary * 0.05)-salary)*12) AS "ANNUAL PAY INCREASE" 
    FROM 
        EMPLOYEES 
    WHERE DEPARTMENT_ID IN(20,50,60);


---- QUES-3.Write a query that displays the employee’s Full Name and Job Title in the following format:
---- DAVIES, CURTIS is ST_CLERK nly employees whose last name ends with S and first name starts with C or K.  
---- Give this column an appropriate label like Person and Job.  Sort the result by the employees’ last names.


select 
    last_name || ', ' || first_name || ' is ' AS "PERSON", job_ID AS "JOB"
    FROM 
        EMPLOYEES 
    WHERE last_name LIKE '%s' AND (first_name LIKE 'C%' OR first_name LIKE 'K%') 
    ORDER BY last_name;
    
    
---- QUES-4.For each employee hired before 1992, display the employee’s last name, 
---- hire date and calculate the number of YEARS between TODAY and the date the employee was hired.
---- a.Label the column Years worked. 

select 
    last_name, hire_date,
    ((SYSDATE-hire_date)/365.24) AS "WORKED YEARES" 
    FROM 
        EMPLOYEES 
    WHERE hire_date< '31-JAN-1992';

---- b.Order your results by the number of years employed.  Round the number of years employed up to the closest whole number.

select 
    last_name, hire_date,
    ROUND((SYSDATE-hire_date)/365.24) AS "WORKED YEARES" 
    FROM 
        EMPLOYEES 
    WHERE hire_date< '31-JAN-1992' 
    ORDER BY 3 DESC;


---- QUES-5.Create a query that displays the city names, country codes and state province names, 
---- but only for those cities that starts with S and has at least 8 characters in their name. 
---- If city does not have a province name assigned, then put Unknown Province.  
---- Be cautious of case sensitivity!

select 
    city AS "CITY",
    postal_code AS "COUNTRY_CODES",
    NVL(state_province,'Unknown Province') AS "STATE/PROVINCE" 
    FROM 
        LOCATIONS 
    WHERE city LIKE 'S%' AND LENGTH(city)>=8;
    

---- 6.	Display each employee’s last name, hire date, and salary review date, which is the first Thursday after a year of service, 
---- but only for those hired after 1997.  
---- a.Label the column REVIEW DAY.

 select last_name AS "LAST_NAME", 
    hire_date AS "HIRE_DATE", 
    NEXT_DAY(ADD_MONTHS(hire_date,12),'Thursday')AS "REVIEW DAY"
 FROM 
    EMPLOYEES 
WHERE hire_date >='31-DEC-1997';

---- b.Format the dates to appear in the format like:
---- THURSDAY, August the Thirty-First of year 1998

select last_name AS "LAST_NAME", 
    hire_date AS "HIRE_DATE", 
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 12),'THURSDAY'),'fmDay, Month "the" Ddspth "of" "year" YYYY')  AS "REVIEW DAY"
 FROM 
    EMPLOYEES 
WHERE hire_date >='31-DEC-1997';

---- c.Sort by review date

 select last_name AS "LAST_NAME", 
    hire_date AS "HIRE_DATE", 
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 12),'THURSDAY'),'fmDay, Month "the" Ddspth "of" "year" YYYY')  AS "REVIEW_DAY"
 FROM 
    EMPLOYEES 
WHERE hire_date >='31-DEC-1997' ORDER BY REVIEW_DAY;
