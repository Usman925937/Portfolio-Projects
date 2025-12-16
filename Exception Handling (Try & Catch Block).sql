EXCEPTION HANDLING (TRY & CATCH BLOCK)
EXAMPLE 1:
Begin Try
Select e_salary + e_dept from employee
End Try

Begin Catch
Print 'Cannot add Numerical and String values'
End Catch

EXAMPLE 2:
Declare @val1 as int;
Declare @val2 as int;

Begin Try
Set @val1 = 8
Set @val1 = @val1/0
End Try

Begin Catch
Print error_message()
End Catch

Example 3 (Different)
Begin Try
Select e_salary + e_age from employee
Print 'Done'
End Try

Begin Catch
Print 'Error'
End Catch