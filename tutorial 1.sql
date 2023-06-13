CREATE TABLE
    tbl_Employee (
        employee_name VARCHAR(255) NOT NULL,
        street VARCHAR(255) NOT NULL,
        city VARCHAR(255) NOT NULL,
        PRIMARY KEY(employee_name)
    );


CREATE TABLE
    tbl_Works (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR(255),
        salary DECIMAL(10, 2)
    );

CREATE TABLE
    tbl_Company (
        company_name VARCHAR(255) NOT NULL,
        city VARCHAR(255),
        PRIMARY KEY(company_name)
    );

CREATE TABLE
    tbl_Manages (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR(255)
    );
	INSERT INTO tbl_Employee VALUES ('John Doe','235 Fifth Ave','New York');
INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Alice Williams',
        '321 Maple St',
        'Houston'
    ), (
        'Sara Davis',
        '159 Broadway',
        'New York'
    ), (
        'Mark Thompson',
        '235 Fifth Ave',
        'New York'
    ), (
        'Ashley Johnson',
        '876 Market St',
        'Chicago'
    ), (
        'Emily Williams',
        '741 First St',
        'Los Angeles'
    ), (
        'Michael Brown',
        '902 Main St',
        'Houston'
    ),(
        'John Doe',
        '235 Fifth Ave',
        'New York'
    ),(
        'Samantha Smith',
        '111 Second St',
        'Chicago'
    );

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Patrick',
        '123 Main St',
        'New Mexico'
    );

INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Patrick',
        'Pongyang Corporation',
        500000
    );



INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Sara Davis',
        'First Bank Corporation',
        82500.00
    ), (
        'Mark Thompson',
        'Small Bank Corporation',
        78000.00
    ), (
        'Ashley Johnson',
        'Small Bank Corporation',
        92000.00
    ), (
        'Emily Williams',
        'Small Bank Corporation',
        86500.00
    ), (
        'Michael Brown',
        'Small Bank Corporation',
        81000.00
    ), (
        'Samantha Smith',
        'Small Bank Corporation',
        77000.00
    );

INSERT INTO
    tbl_Company (company_name, city)
VALUES (
        'Small Bank Corporation', 'Chicago'), 
        ('ABC Inc', 'Los Angeles'), 
        ('Def Co', 'Houston'), 
        ('First Bank Corporation','New York'), 
        ('456 Corp', 'Chicago'), 
        ('789 Inc', 'Los Angeles'), 
        ('321 Co', 'Houston'),
        ('Pongyang Corporation','Chicago'
    );

INSERT INTO
    tbl_Manages(employee_name, manager_name)
VALUES 
    ('Mark Thompson', 'Emily Williams'),
    ('Michael Brown', 'Jane Doe'),
    ('Alice Williams', 'Emily Williams'),
    ('Samantha Smith', 'Sara Davis'),
    ('Patrick', 'Jane Doe');

SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Manages;
SELECT * FROM tbl_Company;



--- Find the names of all employees who work for First Bank Corporation.

   SELECT employee_name FROM tbl_Works WHERE company_name='First Bank Corporation'


--- Find the names and cities of residence of all employees who work for First Bank Corporation.
    
 SELECT * FROM tbl_Employee WHERE employee_name IN (SELECT employee_name FROM tbl_Works WHERE company_name='First Bank Corporation')

--- Find the names, street addresses, and cities of residence of all employees who work for Small Bank Corporation and earn more than $10,000.

 SELECT * FROM tbl_Employee WHERE employee_name IN (SELECT employee_name FROM tbl_Works WHERE company_name='Small Bank Corporation' AND (salary>10000) )

--- Find all employees in the database who live in the same cities as the companies for which they work. 

  

   Select tbl_employee.employee_name from tbl_employee, tbl_Works ,tbl_Company
   where tbl_employee.employee_name=tbl_Works.employee_name 
   and tbl_works.Company_name = tbl_Company.Company_name 
   and tbl_employee.city=tbl_Company.city;

--- Find all employees in the database who live in the same cities and on the same streets as do their managers.

 Select tbl_employee.employee_name from tbl_employee, tbl_Works ,tbl_Company,tbl_Manages
   where tbl_Manages.employee_name=tbl_employee.employee_name and tbl_Manages.manager_name=tbl_Works.employee_name
   and tbl_employee.street = tbl_Company.Company_name 
   and tbl_employee.city=tbl_Company.city;

   

--- Find all employees in the database who do not work for First Bank Corporation.

 SELECT employee_name FROM tbl_Works WHERE company_name!='First Bank Corporation'

--- Find all employees in the database who earn more than each employee of Small Bank Corporation.

   SELECT employee_name FROM tbl_Works WHERE salary > all (SELECT salary FROM tbl_Works WHERE company_name = 'Small Bank Corporation')

--- Assume that the companies may be located in several cities. Find all companies located in every city in which Small Bank Corporation is located.

   SELECT company_name FROM tbl_Company WHERE city= all(SELECT city FROM tbl_Company WHERE city='Chicago')

--- Find all employees who earn more than the average salary of all employees of their company.
   SELECT employee_name FROM tbl_Works,tbl_Company WHERE salary>(SELECT AVG(salary) FROM tbl_Works WHERE tbl_Works.company_name=tbl_Company.company_name=)


--- Find the company that has the most employees.
              SELECT company_name,count(*) as cnt 
                    FROM tbl_Works 
                    GROUP BY company_name 
                    ORDER BY cnt DESC

--- Find the company that has the smallest payroll.
      SELECT company_name, sum(salary)
                 FROM tbl_Works
                 GROUP BY company_name
                 ORDER BY sum(salary)

--- Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.

        



--(a) Modify the database so that Jones now lives in Newtown.


--(b) Give all employees of First Bank Corporation a 10 percent raise.


--(c) Give all managers of First Bank Corporation a 10 percent raise.


--(d) Give all managers of First Bank Corporation a 10 percent raise unless the salary becomes greater than $100,000; in such cases, give only a 3 percent raise.


--(e) Delete all tuples in the works relation for employees of Small Bank Corporation.


--No of employee managed by the manager

SELECT manager_name ,count(*) as cnt 
                    FROM tbl_Manages 
                    GROUP BY manager_name 
                    ORDER BY cnt DESC

  --Only employee that manages more than one employee

  
SELECT manager_name ,count(*) as cnt 
                    FROM tbl_Manages 
                    GROUP BY manager_name 
                    HAVING COUNT(employee_name)>1
--display the name of employee whose salary is greater than 10 lakh if any

SELECT employee_name
FROM tbl_Works
WHERE EXISTS
  (SELECT salary
  FROM tbl_Works
  WHERE salary > 30000);

  --display the name of employee whose salary is greater than 10 lakh if exists

SELECT employee_name
FROM tbl_Works
WHERE EXISTS
  (SELECT salary
  FROM tbl_Works
  WHERE salary > 30000);


  ---JOIN operation

  SELECT * FROM tbl_Employee LEFT JOIN tbl_Works
  ON 
  tbl_Employee.employee_name=tbl_Works.employee_name;

  ---CROSS JOIN operation 
   
   SELECT * FROM tbl_Employee CROSS JOIN tbl_Works;

   ---LEFT JOIN 
   SELECT * FROM tbl_Employee LEFT JOIN tbl_Works
   ON tbl_Employee.employee_name=tbl_Works.employee_name WHERE company_name ='First Bank Corporation';