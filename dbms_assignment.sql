-- Lab 1: Create a new database named school_db and a table called students
CREATE DATABASE school_db;

USE school_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    class VARCHAR(50),
    address VARCHAR(255)
);

-- Lab 2: Insert five records into the students table
INSERT INTO students (student_id, student_name, age, class, address) VALUES
(101, 'Vikram', 20, 'TOPs', 'Ahmdabad'),
(102, 'Nikhil', 23, 'TOPs', 'Ahmdabad'),
(103, 'Kanishk', 22, 'TOPs', 'Ahmdabad'),
(104, 'Himanshi', 21, 'TOPs', 'Ahmdabad'),
(105, 'Aashish', 23, 'TOPs', 'Ahmdabad');

-- Retrieve all records using the SELECT statement
SELECT * FROM students;

-- Retrieve Students with Age > 10
SELECT * FROM students WHERE age > 10;


-- 3. SQL Constraints
-- Lab 1: Create Teachers Table
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(50) NOT NULL,
    subject VARCHAR(30) NOT NULL,
    email VARCHAR(50) UNIQUE
);

-- Lab 2: Add Foreign Key to Students Table
ALTER TABLE students ADD COLUMN teacher_id INT;
ALTER TABLE students ADD CONSTRAINT fk_teacher FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id);

-- 4. Main SQL Commands and Sub-commands (DDL)
-- Lab 1: Create Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    course_credits INT
);
-- Lab 2: Create University Database
CREATE DATABASE university_db;

-- 5. ALTER Command
-- Lab 1: Add Column
ALTER TABLE courses ADD COLUMN course_duration INT;

-- Lab 2: Drop Column
ALTER TABLE courses DROP COLUMN course_credits;

-- 6. DROP Command
-- Lab 1: Drop Teachers Table
DROP TABLE school_db.teachers;

-- Lab 2: Drop Students Table
DROP TABLE school_db.students;


-- 7. Data Manipulation Language (DML)
-- Lab 1: Insert Records into Courses
INSERT INTO courses (course_id, course_name, course_duration) VALUES
(1, 'Mathematics', 4),
(2, 'Physics', 3),
(3, 'Chemistry', 4);

-- Lab 2: Update Course Duration
UPDATE courses SET course_duration = 5 WHERE course_id = 1;

-- Lab 3: Delete Course by ID
DELETE FROM courses WHERE course_id = 2;


-- 8. Data Query Language (DQL)
-- Lab 1: Retrieve All Courses
SELECT * FROM courses;

-- Lab 2: Sort Courses by Duration
SELECT * FROM courses ORDER BY course_duration DESC;

-- Lab 3: Limit Results to Top 2
SELECT * FROM courses LIMIT 2;

-- 9. Data Control Language (DCL)
-- Lab 1: Create Users and Grant Permission
pending bad me karunga
-- Lab 2: Revoke & Grant Permissions
ho ni rha he 


-- 10. Transaction Control Language (TCL)
-- Lab 1: Insert with COMMIT
START TRANSACTION;
INSERT INTO courses (course_id, course_name, course_duration) VALUES (4, 'Biology', 4);
COMMIT;

-- Lab 2: Insert and ROLLBACK
START TRANSACTION;
INSERT INTO courses (course_id, course_name, course_duration) VALUES (5, 'History', 3);
ROLLBACK;

-- Lab 3: Use SAVEPOINT
START TRANSACTION;
UPDATE courses SET course_duration = 6 WHERE course_id = 3;
SAVEPOINT before_update;

UPDATE courses SET course_duration = 2 WHERE course_id = 4;

ROLLBACK TO before_update;
COMMIT;

-- 11. SQL Joins
-- Lab 1: Inner Join (Departments & Employees)
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Example Query
SELECT employees.employee_name, departments.department_name
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;

-- Lab 2: Left Join
SELECT departments.department_name, employees.employee_name
FROM departments
LEFT JOIN employees ON employees.department_id = departments.department_id;


-- 12. SQL Group By
-- Lab 1: Group Employees by Department
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;

-- Lab 2: Average Salary by Department
ALTER TABLE employees ADD COLUMN salary INT;

SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- 13. SQL Stored Procedure
-- Lab 1: Procedure to Retrieve Employees by Department
DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment(IN dept_id INT)
BEGIN
    SELECT * FROM employees WHERE department_id = dept_id;
END //
DELIMITER ;

-- Lab 2: Procedure to Retrieve Course Details
DELIMITER //
CREATE PROCEDURE GetCourseDetails(IN cid INT)
BEGIN
    SELECT * FROM courses WHERE course_id = cid;
END //
DELIMITER ;

-- 14. SQL View
-- Lab 1: Create Employee View with Department Name
CREATE VIEW EmployeeDepartment AS
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Lab 2: Modify View to Exclude Low Salary Employees
CREATE OR REPLACE VIEW EmployeeDepartment AS
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary >= 50000;

-- 15. SQL Triggers
-- Lab 1: Trigger to Log New Employees
CREATE TABLE employee_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    log_action VARCHAR(50),
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_log (employee_id, log_action)
    VALUES (NEW.employee_id, 'New Employee Added');
END //
DELIMITER ;

-- Lab 2: Trigger to Update Last Modified Timestamp
ALTER TABLE employees ADD COLUMN last_modified TIMESTAMP;

DELIMITER //
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.last_modified = CURRENT_TIMESTAMP;
END //
DELIMITER ;
