
create database payroll_service;

mysql>  show databases;
+--------------------+
| Database           |
+--------------------+
| address_book       |
| book_store         |
| information_schema |
| mysql              |
| payroll_service    |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+

mysql> use payroll_service;
Database changed

 create table employee_payroll(id INT NOT NULL AUTO_INCREMENT,name VARCHAR(150) NOT NULL,salary Double NOT NULL, start DATE NOT NULL,PRIMARY KEY (id));

mysql> DESC employee_payroll;
+--------+-------------+------+-----+---------+----------------+
| Field  | Type        | Null | Key | Default | Extra          |
+--------+-------------+------+-----+---------+----------------+
| id     | int         | NO   | PRI | NULL    | auto_increment |
| name   | varchar(50) | NO   |     | NULL    |                |
| salary | double      | NO   |     | NULL    |                |
| start  | date        | NO   |     | NULL    |                |
+--------+-------------+------+-----+---------+----------------+

mysql> INSERT INTO employee_payroll (name,salary, start) VALUES
  ('BILL', 1000000.00, '2018-01-03'),
    ('Mark', 2000000.00, '2019-11-13'),
     ('Charlie', 3000000.00, '2020-05-21');

mysql> SELECT * from employee_payroll;
+----+---------+---------+------------+
| id | name    | salary  | start      |
+----+---------+---------+------------+
|  1 | BILL    | 1000000 | 2018-01-03 |
|  2 | Mark    | 2000000 | 2019-11-13 |
|  3 | Charlie | 3000000 | 2020-05-21 |
+----+---------+---------+------------+

 select salary from employee_payroll where name ='BILL';
+---------+
| salary  |
+---------+
| 1000000 |
+---------+

mysql> DELETE from employee_payroll where name= 'BILL';

mysql> SELECT * from employee_payroll;
+----+---------+---------+------------+
| id | name    | salary  | start      |
+----+---------+---------+------------+
|  2 | Mark    | 2000000 | 2019-11-13 |
|  3 | Charlie | 3000000 | 2020-05-21 |
+----+---------+---------+------------+

INSERT INTO employee_payroll (name,salary, start) VALUES
('BILL', 1000000.00, '2018-01-03');

mysql> SELECT * from employee_payroll where start between cast('2018-01-01' as date) and date(now());
+----+---------+---------+------------+
| id | name    | salary  | start      |
+----+---------+---------+------------+
|  2 | Mark    | 2000000 | 2019-11-13 |
|  3 | Charlie | 3000000 | 2020-05-21 |
|  4 | BILL    | 1000000 | 2018-01-03 |
+----+---------+---------+------------+

mysql> alter table employee_payroll add gender char(1) after name ;

mysql>  desc employee_payroll;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| name   | varchar(150) | NO   |     | NULL    |                |
| gender | char(1)      | YES  |     | NULL    |                |
| salary | double       | NO   |     | NULL    |                |
| start  | date         | NO   |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+

mysql> update employee_payroll set gender = 'M' where name = 'BILL' or name = 'Charlie';

mysql> update employee_payroll set gender = 'F' where name = 'Mark';

mysql> select * from employee_payroll ;
+----+---------+--------+---------+------------+
| id | name    | gender | salary  | start      |
+----+---------+--------+---------+------------+
|  2 | Mark    | F      | 2000000 | 2019-11-13 |
|  3 | Charlie | M      | 3000000 | 2020-05-21 |
|  4 | BILL    | M      | 1000000 | 2018-01-03 |
+----+---------+--------+---------+------------+

mysql> select sum(salary) from employee_payroll where gender = 'F' group by gender;
+-------------+
| sum(salary) |
+-------------+
|     2000000 |
+-------------+

mysql> select avg(salary) from employee_payroll where gender = 'M' group by gender;
+-------------+
| avg(salary) |
+-------------+
|     2000000 |
+-------------+

 select min(salary) from employee_payroll where gender = 'M' group by gender;
+-------------+
| min(salary) |
+-------------+
|     1000000 |
+-------------+

 select max(salary) from employee_payroll where gender = 'M' group by gender;
+-------------+
| max(salary) |
+-------------+
|     3000000 |
+-------------+

mysql> alter table employee_payroll add phonenumber varchar(15) after name ;

mysql> alter table employee_payroll add address varchar(250) after phonenumber;

mysql> alter table employee_payroll add department varchar(150) not null after address;

mysql> alter table employee_payroll alter address SET DEFAULT 'TBD';

mysql> describe employee_payroll;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| id          | int          | NO   | PRI | NULL    | auto_increment |
| name        | varchar(150) | NO   |     | NULL    |                |
| phonenumber | varchar(15)  | YES  |     | NULL    |                |
| address     | varchar(250) | YES  |     | TBD     |                |
| department  | varchar(150) | NO   |     | NULL    |                |
| gender      | char(1)      | YES  |     | NULL    |                |
| salary      | double       | NO   |     | NULL    |                |
| start       | date         | NO   |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+

 insert into employee_payroll(name , salary ,start ,gender ,department) values ('John' , 25000.20 , '2020-02-28' , 'M' , 'Mechanical');

mysql> select * from employee_payroll;
+----+---------+-------------+---------+------------+--------+---------+------------+
| id | name    | phonenumber | address | department | gender | salary  | start      |
+----+---------+-------------+---------+------------+--------+---------+------------+
|  2 | Mark    | NULL        | NULL    |            | F      | 2000000 | 2019-11-13 |
|  3 | Charlie | NULL        | NULL    |            | M      | 3000000 | 2020-05-21 |
|  4 | BILL    | NULL        | NULL    |            | M      | 1000000 | 2018-01-03 |
|  5 | John    | NULL        | TBD     | Mechanical | M      | 25000.2 | 2020-02-28 |
+----+---------+-------------+---------+------------+--------+---------+------------+

mysql> alter table employee_payroll rename column salary to basic_pay;

mysql> alter table employee_payroll add deductions double not null after basic_pay;

mysql> alter table employee_payroll add taxable_pay double not null after deductions;

mysql> alter table employee_payroll add tax double not null after taxable_pay;

mysql> alter table employee_payroll add net_pay double not null after tax;

mysql> select * from employee_payroll;
+----+---------+-------------+---------+------------+--------+-----------+------------+-------------+-----+---------+------------+
| id | name    | phonenumber | address | department | gender | basic_pay | deductions | taxable_pay | tax | net_pay | start      |
+----+---------+-------------+---------+------------+--------+-----------+------------+-------------+-----+---------+------------+
|  2 | Mark    | NULL        | NULL    |            | F      |   2000000 |          0 |           0 |   0 |       0 | 2019-11-13 |
|  3 | Charlie | NULL        | NULL    |            | M      |   3000000 |          0 |           0 |   0 |       0 | 2020-05-21 |
|  4 | BILL    | NULL        | NULL    |            | M      |   1000000 |          0 |           0 |   0 |       0 | 2018-01-03 |
|  5 | John    | NULL        | TBD     | Mechanical | M      |   25000.2 |          0 |           0 |   0 |       0 | 2020-02-28 |
+----+---------+-------------+---------+------------+--------+-----------+------------+-------------+-----+---------+------------+

mysql> update employee_payroll set department = 'Sales' where name = 'John';

mysql> select * from employee_payroll;
+----+---------+-------------+---------+------------+--------+-----------+------------+-------------+-----+---------+------------+
| id | name    | phonenumber | address | department | gender | basic_pay | deductions | taxable_pay | tax | net_pay | start      |
+----+---------+-------------+---------+------------+--------+-----------+------------+-------------+-----+---------+------------+
|  2 | Mark    | NULL        | NULL    |            | F      |   2000000 |          0 |           0 |   0 |       0 | 2019-11-13 |
|  3 | Charlie | NULL        | NULL    |            | M      |   3000000 |          0 |           0 |   0 |       0 | 2020-05-21 |
|  4 | BILL    | NULL        | NULL    |            | M      |   1000000 |          0 |           0 |   0 |       0 | 2018-01-03 |
|  5 | John    | NULL        | TBD     | Sales      | M      |   25000.2 |          0 |           0 |   0 |       0 | 2020-02-28 |
+----+---------+-------------+---------+------------+--------+-----------+------------+-------------+-----+---------+------------+

 mysql> insert into employee_payroll (name,department,gender,basic_pay, deductions, taxable_pay, tax, net_pay, start) values
  ('John','Marketting', 'M', 30000.00, 10000.00, 20000.00,50000.00,15000.00,'2021-01-29');

 mysql> select *  from employee_payroll;
 +----+---------+-------------+---------+------------+--------+-----------+------------+-------------+-------+---------+------------+
 | id | name    | phonenumber | address | department | gender | basic_pay | deductions | taxable_pay | tax   | net_pay | start      |
 +----+---------+-------------+---------+------------+--------+-----------+------------+-------------+-------+---------+------------+
 |  2 | Mark    | NULL        | NULL    |            | F      |   2000000 |          0 |           0 |     0 |       0 | 2019-11-13 |
 |  3 | Charlie | NULL        | NULL    |            | M      |   3000000 |          0 |           0 |     0 |       0 | 2020-05-21 |
 |  4 | BILL    | NULL        | NULL    |            | M      |   1000000 |          0 |           0 |     0 |       0 | 2018-01-03 |
 |  5 | John    | NULL        | TBD     | Sales      | M      |   25000.2 |          0 |           0 |     0 |       0 | 2020-02-28 |
 |  6 | John    | NULL        | TBD     | Marketting | M      |     30000 |      10000 |       20000 | 50000 |   15000 | 2021-01-29 |
 +----+---------+-------------+---------+------------+--------+-----------+------------+-------------+-------+---------+------------+

 mysql> select * from employee_payroll where name = 'John';
 +----+------+-------------+---------+------------+--------+-----------+------------+-------------+-------+---------+------------+
 | id | name | phonenumber | address | department | gender | basic_pay | deductions | taxable_pay | tax   | net_pay | start      |
 +----+------+-------------+---------+------------+--------+-----------+------------+-------------+-------+---------+------------+
 |  5 | John | NULL        | TBD     | Sales      | M      |   25000.2 |          0 |           0 |     0 |       0 | 2020-02-28 |
 |  6 | John | NULL        | TBD     | Marketting | M      |     30000 |      10000 |       20000 | 50000 |   15000 | 2021-01-29 |
 +----+------+-------------+---------+------------+--------+-----------+------------+-------------+-------+---------+------------+

 mysql> create table company(
    company_id int NOT NULL PRIMARY KEY,
     company_name VARCHAR(250) NOT NULL);

 mysql> desc company;
 +--------------+--------------+------+-----+---------+-------+
 | Field        | Type         | Null | Key | Default | Extra |
 +--------------+--------------+------+-----+---------+-------+
 | company_id   | int          | NO   | PRI | NULL    |       |
 | company_name | varchar(250) | NO   |     | NULL    |       |
 +--------------+--------------+------+-----+---------+-------+

 mysql> create table employee_details(
emp_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
company_id int,
  phone_number VARCHAR(50) NOT NULL,
   address VARCHAR(250) NOT NULL,
   gender CHAR(1),
  start DATE NOT NULL,
  FOREIGN KEY (company_id) REFERENCES company (company_id)
  )ENGINE=INNODB;

 mysql> desc employee_details;
 +--------------+--------------+------+-----+---------+----------------+
 | Field        | Type         | Null | Key | Default | Extra          |
 +--------------+--------------+------+-----+---------+----------------+
 | emp_id       | int unsigned | NO   | PRI | NULL    | auto_increment |
 | name         | varchar(50)  | NO   |     | NULL    |                |
 | company_id   | int          | YES  | MUL | NULL    |                |
 | phone_number | varchar(50)  | NO   |     | NULL    |                |
 | address      | varchar(250) | NO   |     | NULL    |                |
 | gender       | char(1)      | YES  |     | NULL    |                |
 | start        | date         | NO   |     | NULL    |                |
 +--------------+--------------+------+-----+---------+----------------+

 mysql> create table department (
  dept_id int NOT NULL PRIMARY KEY,
 dep_name VARCHAR(150) NOT NULL);

 mysql> desc department;
 +----------+--------------+------+-----+---------+-------+
 | Field    | Type         | Null | Key | Default | Extra |
 +----------+--------------+------+-----+---------+-------+
 | dept_id  | int          | NO   | PRI | NULL    |       |
 | dep_name | varchar(150) | NO   |     | NULL    |       |
 +----------+--------------+------+-----+---------+-------+

 mysql> create table payroll (
      emp_id int unsigned NOT NULL AUTO_INCREMENT,
      basic_pay Double NOT NULL,
      deductions Double NOT NULL,
      taxable_pay Double NOT NULL,
      tax Double NOT NULL,
      net_pay Double NOT NULL,
      FOREIGN KEY (emp_id) REFERENCES employee_details(emp_id));

 mysql> desc payroll;
 +-------------+--------------+------+-----+---------+----------------+
 | Field       | Type         | Null | Key | Default | Extra          |
 +-------------+--------------+------+-----+---------+----------------+
 | emp_id      | int unsigned | NO   | MUL | NULL    | auto_increment |
 | basic_pay   | double       | NO   |     | NULL    |                |
 | deductions  | double       | NO   |     | NULL    |                |
 | taxable_pay | double       | NO   |     | NULL    |                |
 | tax         | double       | NO   |     | NULL    |                |
 | net_pay     | double       | NO   |     | NULL    |                |
 +-------------+--------------+------+-----+---------+----------------+

 mysql> create table employee_department (
      emp_id int unsigned NOT NULL AUTO_INCREMENT,
      dept_id int NOT NULL,
      FOREIGN KEY (emp_id) REFERENCES employee_details(emp_id),
      FOREIGN KEY (dept_id) REFERENCES department(dept_id));

 mysql> desc employee_department;
 +---------+--------------+------+-----+---------+----------------+
 | Field   | Type         | Null | Key | Default | Extra          |
 +---------+--------------+------+-----+---------+----------------+
 | emp_id  | int unsigned | NO   | MUL | NULL    | auto_increment |
 | dept_id | int          | NO   | MUL | NULL    |                |
 +---------+--------------+------+-----+---------+----------------+

 mysql> show tables;
 +---------------------------+
 | Tables_in_payroll_service |
 +---------------------------+
 | company                   |
 | department                |
 | employee_department       |
 | employee_details          |
 | employee_payroll          |
 | payroll                   |
 +---------------------------+

 mysql> insert into company(company_id , company_name )values (2,'ABC');

 mysql> select * from company;
 +------------+--------------+
 | company_id | company_name |
 +------------+--------------+
 |          2 | ABC          |
 +------------+--------------+

 mysql> insert into employee_details(name,company_id,emp_id,phone_number,address,gender,start) values('Kholi',2,1,'988767443','Mumbai','M','2020-02-25'),
    ('Sachin',2,2,'9987736777','maharastra','F','2020-02-25'),
      ('Dravid',2,3,'8883738232','Bangalore','F','2021-02-21'),
     ('Dhoni',2,4,'9877657673','Jaipur','M','2020-02-23');

 mysql> select * from employee_details;
 +--------+--------+------------+--------------+------------+--------+------------+
 | emp_id | name   | company_id | phone_number | address    | gender | start      |
 +--------+--------+------------+--------------+------------+--------+------------+
 |      1 | Kholi  |          2 | 988767443    | Mumbai     | M      | 2020-02-25 |
 |      2 | Sachin |          2 | 9987736777   | maharastra | F      | 2020-02-25 |
 |      3 | Dravid |          2 | 8883738232   | Bangalore  | F      | 2021-02-21 |
 |      4 | Dhoni  |          2 | 9877657673   | Jaipur     | M      | 2020-02-23 |
 +--------+--------+------------+--------------+------------+--------+------------+

 mysql> insert into payroll(emp_id, basic_pay,deductions,taxable_pay,tax,net_pay)
    values (1,50000,1000,20000,2000,30000),
   (2,70000,2000,25000,5000,45000),
    (3,50000,1000,20000,2000,30000),
    (4,70000,2000,25000,5000,45000);

 mysql> select * from payroll;
 +--------+-----------+------------+-------------+------+---------+
 | emp_id | basic_pay | deductions | taxable_pay | tax  | net_pay |
 +--------+-----------+------------+-------------+------+---------+
 |      1 |     50000 |       1000 |       20000 | 2000 |   30000 |
 |      2 |     70000 |       2000 |       25000 | 5000 |   45000 |
 |      3 |     50000 |       1000 |       20000 | 2000 |   30000 |
 |      4 |     70000 |       2000 |       25000 | 5000 |   45000 |
 +--------+-----------+------------+-------------+------+---------+

  mysql> insert into department (dept_id, dep_name) values(1,'Sales'), (2,'Marketing');

  mysql> select * from department;
  +---------+-----------+
  | dept_id | dep_name  |
  +---------+-----------+
  |       1 | Sales     |
  |       2 | Marketing |
  +---------+-----------+

  mysql> insert into employee_department (emp_id,dept_id) values
       (1,1),(2,2), (3,2),(4,1);

  mysql> select * from employee_department;
  +--------+---------+
  | emp_id | dept_id |
  +--------+---------+
  |      1 |       1 |
  |      2 |       2 |
  |      3 |       2 |
  |      4 |       1 |
  +--------+---------+
