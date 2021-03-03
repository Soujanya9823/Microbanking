CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewAccount`(IN `User_ID_arg` INT(9), IN `Account_Type_ID` INT(2), IN `Initial_Deposit_Amount` DECIMAL(12,2), IN `Date_` DATE)
    MODIFIES SQL DATA
BEGIN
 DECLARE Account_ID_arg INT(9);	
 DECLARE Deposit_ID_arg INT(9);
 START TRANSACTION; 
 
 INSERT INTO ACCOUNT(AccountType_ID,User_ID,Account_Balance,Date_) VALUES (Account_Type_ID,User_ID_arg,Initial_Deposit_Amount,Date_);
 SET Account_ID_arg = LAST_INSERT_ID();
 INSERT INTO deposits(Account_ID,Deposit_Date,Amount_Deposited) VALUES(Account_ID_arg,Date_, Initial_Deposit_Amount);
 SET Deposit_ID_arg = LAST_INSERT_ID();
 INSERT INTO account_deposit VALUES(Account_ID_arg, Deposit_ID_arg);
 
 COMMIT;

END