INNER JOIN:
Select employee.e_name, employee.e_dept, department.d_name, department.d_location
From employee
Inner Join department ON employee.e_dept = department.d_name;

LEFT JOIN:
Select employee.e_name, employee.e_dept, department.d_name, department.d_location
From employee
Left Join department ON employee.e_dept = department.d_name;

RIGHT JOIN:
Select employee.e_name, employee.e_dept, department.d_name, department.d_location
From employee
Right Join department ON employee.e_dept = department.d_name;

FULL JOIN:
Select employee.e_name, employee.e_dept, department.d_name, department.d_location
From employee
Full Join department ON employee.e_dept = department.d_name;

UPDATE USING JOIN:
Update employee set e_age = e_age+10
from employee
Join department ON employee. e_dept = department.d_name
Where d_location = 'New York';
Select * from employee
Select * from department

DELETE USING JOIN:
Delete employee
From employee 
Join department ON employee.e_dept = department. d_name
Where d_location = 'New York';
