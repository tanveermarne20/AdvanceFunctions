--====================================================================================================
-- 01.What is view?
--Ans.View is a database object which is created over an SQL query
--      View just represent data that is just return by sql querry
--      View does not stores data,but every time you execute view
--      it just execute the sql querry
--      View is like a virtual table     
--      The difference between Table and View is 
--        The table can store data but view does not
--         Data privary
--         Without sharing entire sql code to client
--           we can share only small code using view
SELECT *FROM TB_CUSTOMER_DATA;
SELECT *FROM TB_PRODUCT_INFO;
SELECT *FROM TB_ORDER_DETAILS;


--Fetch the order summuray(to be given to client)
CREATE OR REPLACE VIEW ORDER_SUMMARY_VIEW
AS
SELECT 
O.ORDER_ID,
O.PURCHASE_DATE,
P.PRODUCT_NAME,
C.CUST_NAME,
(P.PRICE * O.QUANTITY)-((O.DISC_PERCENT / 100.0)*(P.PRICE * O.QUANTITY) ) 
AS TOTAL_COST
FROM TB_CUSTOMER_DATA C JOIN TB_ORDER_DETAILS O
ON (C.CUST_ID=O.CUST_ID)
JOIN TB_PRODUCT_INFO P 
ON(O.PROD_ID=P.PROD_ID);



--Here order_summary_view is just a view name
--It does not store data
--It store only DDL that is structure of data
--Every time we call this view ,Internally SQL will execute the querry
--that was used to create that view
--View basically does not improve a performance 
--It just another way to execute the sql querry
SELECT *
FROM ORDER_SUMMARY_VIEW;


CREATE OR REPLACE VIEW PRODUCT_DETAILS_VIEW
AS
SELECT
O.PROD_ID,O.QUANTITY,
P.PRODUCT_NAME AS PR,
P.BRAND,
P.PRICE
FROM TB_PRODUCT_INFO P JOIN TB_ORDER_DETAILS O
ON (O.PROD_ID=P.PROD_ID);


SELECT *
FROM PRODUCT_DETAILS_VIEW;


--WHY TO USE VIEW?
--WE CREATE NEW USER FOR THAT PARTICULAR CLIENT
--AND THAT USER ONLY HAVE SPECIFIC ACCESS FOR THE DATA
--THAT ONLY WE HAVE TO SHOW THEM

--What is the main purpose of using view?
--We achieve security using views
 --By hiding the querry used to generate the view
--Instead of sharing entire sql querry ,we just shared view
--we created new user for the client and than we gave hIm only READ ACCESS TO SEE
--the data,so he will not be able to see what was the sql code/logic
--He is only able to see data in it ,after executing view
--THIS IS THE MOST POWERFUL ADVANTAGE OF VIEW.


--To Simplify complex sql querries
--SHARING A VIEW IS BETTER THAN SHARING A COMPLEX QUERRY TO BUSINESS MANAGER
--BECASUE BM WILL GET SCARED TO COMPLEX QUERRY
--AVOID REWRITING COMPLEX QUERRY MULTIPLE TIMES
--GIVES LATEST DATA

--There are certain rules regarding VIEW
--YOU CANNOT CHANGE ORDER OF COLUMN
--YOU CANNOT CHANGE COLUMN DATATYPE
--YOU CANNOT RENAME COLUMNS

CREATE USER JAMES IDENTIFIED BY root;
GRANT CREATE SESSION TO JAMES;
GRANT SELECT ON ORDER_SUMMARY_VIEW TO James;
GRANT SELECT ON PRODUCT_DETAILS_VIEW TO JAMES;











SELECT *FROM TB_PRODUCT_INFO;

CREATE OR REPLACE VIEW EXPENSIVE_PRODUCT_VIEW
AS
SELECT *FROM TB_PRODUCT_INFO
WHERE PRICE>1000;

--When you change the structured of the table
--You need to reexecute the view to get new changes
ALTER TABLE TB_PRODUCT_INFO
ADD PROD_CONFIG VARCHAR2(100);

--VIEW WILL ALWAYS SHOW YOU THE LATEST DATA
SELECT *
FROM EXPENSIVE_PRODUCT_VIEW;
GRANT SELECT ON EXPENSIVE_PRODUCT_VIEW TO JAMES;





