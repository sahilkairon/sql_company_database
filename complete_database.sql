-- creating employee table we have not specified branch_id and super_id as foreign key yet,
-- becuase we have not created branch table yet ! 
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

-- creating branch table and setting branch_id as primary key and mgr_id(manager id) as foreign key that
-- refers to emp_id of employee table
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);


-- setting branch_id and super_id as foreign key in employee table 
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

-- creating client table and setting client_id as primary key and branch_id of branch table as foreign key in client table
CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);



-- creating works_with table and here emp_id and client_id act as composite primary key and they both are foreign key as well..
CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);



-- creating a branch-supplier table that holds the information of which supplier works with which branch and here 
-- branch_id and supplier_name act as composite primary key and branch_id acts as foreign key also...
CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);
-- inserting values in employee table and adding branch_id null for now becuase we have not specified any values for
-- branch_id in branch table as of now and branch_id is a foreign key in employee table. 
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

-- inserting branch_id 1 details in branch table 
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

-- now updating the branch_id foreign key value in employee table for first entry
UPDATE employee 
SET branch_id = 1 
WHERE emp_id = 100;

-- inserting second entry in employee table  and keeping branch_id null as of now
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

-- inserting in branch table second entry
INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

-- updating branch_id foreign key in emp_id 102 
UPDATE employee 
SET branch_id = 2 
WHERE emp_id = 102;

-- inserting in employee table
INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);
INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);
SELECT * FROM employee;

-- inserting in employee table emp_id 106, keeping branch_id null as of now
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

-- inserting in branch table
INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

-- updating branch_id in emp_id 106
UPDATE employee
SET branch_id = 3
WHERE emp_id =106;

-- inserting in employee table 
INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

SELECT * FROM branch;
SELECT * FROM employee;

-- NOW employee table and branch table is completed.. 

-- now inserting data in client table where client_id is primary key and branch_id is foreign key
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

SELECT * FROM client;

-- now inserting data in works_with table where we have composite primary key(emp_id + client_id) 
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

SELECT * FROM works_with;
{{new_variable}}

-- inserting data in branch_supplier
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

SELECT * FROM branch_supplier;

-- now all the tables of our schema are created... 
