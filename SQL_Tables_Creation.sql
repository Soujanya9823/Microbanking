create table account(
	Account_ID int(9) auto_increment,
    AccountType_ID int(2),
    User_ID int(9),
    Account_Balance numeric(12,2),
    PRIMARY KEY(Account_ID),
    FOREIGN KEY (User_ID) REFERENCES user_details(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (AccountType_ID) REFERENCES account_type(AccountType_ID) ON DELETE CASCADE
);


create table Mobile_Banking_Unit(
	MB_ID int(9) auto_increment,
    Account_Balance numeric(12,2),
    Password varchar(40) NOT NULL ,
    PRIMARY KEY(MB_ID)
);

create table user_details(
    User_ID int(9) auto_increment,
    First_Name varchar(30) NOT NULL,
    Last_Name varchar(30) NOT NULL,
    DOB date NOT NULL,
    Email varchar(100),
    Address varchar(200),   
    Contact_No int(10) NOT NULL, 
    PRIMARY KEY(User_ID)
);

create table FD_type(
	FD_type_ID int(2) auto_increment,
    InterestRate numeric(5,2) NOT NULL,
    FD_Name varchar(20),
    PRIMARY KEY(FD_type_ID)
);

create table account_type(
	AccountType_ID int(2) auto_increment,
    InterestRate numeric(5,2) NOT NULL,
    Minimum_Balance numeric(6,2) NOT NULL,
    Account_Name varchar(20),
    PRIMARY KEY(AccountType_ID)
);

/*for bank record*/

create table deposits(
	Deposit_ID int(9) auto_increment,
    Account_ID int(9) ,
    Deposit_Date date NOT NULL,
    Amount_Deposited numeric(12,2) NOT NULL,
    PRIMARY KEY(Deposit_ID),
    FOREIGN KEY (Account_ID) REFERENCES account(Account_ID) ON DELETE CASCADE
);


/*for bank record*/

create table withdrawals(
	Withdrawal_ID int(9) auto_increment,
    Account_ID int(9),
    Withdrawal_Date date NOT NULL,
    Amount_Withdrawed numeric(12,2) NOT NULL,
    PRIMARY KEY(Withdrawal_ID),
    FOREIGN KEY (Account_ID) REFERENCES account(Account_ID) ON DELETE CASCADE   
);

/*for bank record*/

create table mobiletransaction(
	Transaction_ID int(9) auto_increment,
    Transaction_Date date NOT NULL,
    Amount numeric(12,2) NOT NULL,
    MB_ID int(9) NOT NULL,
    Transaction_type char(1) NOT NULL, 
    PRIMARY KEY(Transaction_ID)
);

create table FD(
	FD_ID int(9) auto_increment,
    Account_ID int(9),
    FD_type_ID int(2),
    PRIMARY KEY(FD_ID),
    FOREIGN KEY(account_ID) REFERENCES account(Account_ID) ON DELETE CASCADE,
    FOREIGN KEY(FD_type_ID) REFERENCES FD_type(FD_type_ID) ON DELETE CASCADE
);


/*MOBILE RECORD*/
create table Account_deposit(
	Account_ID int(9),
    Deposit_ID int(9),
    PRIMARY KEY(Account_ID,Deposit_ID),
    FOREIGN KEY(Account_ID) REFERENCES account(Account_ID) ON DELETE CASCADE,
    FOREIGN KEY(Deposit_ID) REFERENCES deposits(Deposit_ID) ON DELETE CASCADE
    
);
/*MOBILE RECORD*/
create table Account_withdrawal(
	Account_ID int(9),
    Withdrawal_ID int(9),
    PRIMARY KEY(Account_ID,Withdrawal_ID),
    FOREIGN KEY(Account_ID) REFERENCES account(Account_ID) ON DELETE CASCADE,
    FOREIGN KEY(Withdrawal_ID) REFERENCES withdrawals(Withdrawal_ID) ON DELETE CASCADE
);

/*MOBILE RECORD*/
create table Account_Mobile_Transaction(
	Account_ID int(9),
    Transaction_ID int(9),
    PRIMARY KEY(Account_ID,Transaction_ID),
    FOREIGN KEY(Account_ID) REFERENCES account(Account_ID) ON DELETE CASCADE,
    FOREIGN KEY(Transaction_ID) REFERENCES mobiletransaction(Transaction_ID) ON DELETE CASCADE
);

create table account_mobile(
	Account_ID int(9),
    MB_ID int(9),
    PRIMARY KEY(Account_ID,MB_ID),
    FOREIGN KEY(Account_ID) REFERENCES account(Account_ID) ON DELETE CASCADE,
    FOREIGN KEY(MB_ID) REFERENCES Mobile_Banking_Unit(MB_ID) ON DELETE CASCADE
);



