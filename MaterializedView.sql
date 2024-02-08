--What is materialized view?
--It is a database object which is created over a database object
--When you create a materialized view it does two things
--Stores the sql querry which is used to create a materialized view
--Stores the data that is return from sql querry
--and this second reason why materialized view increases performance

--What happens is
--Every time you execute the materialized view its not going to internally
--execute the sql querry that is associated with materialized view
--but its only going to return the data that is already stored in 
--materialized view,AND This is the main reason why performance of 
--materialized view damn good.

------============================================================
--TABLE CREATION FOR MATERIALISED VIEW

CREATE TABLE RANDAM_TAB(
ID NUMBER,
VAL NUMBER);


-- Using DBMS_RANDOM.VALUE to generate random numbers between 0 and 1
INSERT INTO RANDAM_TAB (ID, VAL)
SELECT
    rownum, 
    DBMS_RANDOM.VALUE
FROM
    dual
CONNECT BY
    level <= 100000;
    


--WE HAVE CREATED MATERIALIZED VIEW HERE    
CREATE MATERIALIZED VIEW MV_RANDAM_TAB
AS
SELECT AVG(VAL),COUNT(*)
FROM RANDAM_TAB
GROUP BY ID;
    
SELECT *
FROM MV_RANDAM_TAB;        --TIME TABKEN TO RETRIVE-->0.0002
SELECT *
FROM VWW_RANDAM_TAB;       --TIME TABKEN TO RETRIVE-->0.095



--WE HAVE CREATED VIEW HERE
CREATE OR REPLACE  VIEW VWW_RANDAM_TAB
AS
SELECT AVG(VAL) AS AVERAGE,COUNT(*) AS CNT
FROM RANDAM_TAB
GROUP BY ID;
    
    
--IT CLEARLY INDICATES THAT MATERIALIZED VIEW IS FASTER THAN VIEW    


--HOW TO REFRESH MATERIALIZED VIEW IN ORACLE SQL DEVELOPER.
EXEC DBMS_MVIEW.REFRESH('MV_RANDAM_TAB', 'C');


 