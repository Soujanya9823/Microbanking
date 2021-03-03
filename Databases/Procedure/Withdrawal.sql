CREATE DEFINER=`root`@`localhost` PROCEDURE `withdrawals`(IN `Account_ID_arg` INT(9), IN `Amount_Withdrawed_arg` DECIMAL(12,2), IN `Withdrawal_Date_arg` DATE, IN `MB_ID_arg` INT(9))
    MODIFIES SQL DATA
BEGIN
 DECLARE acc_balance_arg decimal(12,2);
 DECLARE Withdrawal_ID_arg int(9);
 DECLARE balance_of_device_arg decimal(12,2);
 
 START TRANSACTION; 
 SELECT Account_Balance INTO acc_balance_arg from account where Account_ID = Account_ID_arg;
 if acc_balance_arg > Amount_Withdrawed_arg then
 SELECT acc_balance_arg - Amount_Withdrawed_arg into acc_balance_arg ;
 if acc_balance_arg > 0 then
 UPDATE account set Account_Balance = acc_balance_arg where Account_ID = Account_ID_arg;
 INSERT into mobiletransaction(Transaction_Date,Amount,MB_ID,Transaction_type) values(Withdrawal_Date_arg, Amount_Withdrawed_arg,MB_ID_arg, "W");
 SET Withdrawal_ID_arg = LAST_INSERT_ID();
 INSERT into account_mobile_transaction values(Account_ID_arg, Withdrawal_ID_arg);
 SELECT Account_Balance INTO acc_balance_arg from mobile_banking_unit where MB_ID = MB_ID_arg;
 SELECT acc_balance_arg - Amount_Withdrawed_arg into acc_balance_arg ;
 UPDATE mobile_banking_unit set Account_Balance = acc_balance_arg where MB_ID = MB_ID_arg;
 INSERT into withdrawals(Account_ID,Withdrawal_Date,Amount_Withdrawed) values(Account_ID_arg,Withdrawal_Date_arg,Amount_Withdrawed_arg);
/* INSERT into account_withdrawal values(Account_ID_arg, Withdrawal_ID_arg);*/
 COMMIT;
 END IF;
 END IF;
END