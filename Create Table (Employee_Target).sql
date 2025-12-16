Create Table Employee_Target (
e_id int not null,
e_name varchar (20),
e_salary int,
e_age int,
e_gender varchar (20),
e_dept varchar (20),
primary key (e_id),
);

Insert into Employee_Target values (
1, 'Sam', 95000, 45, 'Male', 'Operations'
);

Insert into Employee_Target values (
2, 'Bob', 80000, 21, 'Male', 'Support'
);

Insert into Employee_Target values (
3, 'Anne', 125000, 25, 'Female', 'Analytics'
);

Insert into Employee_Target values (
4, 'Julia', 73000, 30, 'Female', 'Analytics'
);

Insert into Employee_Target values (
5, 'Matt', 159000, 33, 'Male', 'Sales'
);

Insert into Employee_Target values (
6, 'Jeff', 112000, 27, 'Male', 'Operations'
);
