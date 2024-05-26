-- PREPPIN_DATA 2023_WK03

-- For the transactions file:
    -- Filter the transactions to just look at DSB 
        -- These will be transactions that contain DSB in the Transaction Code field
    -- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values
    -- Change the date to be the quarter
    -- Sum the transaction values for each quarter and for each Type of Transaction (Online or In-Person) 

WITH CTE as (
    SELECT 
    -- SPLIT_PART(transaction_code,'-',1) as Bank,
     CASE 
            WHEN online_or_in_person = 1 THEN 'Online'
            WHEN online_or_in_person = 2 THEN 'In-Person'
            END as transaction,
            DATE_PART('QUARTER',DATE(transaction_date, 'dd/MM/yyyy hh24:MI:SS')) as Quarter,
    SUM(VALUE) as total_value
    FROM PD2023_WK01
    WHERE SPLIT_PART(transaction_code,'-',1) = 'DSB'
    GROUP BY 1,2
    )
        -- group by 1,2 is grouped by CASE 
        --     WHEN online_or_in_person = 1 THEN 'Online'
        --     WHEN online_or_in_person = 2 THEN 'In-Person'
        --     END


-- For the targets file:
    -- Pivot the quarterly targets so we have a row for each Type of Transaction and each Quarter 
    --  Rename the fields
    -- Remove the 'Q' from the quarter field and make the data type numeric 
    
-- Join the two datasets together 
    -- You may need more than one join clause!
-- Remove unnecessary fields
-- Calculate the Variance to Target for each row
    
 SELECT 
    transaction,
    REPLACE(T.quarter, 'Q','')::int as Quarter,
    V.TOTAL_VALUE,
    target,
    V.TOTAL_VALUE - target as  Variance_to_Target
FROM PD2023_WK03_TARGETS as T
    UNPIVOT(target FOR quarter IN (q1,q2,q3,q4))
    INNER JOIN CTE AS V on T.online_or_in_person = V.transaction and REPLACE(T.quarter, 'Q','')::int = V.quarter
