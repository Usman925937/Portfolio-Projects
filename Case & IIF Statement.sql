CASE STATEMENT:
Select *, grade=
Case 
When e_salary < 90000 then 'C'
When e_salary < 120000 then 'B'
else 'A'
End
From employee
Go;

IIF STATEMENT:
Select *,
IIF (e_age >30, 'Old employee', 'Young Employee') as employee_generation from employee;

Select e_id, e_name, e_age,
IIF (e_age >30, 'Experienced', 'Young') as employee_generation from employee; 