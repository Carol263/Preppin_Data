-- PREPPIN_DATA 2023_WK01
-- Split the Transaction Code to extract the letters at the start of the transaction code. These identify the bank who processes the transaction 
-- Rename the new field with the Bank code 'Bank'. 
-- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values. 
-- Change the date to be the day of the week 
-- Different levels of detail are required in the outputs. You will need to sum up the values of the transactions in three ways :
   -- 1. Total Values of Transactions by each bank
   -- 2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
   -- 3. Total Values by Bank and Customer Code

SELECT 
    SPLIT_PART(transaction_code,'-',1) as Bank,
    CASE 
        WHEN online_or_in_person = 1 THEN 'Online'
        WHEN online_or_in_person = 2 THEN 'In-Person'
        END as online_or_in_person,
    DAYNAME (DATE (LEFT(transaction_date,10), 'dd/MM/yyyy')) as Day_of_Week,
   * 
   FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01;

   
-- 1. Total Values of Transactions by each bank
SELECT 
    SPLIT_PART(transaction_code,'-',1) as Bank,
    SUM(value) as total_value
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY SPLIT_PART(transaction_code,'-',1);

-- 2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
SELECT 
    SPLIT_PART(transaction_code,'-',1) as Bank,
    CASE 
        WHEN online_or_in_person = 1 THEN 'Online'
        WHEN online_or_in_person = 2 THEN 'In-Person'
        END as online_or_in_person,
    DAYNAME (DATE (LEFT(transaction_date,10), 'dd/MM/yyyy')) as Day_of_Week,
    SUM(VALUE) AS TOTAL_VALUE
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY 1,2,3;

-- 3. Total Values by Bank and Customer Code
SELECT 
    SPLIT_PART(transaction_code,'-',1) as Bank,
    Customer_code,
    SUM(value) as total_value
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY SPLIT_PART(transaction_code,'-',1),
customer_code;