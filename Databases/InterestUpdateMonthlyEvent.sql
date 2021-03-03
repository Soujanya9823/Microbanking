use microbanking;
Drop event if exists Interest_Update ;
CREATE EVENT Interest_Update ON SCHEDULE EVERY 1 MONTH DO 
UPDATE account inner join account_type on account.AccountType_ID = account_type.AccountType_ID SET Account_Balance =  Account_Balance + (Account_Balance * InterestRate/100) ;