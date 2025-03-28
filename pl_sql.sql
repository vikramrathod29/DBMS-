--  1. PL/SQL Basics & Queries
-- Lab 1: Print total number of employees
DECLARE
    emp_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO emp_count FROM employees;
    DBMS_OUTPUT.PUT_LINE('Total Employees: ' || emp_count);
END;
/

-- Lab 2: Calculate total sales from orders table
DECLARE
    total_sales NUMBER;
BEGIN
    SELECT SUM(order_amount) INTO total_sales FROM orders;
    DBMS_OUTPUT.PUT_LINE('Total Sales: ' || total_sales);
END;
/

-- 2. PL/SQL Control Structures
-- Lab 1: Check employee department using IF-THEN
DECLARE
    emp_id NUMBER := 101;
    emp_dept VARCHAR2(50);
BEGIN
    SELECT department_name INTO emp_dept FROM employees WHERE employee_id = emp_id;
    IF emp_dept = 'Sales' THEN
        DBMS_OUTPUT.PUT_LINE('Employee is in Sales department');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee is in ' || emp_dept || ' department');
    END IF;
END;
/

-- Lab 2: Display employee names using FOR LOOP
BEGIN
    FOR emp_rec IN (SELECT first_name FROM employees) LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_rec.first_name);
    END LOOP;
END;
/

-- 3. SQL Cursors
-- Lab 1: Explicit cursor to display employee details
DECLARE
    CURSOR emp_cursor IS SELECT employee_id, first_name, salary FROM employees;
    emp_row emp_cursor%ROWTYPE;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_row;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || emp_row.employee_id || ' Name: ' || emp_row.first_name || ' Salary: ' || emp_row.salary);
    END LOOP;
    CLOSE emp_cursor;
END;
/

-- Lab 2: Cursor to retrieve all courses
DECLARE
    CURSOR course_cursor IS SELECT course_name FROM courses;
    course_name courses.course_name%TYPE;
BEGIN
    OPEN course_cursor;
    LOOP
        FETCH course_cursor INTO course_name;
        EXIT WHEN course_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Course: ' || course_name);
    END LOOP;
    CLOSE course_cursor;
END;
/

-- 4. Rollback and Commit Savepoint
-- Lab 1: Savepoint and rollback example
BEGIN
    INSERT INTO employees (employee_id, first_name, salary) VALUES (201, 'Nikhil', 50000);
    SAVEPOINT save1;

    INSERT INTO employees (employee_id, first_name, salary) VALUES (202, 'Ashish', 60000);
    ROLLBACK TO save1; -- Rollback only second insert

    COMMIT;
END;
/

-- Lab 2: Commit part, rollback remaining
BEGIN
    INSERT INTO employees (employee_id, first_name, salary) VALUES (203, 'Kanishk', 70000);
    SAVEPOINT save2;

    INSERT INTO employees (employee_id, first_name, salary) VALUES (204, 'Himanshi', 80000);
    COMMIT;

    INSERT INTO employees (employee_id, first_name, salary) VALUES (205, 'Roney', 90000);
    ROLLBACK TO save2;
END;
/

-- 5. Introduction to SQL
-- Lab 3: Create library_db & books table
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR2(100),
    author VARCHAR2(100),
    publisher VARCHAR2(100),
    year_of_publication INT,
    price DECIMAL(10,2)
);

INSERT INTO books VALUES
(1, 'Book One', 'Author A', 'Publisher X', 2019, 50),
(2, 'Book Two', 'Author B', 'Publisher Y', 2020, 60),
(3, 'Book Three', 'Author C', 'Publisher Z', 2021, 70),
(4, 'Book Four', 'Author A', 'Publisher X', 2022, 80),
(5, 'Book Five', 'Author B', 'Publisher Y', 2023, 90);

-- Lab 4: Create members table
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR2(100),
    date_of_membership DATE,
    email VARCHAR2(100)
);

INSERT INTO members VALUES
(1, 'Nikhil', TO_DATE('2021-05-10', 'YYYY-MM-DD'), 'nikhil@example.com'),
(2, 'Ashish', TO_DATE('2019-04-15', 'YYYY-MM-DD'), 'ashish@example.com'),
(3, 'Kanishk', TO_DATE('2022-06-20', 'YYYY-MM-DD'), 'kanishk@example.com'),
(4, 'Vikram', TO_DATE('2020-03-25', 'YYYY-MM-DD'), 'vikram@example.com'),
(5, 'Roney', TO_DATE('2018-12-30', 'YYYY-MM-DD'), 'roney@example.com');

-- 6. PL/SQL Stored Procedure Example
-- Lab 3: Procedure to get books by author
CREATE OR REPLACE PROCEDURE get_books_by_author(p_author VARCHAR2) AS
BEGIN
    FOR book IN (SELECT title FROM books WHERE author = p_author) LOOP
        DBMS_OUTPUT.PUT_LINE('Book: ' || book.title);
    END LOOP;
END;
/

-- To call:
BEGIN
    get_books_by_author('Author A');
END;
/

-- Lab 4: Procedure to get book price by id
CREATE OR REPLACE PROCEDURE get_book_price(p_book_id INT, p_price OUT NUMBER) AS
BEGIN
    SELECT price INTO p_price FROM books WHERE book_id = p_book_id;
END;
/

-- To call:
DECLARE
    v_price NUMBER;
BEGIN
    get_book_price(1, v_price);
    DBMS_OUTPUT.PUT_LINE('Price: ' || v_price);
END;
/

-- 7. PL/SQL Triggers Example
-- Lab 3: Trigger to update last_modified
ALTER TABLE books ADD last_modified DATE;
/

CREATE OR REPLACE TRIGGER update_book_timestamp
BEFORE UPDATE ON books
FOR EACH ROW
BEGIN
    :NEW.last_modified := SYSDATE;
END;
/

-- Lab 4: Trigger to log DELETE operation
CREATE TABLE log_changes (
    log_id INT PRIMARY KEY,
    operation VARCHAR2(50),
    table_name VARCHAR2(50),
    log_time DATE
);
/

CREATE SEQUENCE log_changes_seq START WITH 1 INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER log_book_delete
AFTER DELETE ON books
FOR EACH ROW
BEGIN
    INSERT INTO log_changes (log_id, operation, table_name, log_time)
    VALUES (log_changes_seq.NEXTVAL, 'DELETE', 'books', SYSDATE);
END;
/
