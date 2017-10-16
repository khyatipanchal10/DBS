--Ques-1 
CREATE TABLE CLIENT(
 CLIENT_ID number(5) constraint CLIENTID_PK Primary Key,
   CLIENT_NAME varchar2(20) constraint CLIENT_NAME_NN not null constraint CLIENT_NAME_UK unique,
  CLIENT_ADDRESS varchar2(30),
   CLIENT_CITY varchar2(10) constraint CLIENT_CITY_NN not null,
   CLIENT_PROV char(2) constraint CLIENT_PROV_NN not null,
  CLIENT_POSTAL char(6) constraint CLIENT_POSTAL_NN not null);

--Ques-2
CREATE TABLE PROG(
    PROG_ID Number(5) Constraint PROG_ID_PK Primary key,
  PROG_NAME varchar2(30) Constraint PROG_NAME_NN Not null,
  PROG_OFFICE char(4) constraint PROG_OFFICE_NN not null,
  PROG_PHONE char(10));


--Ques-3
CREATE TABLE PROJECT(
  PROJECT_ID number(6) constraint PROJECT_ID_PK primary key,
  PROJ_NAME varchar2(40) constraint PROJ_NAME_NN not null constraint PROJ_NAME_UK unique,
   COMPLETE_DATE date,
  TOTAL_COST number(8,2) constraint TOTAL_COST_CK check (TOTAL_COST > 0),
   CLIENT_ID Number(5) constraint CLIENT_ID_NN not null constraint CLIENT_ID_FK references client (CLIENT_ID));


--Ques-4
CREATE TABLE PROJECT_STAFF(
   PROG_ID Number(5),
    PROJECT_ID number(6),
    WEEK_YEAR char(5),
    HOURS_WORKED Number(4,1) constraint HOURS_WORKED_NN not null,
   constraint PROG_ID_FK Foreign Key (PROG_ID) references PROG(PROG_ID),
   constraint PROJECT_ID_FK Foreign Key (PROJECT_ID) references PROJECT(PROJECT_ID),
    constraint WEEK_YEAR_PK Primary key (WEEK_YEAR),
   constraint HOURS_WORKED_CK check (HOURS_WORKED > 0));
   
 
