-- ***********************
-- Name: KHYATI PANCHAL
-- ID: 132297169
-- Date: MAY 30, 2017
-- Purpose: Lab 4 : Execution of SELECT statement with the GROUP BY clause.
-- ***********************
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

-- QUES 1.Display the difference between the Average pay and Lowest pay in the company. 
-- Name this result Real Amount. 
-- Format the output as currency with 2 decimal places.

SELECT 
    TO_CHAR(ROUND(AVG(SALARY) - MIN(SALARY),2),'$999,999.999') AS "REAL AMOUNT"
FROM EMPLOYEES;


--  QUES 2.Display the department number and Highest, Lowest and Average pay per each department. 
--  Name these results High, Low and Avg.  Sort the output so that the department with highest average salary is shown first. 
--  Format the output as currency where appropriate.

SELECT 
    DEPARTMENT_ID AS "DEPARTMENT NUMBER",
    TO_CHAR(ROUND(MAX(SALARY),2),'$999,999.99') AS "HIGHEST PAY",
    TO_CHAR(ROUND(MIN(SALARY),2),'$999,999.999') AS "LOWEST PAY", 
    TO_CHAR(ROUND(AVG(SALARY),2),'$999,999.999') AS "AVERAGE PAY" 
    FROM 
        EMPLOYEES 
        GROUP BY DEPARTMENT_ID
    ORDER BY MAX(SALARY) DESC; 

--  QUES 3.Display how many people work the same job in the same department. 
--  Name these results Dept#, Job and How Many. Include only jobs that involve more than one person.  
--  Sort the output so that jobs with the most people involved are shown first.

SELECT
    DEPARTMENT_ID AS "DEPT#",
    JOB_ID AS "JOB",
    COUNT(EMPLOYEE_ID) AS "HOW MANY"    
    FROM 
        EMPLOYEES
    GROUP BY JOB_ID,DEPARTMENT_ID HAVING COUNT(JOB_ID)>1
    ORDER BY "HOW MANY" DESC;

--  QUES 4.For each job title display the job title and total amount paid each month for this type of the job. 
--  Exclude titles AD_PRES and AD_VP and also include only jobs that require more than $12,000.  
--  Sort the output so that top paid jobs are shown first.

SELECT JOB_ID AS "JOB_TITLE",
    TO_CHAR(ROUND(SUM(SALARY),2),'$999,999.99') AS "TOTAL AMOUNT"
    FROM 
        EMPLOYEES
        GROUP BY JOB_ID 
        HAVING(JOB_ID != 'AD_PRES' AND JOB_ID != 'AD_VP') AND SUM(SALARY) > '12000'
        ORDER BY "TOTAL AMOUNT" DESC;

--  QUES 5.For each manager number display how many persons he / she supervises. 
--  Exclude managers with numbers 100, 101 and 102 and also include only those managers that supervise more than 2 persons.  
--  Sort the output so that manager numbers with the most supervised persons are shown first.

SELECT MANAGER_ID AS "MANAGERS",COUNT(EMPLOYEE_ID) AS "EMPLOYEE COUNT"
FROM EMPLOYEES
GROUP BY MANAGER_ID
HAVING(MANAGER_ID !='100' AND MANAGER_ID !='101' AND MANAGER_ID !='102') AND COUNT(EMPLOYEE_ID) > 2
ORDER BY "EMPLOYEE COUNT" DESC;


--  QUES 6.For each department show the latest and earliest hire date, BUT
-- exclude departments 10 and 20 
-- exclude those departments where the last person was hired in this century. 
-- Sort the output so that the most recent, meaning latest hire dates, are shown first.

SELECT
    DEPARTMENT_ID AS "DEPARTMENT",
    MAX(HIRE_DATE) AS "LATEST",
    MIN(HIRE_DATE) AS "EARLIEST"
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID 
    HAVING(DEPARTMENT_ID !=10 AND DEPARTMENT_ID !=20);
    
    
SELECT
    DEPARTMENT_ID AS "DEPARTMENT",
    MAX(HIRE_DATE) AS "LATEST",
    MIN(HIRE_DATE) AS "EARLIEST"
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID HAVING(DEPARTMENT_ID !=10 AND DEPARTMENT_ID !=20)AND MAX(HIRE_DATE) < '01-JAN-00';
   

SELECT
    DEPARTMENT_ID AS "DEPARTMENT",
    MAX(HIRE_DATE) AS "LATEST",
    MIN(HIRE_DATE) AS "EARLIEST"
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID HAVING(DEPARTMENT_ID !=10 AND DEPARTMENT_ID !=20)AND MAX(HIRE_DATE) < '01-JAN-00'
    ORDER BY "LATEST" DESC;
