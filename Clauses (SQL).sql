Clauses (SQL) (Order By Clause, Top Clause, Group By, Having Clause, Delete Statement, Truncate Statement)
Order By:
Select * from employee order by e_age;
Select * from employee where e_salary>90000 order by e_salary ASC;
Select * from employee where e_salary<100000 order by e_salary DESC;

Top Clause:
Select Top 3 * from employee;
Select top 3 * from employee where e_salary>100000;

Using Both Top Clause & Order By Clause
Select the Top 3 Oldest employees of the Company. List it in Descending Order.
Select top 3 * from employee order by e_age DESC;

Group By:
Select avg(e_salary), e_gender from employee group by e_gender;
Select avg (e_age), e_dept from employee group by e_dept order by avg (e_age) DESC;

Having Clause:
Display/Select only those departments whose avg salary is greater than 100000.
Select e_dept, avg(e_salary) as avg_salary from employee group by e_dept having avg(e_salary)>100000

Update Statement:
Update employee set e_age=42 where e_name='Sam';
Select * from employee;
Update employee set e_dept='Tech';

Delete Statement:
Delete from employee where e_age=33;
Delete from employee where e_name='Sam';

Truncase Statement:
Truncate table employee;
