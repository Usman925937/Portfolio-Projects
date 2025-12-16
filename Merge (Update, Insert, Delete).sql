Merge Employee_Target AS T
Using Employee_Source AS S
	ON T.e_id = S.e_id
When Matched
	Then Update Set T.e_salary = S.e_salary, T.e_age = S.e_age
When Not Matched By Target
	Then Insert (e_id, e_name, e_salary, e_age, e_gender, e_dept)
	Values (S.e_id, S.e_name, S.e_salary, S.e_age, S.e_gender, S.e_dept)
When Not Matched By Source
	Then Delete;

Select * from Employee_Target