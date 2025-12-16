TYPES OF USER DEFINED FUNCTIONS:

Scalar Valued:
Create Function add_five (@num as int)
Returns int
AS
Begin
Return ( @num + 5)
End

Select dbo.add_five (10)

Table Valued:
Create Function select_gender (@gender as varchar (20))
Returns Table
AS
Return (Select * from employee where e_gender = @gender)

Select * from dbo.select_gender ('Male')
Select * from dbo.select_gender ('Female')