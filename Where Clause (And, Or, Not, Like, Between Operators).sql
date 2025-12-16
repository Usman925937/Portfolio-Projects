Single Condition
Select * from employee where e_gender='Female';
Select * from employee where e_salary>100000;

Multiple Condition (AND, OR, NOT, LIKE, BETWEEN Operators)
Select * from employee where e_age<30 AND e_dept='Analytics';
Select * from employee where e_dept='Sales' OR e_dept='Operations';
Select * from employee where not e_age<30;
Select * from employee where e_name LIKE 'J%';
Select * from employee where e_age LIKE '3_';
Select * from employee where e_salary BETWEEN 90000 AND 120000;
