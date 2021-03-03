CREATE DEFINER=`root`@`localhost` PROCEDURE `deposits`(IN `Account_ID_arg` INT(9), IN `Amount_Deposited_arg` DECIMAL(12,2), IN `Deposit_Date_arg` DATE, IN `MB_ID_arg` INT(9))
    MODIFIES SQL DATA
BEGIN
 DECLARE acc_balance_arg decimal(12,2);
 DECLARE deposit_ID_arg int(9);

 START TRANSACTION; 
 SELECT Account_Balance INTO acc_balance_arg from account where Account_ID = Account_ID_arg;
 SELECT acc_balance_arg + Amount_Deposited_arg into acc_balance_arg ;
 UPDATE account set Account_Balance = acc_balance_arg where Account_ID = Account_ID_arg;
 INSERT into mobiletransaction(Transaction_Date,Amount,MB_ID,Transaction_type) values(Deposit_Date_arg, Amount_Deposited_arg,MB_ID_arg, "D");
 SET deposit_ID_arg = LAST_INSERT_ID();
 INSERT into account_mobile_transaction values(Account_ID_arg, deposit_ID_arg);
 SELECT Account_Balance INTO acc_balance_arg from mobile_banking_unit where MB_ID = MB_ID_arg;
 SELECT acc_balance_arg - Amount_Deposited_arg into acc_balance_arg ;
 UPDATE mobile_banking_unit set Account_Balance = acc_balance_arg where MB_ID = MB_ID_arg;
 COMMIT;
END