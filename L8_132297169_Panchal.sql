create table MY_EMPLOYEE(
ID number(4) constraint id_NN NOT NULL,
Last_Name varchar2(25),
First_Name varchar2(25),
User_Id varchar2(8),
Salary number(9,2));

Insert into MY_EMPLOYEE values(126,'Popov','Olga','opopov',8500);
Insert into MY_EMPLOYEE values(127,'Chen','Ling','lcheng',14500);
Insert into MY_EMPLOYEE values(128,'Dunn','David','ddunn','');

Insert into MY_EMPLOYEE(ID,Last_Name,First_Name,User_Id,Salary) values(108,'Preston','Scott','spreston','');
Insert into MY_EMPLOYEE(ID,Last_Name,First_Name,User_Id,Salary) values(109,'Gomez','Rita','rgomez','');

SELECT * FROM MY_EMPLOYEE;

COMMIT;

Insert into MY_EMPLOYEE(select EMPLOYEE_ID, FIRST_NAME, LAST_NAME,'generic',SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG'); 

COMMIT;

UPDATE MY_EMPLOYEE set Last_Name= 'Jones',Salary = 9000 where Last_Name= 'Gomez'; 

update MY_EMPLOYEE set Salary = (Salary + 2000) where Salary < 10500;

SELECT * FROM MY_EMPLOYEE;

COMMIT;

Insert into MY_EMPLOYEE values(128,'Bob','Thomas','',13500);

delete from MY_EMPLOYEE where Salary > (select salary from EMPLOYEES where LAST_NAME = 'Higgins');

savepoint ONE;

SELECT * FROM MY_EMPLOYEE;

update MY_EMPLOYEE set Salary = (Salary - 1000) where salary >(select salary from MY_EMPLOYEE where upper(Last_Name) = 'POPOV');

savepoint TWO;

SELECT  * FROM MY_EMPLOYEE;

delete MY_EMPLOYEE where ID > 120;

rollback to TWO;

commit;

