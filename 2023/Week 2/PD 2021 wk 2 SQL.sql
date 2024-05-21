-- In the Transactions table, there is a Sort Code field which contains dashes. We need to remove these so just have a 6 digit string 
-- Use the SWIFT Bank Code lookup table to bring in additional information about the SWIFT code and Check Digits of the receiving bank account 
-- Add a field for the Country Code 
    -- Hint: all these transactions take place in the UK so the Country Code should be GB
-- Create the IBAN as above 
    -- Hint: watch out for trying to combine string fields with numeric fields - check data types
-- Remove unnecessary fields 

SELECT 
    -- 'GB' as country_code,
    -- check_digits,
    -- swift_code,
    -- REPLACE (SORT_CODE,'-', '') as sort_code,
    -- account_number,
    transaction_id,
    'GB' || check_digits || swift_code || REPLACE (SORT_CODE,'-', '') || account_number::varchar (20) as iban 
    --S.*
FROM PD2023_WK02_TRANSACTIONS AS T
    INNER JOIN PD2023_WK02_SWIFT_CODES AS S on T.BANK = S.BANK