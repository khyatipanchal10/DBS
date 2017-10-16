-- ***********************
-- Name: KHYATI PANCHAL
-- ID: 132297169
-- Date: JUNE 6, 2017
-- Purpose: Lab 5 : Execution of SELECT statement with the JOINS
-- ***********************
SELECT * FROM EMPLOYEES e;
SELECT * FROM DEPARTMENTS d;
SELECT * FROM LOCATIONS l;

-- PART A - SIMPLE JOINS.

-- QUES-1.	Display the department name, city, street address and postal code for
-- departments sorted by city and department name.
SELECT 
    d.DEPARTMENT_NAME AS "DEPT_NAME", 
    l.CITY AS "CITY", 
    l.STREET_ADDRESS AS "STREET ADDRESS", 
    l.POSTAL_CODE AS "POSTAL CODE"
    FROM 
        DEPARTMENTS d
    INNER JOIN LOCATIONS l USING (LOCATION_ID)
    ORDER BY l.CITY, d.DEPARTMENT_NAME;


-- QUES-2.Display full name of employees as a single field using format of Last, First, 
-- their hire date, salary, department name and city, but only for departments with names 
-- starting with an A or S sorted by department name and employee name. 
SELECT 
    e.LAST_NAME || ' ' || FIRST_NAME as "NAME", 
    e.HIRE_DATE AS "HIRE_DATE", 
    e.SALARY AS "SALARY", 
    d.DEPARTMENT_NAME AS "DEPARTMENT_NAME", 
    l.CITY AS "CITY"
    FROM 
        EMPLOYEES e
    JOIN DEPARTMENTS d USING (DEPARTMENT_ID)
    JOIN LOCATIONS l USING (LOCATION_ID)
    WHERE d.DEPARTMENT_NAME LIKE 'A%' OR d.DEPARTMENT_NAME LIKE 'S%'
    ORDER BY d.DEPARTMENT_NAME, NAME;


-- QUES-3.Display the full name of the manager of each department in states/provinces of Ontario, 
-- California and Washington along with the department name, city, postal code and province name.   
-- Sort the output by city and then by department name.
SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS "MANAGER", 
    DEPARTMENT_NAME AS "DEPARTMENT_NAME", 
    CITY AS "CITY", 
    POSTAL_CODE AS "POSTAL_CODE",
    STATE_PROVINCE AS "STATE_PROVINCE"
    FROM EMPLOYEES e,DEPARTMENTS d 
 JOIN LOCATIONS l USING (LOCATION_ID)
WHERE e.EMPLOYEE_ID = d.MANAGER_ID AND LOWER(STATE_PROVINCE)  IN ('ontario',  'california', 'washington')
ORDER BY CITY, DEPARTMENT_NAME;


-- QUES-4.Display employee’s last name and employee number along with their manager’s last name and manager number. 
-- Label the columns Employee, Emp#, Manager, and Mgr# respectively.
SELECT 
    mgr.LAST_NAME AS "EMPLOYEE", 
    mgr.EMPLOYEE_ID AS "EMP#", 
    emp.LAST_NAME as "MANAGER",  
    mgr.MANAGER_ID as "MGR#"
    FROM 
        EMPLOYEES mgr JOIN EMPLOYEES emp ON (mgr.MANAGER_ID = emp.EMPLOYEE_ID);


-- PART B - NON SIMPLE JOINS.

-- QUES-5.Display the department name, city, street address, postal code and country name for all Departments. 
-- Use the JOIN and USING form of syntax.Sort the output by department name descending.

SELECT 
    d.DEPARTMENT_NAME AS "DEPT_NAME", 
    l.CITY AS "CITY", 
    l.STREET_ADDRESS AS "STREET ADDRESS", 
    l.POSTAL_CODE AS "POSTAL CODE",
    c.COUNTRY_NAME AS "COUNTRY NAME"
    FROM 
        DEPARTMENTS d
    INNER JOIN LOCATIONS l USING (LOCATION_ID)
    JOIN COUNTRIES c USING(COUNTRY_ID)
    ORDER BY d.DEPARTMENT_NAME desc;
    

-- QUES-6.Display full name of the employees, their hire date and salary together with their department name, 
-- but only for departments which names start with A or S. Full name should be in format of:
---- a.	First / Last. Use the JOIN and ON form of syntax.
SELECT 
    e.FIRST_NAME || ' / ' || e.LAST_NAME as "NAME", 
    e.HIRE_DATE AS "HIRE_DATE", 
    e.SALARY AS "SALARY", 
    d.DEPARTMENT_NAME AS "DEPARTMENT_NAME"
     FROM 
        EMPLOYEES e 
    INNER JOIN DEPARTMENTS d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID AND (d.DEPARTMENT_NAME LIKE 'A%' OR d.DEPARTMENT_NAME LIKE 'S%'));


---- b.	Sort the output by department name and then by last name.
SELECT 
    e.FIRST_NAME || ' /  ' || e.LAST_NAME as "NAME", 
    e.HIRE_DATE AS "HIRE_DATE", 
    e.SALARY AS "SALARY", 
    d.DEPARTMENT_NAME AS "DEPARTMENT_NAME"
     FROM 
        EMPLOYEES e 
    INNER JOIN DEPARTMENTS d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID AND (d.DEPARTMENT_NAME LIKE 'A%' OR d.DEPARTMENT_NAME LIKE 'S%'))
    ORDER BY d.DEPARTMENT_NAME, e.LAST_NAME;



-- QUES-7.Rewrite the previous question by using Standard (Old -- prior to Oracle9i) Join method.
SELECT 
    e.FIRST_NAME || ' /  ' || e.LAST_NAME as "NAME", 
    e.HIRE_DATE AS "HIRE_DATE", 
    e.SALARY AS "SALARY", 
    d.DEPARTMENT_NAME AS "DEPARTMENT_NAME"
     FROM 
        EMPLOYEES e 
    INNER JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
    WHERE d.DEPARTMENT_NAME LIKE 'A%' OR d.DEPARTMENT_NAME LIKE 'S%'
    ORDER BY d.DEPARTMENT_NAME, e.LAST_NAME;




-- QUES-8.Display full name of the manager of each department in provinces Ontario, California and Washington plus department 
-- name, city, postal code and province name. Full name should be in format as follows:
---- a.	Last, First.  Use the JOIN and ON form of syntax.
SELECT 
    e.LAST_NAME || ', ' || e.FIRST_NAME AS "MANAGER", 
    d.DEPARTMENT_NAME AS "DEPARTMENT_NAME", 
    l.CITY AS "CITY", 
    l.POSTAL_CODE AS "POSTAL_CODE",
    l.STATE_PROVINCE AS "STATE_PROVINCE"
    FROM EMPLOYEES e 
    INNER JOIN DEPARTMENTS d 
  JOIN LOCATIONS l USING (LOCATION_ID) ON (e.EMPLOYEE_ID = d.MANAGER_ID AND (LOWER(STATE_PROVINCE)  IN ('ontario',  'california', 'washington')));



---- b.	Sort the output by city and then by department name. 

SELECT 
    e.LAST_NAME || ', ' || e.FIRST_NAME AS "MANAGER", 
    d.DEPARTMENT_NAME AS "DEPARTMENT_NAME", 
    l.CITY AS "CITY", 
    l.POSTAL_CODE AS "POSTAL_CODE",
    l.STATE_PROVINCE AS "STATE_PROVINCE"
    FROM EMPLOYEES e 
    INNER JOIN DEPARTMENTS d 
  JOIN LOCATIONS l USING (LOCATION_ID) ON (e.EMPLOYEE_ID = d.MANAGER_ID AND (LOWER(STATE_PROVINCE)  IN ('ontario',  'california', 'washington')))
ORDER BY l.CITY, d.DEPARTMENT_NAME;



-- QUES-9.Rewrite the previous question by using Standard (Old -- prior to Oracle9i) Join method.
SELECT 
    e.LAST_NAME || ', ' || e.FIRST_NAME AS "MANAGER", 
    d.DEPARTMENT_NAME AS "DEPARTMENT_NAME", 
    l.CITY AS "CITY", 
    l.POSTAL_CODE AS "POSTAL_CODE",
    l.STATE_PROVINCE AS "STATE_PROVINCE"
    FROM EMPLOYEES e, DEPARTMENTS d 
  JOIN LOCATIONS l USING (LOCATION_ID) WHERE (e.EMPLOYEE_ID = d.MANAGER_ID AND (LOWER(STATE_PROVINCE)  IN ('ontario',  'california', 'washington')))
ORDER BY l.CITY, d.DEPARTMENT_NAME;



-- QUES-10.Display the department name and Highest, Lowest and Average pay per each department. Name these results High, Low and Avg.
---- a.	Use JOIN and ON form of the syntax.
SELECT
    DEPARTMENT_NAME AS "DEPARTMENT NAME",
    TO_CHAR(ROUND(MAX(e.SALARY),2),'$999,999.99') AS "HIGH",
    TO_CHAR(ROUND(MIN(e.SALARY),2),'$999,999.99') AS "LOW",
    TO_CHAR(ROUND(AVG(e.SALARY),2),'$999,999.99') AS "AVG"
    FROM DEPARTMENTS d
    JOIN EMPLOYEES e ON(d.DEPARTMENT_ID = e.DEPARTMENT_ID)
    GROUP BY DEPARTMENT_NAME;


---- b.	Sort the output so that department with highest average salary are shown first.
SELECT
    DEPARTMENT_NAME AS "DEPARTMENT NAME",
    TO_CHAR(ROUND(MAX(e.SALARY),2),'$999,999.99') AS "HIGH",
    TO_CHAR(ROUND(MIN(e.SALARY),2),'$999,999.99') AS "LOW",
    TO_CHAR(ROUND(AVG(e.SALARY),2),'$999,999.99') AS "AVG"
    FROM DEPARTMENTS d
    JOIN EMPLOYEES e ON(d.DEPARTMENT_ID = e.DEPARTMENT_ID)
    GROUP BY DEPARTMENT_NAME
    ORDER BY "AVG" DESC;



-- QUES-11.Display the employee last name and employee number along with their manager’s last name and manager number. 
-- Label the columns Employee
-- a.mp#, Manager, and Mgr#, respectively. Include also employees who do

SELECT 
    e.LAST_NAME AS "EMPLOYEE", 
    e.EMPLOYEE_ID AS "EMP#", 
    mgr.LAST_NAME as "MANAGER",  
    e.MANAGER_ID as "MGR#"
    FROM 
        EMPLOYEES e 
    JOIN EMPLOYEES mgr ON (e.MANAGER_ID = mgr.EMPLOYEE_ID);
        
--b.NOT have a manager and also employees who do NOT supervise anyone (or you could say managers without employees to supervise).
SELECT 
    e.LAST_NAME AS "EMPLOYEE", 
    e.EMPLOYEE_ID AS "EMP#", 
    mgr.LAST_NAME as "MANAGER",  
    e.MANAGER_ID as "MGR#"
    FROM 
        EMPLOYEES e 
    FULL OUTER JOIN EMPLOYEES mgr ON (e.MANAGER_ID = mgr.EMPLOYEE_ID);
