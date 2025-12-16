STORED PROCEDURE:
Without Parameter:
Select * from employee
Create procedure employee_data
AS
Select e_name, e_salary, e_dept from employee
Go;

Exec employee_data

With Parameter:
Create function Choose_gender (@gender as varchar (20))
Returns Table
AS
Return 
(
Select * from employee where e_gender = @gender
);

Select * from dbo.Choose_gender ('Male')
Select * from dbo.Choose_gender ('Female')