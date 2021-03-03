CREATE DEFINER=`root`@`localhost` PROCEDURE `NewUser`(first_name varchar(30),last_name varchar(30),Date_of_Birth date, Email varchar(100), Address varchar(200),contact_no int(10) )
    MODIFIES SQL DATA
BEGIN

 START TRANSACTION; 
 	Insert into user_details(First_Name,Last_Name,DOB,Email,Address,Contact_No) values (first_name,last_name,Date_of_Birth,Email,Address,contact_no);
 COMMIT;


END