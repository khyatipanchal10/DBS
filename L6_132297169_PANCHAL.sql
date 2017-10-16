-- ***********************
-- Name: KHYATI PANCHAL
-- ID: 132297169
-- Date: JUNE 15, 2017
-- Purpose: Lab 6 : Execution of SELECT statement with the SUB-QUERIES
-- ***********************
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;


-- Ques-1. SET AUTOCOMMIT ON (do this each time you log on) so any updates, 
-- deletes and inserts are automatically committed before you exit from Oracle.

SET AUTOCOMMIT ON;


-- Ques-2. Create an INSERT statement to do this.  
-- Add yourself as an employee with a NULL salary, 0.2 commission_pct, in department 90, and Manager 100.  You started TODAY.

INSERT INTO EMPLOYEES(EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID)
VALUES(205,'KHYATI','PANCHAL','KPANCHAL10@MYSENECA.CA','6472095427','17-06-14','MK_MAN',0.4,201,100);


--Ques-3. Create an Update statement to: Change the salary of the employees with a last name of Matos and Whalen to be 2500.

UPDATE EMPLOYEES 
SET 
    SALARY =2500
WHERE 
    UPPER(LAST_NAME)=UPPER('Matos') OR LAST_NAME ='Whalen';


-- You must use subqueries for these questions (must minimize the number of tables being used in the main query)

-- Ques-4. Display the last names of all employees who are in the same department as the employee named Abel.

SELECT 
    LAST_NAME AS "Last_Name"
FROM 
    EMPLOYEES
WHERE 
    DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME ='Abel');


--Ques-5. Display the last name of the lowest paid employee(s)

SELECT 
    LAST_NAME AS "Last_Name" 
FROM 
    EMPLOYEES 
WHERE
    SALARY =(SELECT MIN(SALARY) FROM EMPLOYEES);
    

-- Ques-6. Display the city that the lowest paid employee(s) are located in.

SELECT CITY AS "City"
FROM 
    LOCATIONS
WHERE 
    LOCATION_ID IN (SELECT LOCATION_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID IN 
            (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE SALARY=(SELECT MIN(SALARY)
            FROM 
                EMPLOYEES)));

-- Ques-7. Display the last name, department_id, and salary of the lowest paid employee(s) in each department.  
-- Sort by Department_ID. (HINT: careful with department 60)


SELECT
    LAST_NAME AS "Last_Name",
    DEPARTMENT_ID AS "Department_ID",
    SALARY AS "Salary" 
FROM 
    EMPLOYEES 
WHERE 
    SALARY=(SELECT MIN(SALARY) FROM EMPLOYEES) AND DEPARTMENT_ID !=60 
ORDER BY DEPARTMENT_ID;


-- Ques-8. Display the last name of the lowest paid employee(s) in each city

SELECT
    LAST_NAME AS "Last_Name"
FROM
    EMPLOYEES
WHERE 
    SALARY IN(SELECT MIN(emp.SALARY) 
FROM 
    EMPLOYEES emp,DEPARTMENTS dpt,LOCATIONS loc
WHERE 
    emp.DEPARTMENT_ID=dpt.DEPARTMENT_ID AND dpt.DEPARTMENT_ID=loc.LOCATION_ID
GROUP BY CITY);


-- Ques-9. Display last name and salary for all employees who earn less than the lowest salary in ANY department.  
-- Sort the output by top salaries first and then by last name.

SELECT
    LAST_NAME AS "Last_Name",
    SALARY AS "Salary" 
FROM 
    EMPLOYEES 
WHERE SALARY < ANY (SELECT MIN(SALARY)
    FROM 
        EMPLOYEES 
    GROUP BY
    DEPARTMENT_ID) 
ORDER BY SALARY DESC,LAST_NAME;


-- Ques-10. Display last name, job title and salary for all employees whose salary matches any of the salaries from the IT Department. 
-- Do NOT use Join method.
-- Sort the output by salary ascending first and then by last_name
 
SELECT 
    LAST_NAME AS "last_name",
    JOB_ID AS "Job_ID",
    SALARY AS "Salary" 
FROM 
    EMPLOYEES 
WHERE SALARY=ANY (SELECT SALARY FROM EMPLOYEES emp,DEPARTMENTS dept WHERE emp.DEPARTMENT_ID=dept.DEPARTMENT_ID AND dept.DEPARTMENT_NAME='IT')
ORDER BY SALARY ASC, LAST_NAME ASC;
