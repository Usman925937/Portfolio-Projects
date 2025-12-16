TRANSACTION:

Select * from employee
Begin Transaction
Update employee set e_age = '30' where e_name = 'Sam'
Rollback transaction

Begin Transaction
Update employee set e_age = '30' where e_name = 'Sam'
Commit transaction

Begin Try
	Begin Transaction
	Update employee set e_salary = 50 where e_gender = 'Male'
	Update employee set e_salary = 195 where e_gender = 'Female'
	Commit Transaction 
End Try

Begin Catch
	Rollback Transaction
	Print 'Transaction Rolled Back'
End Catch

