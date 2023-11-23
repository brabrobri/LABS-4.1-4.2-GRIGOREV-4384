CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    start_date DATE NOT NULL,
    position VARCHAR(255) NOT NULL,
    employee_level VARCHAR(10) CHECK (employee_level IN ('jun', 'middle', 'senior', 'lead')),
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT NOT NULL,
    has_permissions BOOLEAN NOT NULL
);

INSERT INTO employees (full_name, birth_date, start_date, position, employee_level, salary, department_id, has_permissions)
VALUES
    ('������ ������� ����������', '1992-04-15', '2018-01-10', '�����������', 'senior', 85000, 1, TRUE),
    ('������� ����� ��������', '1987-08-20', '2014-06-15', '�����������', 'middle', 72000, 2, TRUE),
    ('������� ������� �������������', '1990-12-10', '2019-03-01', '��������', 'jun', 60000, 1, FALSE),
    ('�������� ����� ��������', '1985-06-03', '2015-11-20', '�����������', 'senior', 95000, 2, TRUE),
    ('������� ����� ���������', '1993-02-28', '2020-04-10', '��������', 'jun', 55000, 1, TRUE),
    ('�������� ���� ������������', '1988-11-17', '2016-08-05', '�������� �������', 'lead', 120000, 2, TRUE),
    ('������ ��������� ���������', '1991-06-22', '2017-02-15', '�����������', 'middle', 78000, 1, FALSE),
    ('������� ����� ������������', '1984-04-30', '2013-11-10', '��������', 'senior', 88000, 2, TRUE),
    ('�������� ��������� ����������', '1989-09-12', '2012-07-25', '�����������', 'jun', 65000, 1, TRUE),
    ('������� ���� ���������', '1996-12-08', '2021-08-01', '��������', 'middle', 73000, 2, TRUE);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL,
    head_name VARCHAR(255) NOT NULL,
    employee_count INT NOT NULL
);

INSERT INTO departments (department_name, head_name, employee_count)
VALUES 
    ('�����������', '������� �������� ��������', 4),
    ('IT �����', '�������� ����� ��������', 7);


CREATE TABLE employee_ratings (
    rating_id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(employee_id) ON DELETE CASCADE,
    quarter INT CHECK (quarter BETWEEN 1 AND 4) NOT NULL,
    rating VARCHAR(1) CHECK (rating IN ('A', 'B', 'C', 'D', 'E')) NOT NULL
);


-- ���������� ������ ������ "����������������� ������� ������"
INSERT INTO departments (department_name, head_name, employee_count)
VALUES ('����� ����������������� ������� ������', '������� ��������� ���������', 3);

-- ���������� ���� ����������� ������ ����������������� ������� ������
INSERT INTO employees (full_name, birth_date, start_date, position, employee_level, salary, department_id, has_permissions)
VALUES
    ('������� ����� ��������', '1991-05-20', '2023-01-15', '�������� ������', 'jun', 60000, 3, TRUE),
    ('������ ����� ��������', '1995-02-15', '2023-01-15', '�������� ������', 'jun', 60000, 3, TRUE);



SELECT
    employee_id,
    full_name,
    start_date,
    AGE(CURRENT_DATE, start_date) AS experience
FROM employees;



SELECT
    employee_id,
    full_name,
    start_date,
    AGE(CURRENT_DATE, start_date) AS experience
FROM employees
LIMIT 3;



INSERT INTO employees (full_name, birth_date, start_date, position, employee_level, salary, department_id, has_permissions)
VALUES
    ('������ �������� ����������', '1985-06-10', '2019-03-01', '��������', 'jun', 60000, 1, FALSE),
    ('������� ����� ��������', '1990-08-15', '2020-06-15', '��������', 'jun', 70000, 2, FALSE),
    ('������� ������� ���������', '1988-01-01', '2017-11-20', '��������', 'jun', 80000, 1, FALSE),
    ('������� ������ ��������', '1992-03-15', '2021-01-10', '��������', 'jun', 65000, 2, FALSE),
    ('������� ����� ���������', '1987-12-20', '2018-08-05', '��������', 'jun', 85000, 1, FALSE);



SELECT employee_id
FROM employees
WHERE position = '��������';



-- ������ ���������� ������� employee_ratings ��� 10 �����������
INSERT INTO employee_ratings (employee_id, quarter, rating)
VALUES
    (1, 1, 'A'),
    (2, 2, 'E'),
    (3, 1, 'C'),
    (4, 2, 'E'),
    (5, 1, 'B'),
    (6, 3, 'E'),
    (7, 3, 'A'),
    (8, 3, 'D'),
    (9, 4, 'D'),
    (10, 1, 'A');



SELECT DISTINCT employee_id
FROM employee_ratings
WHERE rating IN ('D', 'E');



SELECT MAX(salary) AS highest_salary
FROM employees;



SELECT department_name
FROM departments
ORDER BY employee_count DESC
LIMIT 1;



SELECT employee_id, full_name, start_date, AGE(CURRENT_DATE, start_date) AS experience
FROM employees
ORDER BY start_date ASC;



SELECT employee_level, AVG(salary) AS average_salary
FROM employees
GROUP BY employee_level;



-- ���������� �������
ALTER TABLE employees
ADD COLUMN bonus_coefficient NUMERIC;

-- ���������� ������������� �� ������ ������ �� ������ �������
UPDATE employees
SET bonus_coefficient = 
    CASE 
        WHEN employee_id IN (SELECT employee_id FROM employee_ratings WHERE rating = 'A') THEN 1.2
        WHEN employee_id IN (SELECT employee_id FROM employee_ratings WHERE rating = 'B') THEN 1.1
        WHEN employee_id IN (SELECT employee_id FROM employee_ratings WHERE rating = 'C') THEN 1.0
        WHEN employee_id IN (SELECT employee_id FROM employee_ratings WHERE rating = 'D') THEN 0.9
        WHEN employee_id IN (SELECT employee_id FROM employee_ratings WHERE rating = 'E') THEN 0.8
    END;



SELECT full_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 1;



SELECT full_name
FROM employees
ORDER BY full_name ASC;



SELECT employee_level, AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, start_date))) AS average_experience
FROM employees
GROUP BY employee_level;



SELECT e.full_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;



SELECT d.department_name, e.full_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE (e.department_id, e.salary) IN (
    SELECT department_id, MAX(salary) AS max_salary
    FROM employees
    GROUP BY department_id
);



SELECT d.department_name, 
       SUM(e.salary * COALESCE(e.bonus_coefficient, 1.0)) AS total_bonus
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_bonus DESC
LIMIT 1;



-- ���������� ������� ��� ����������
ALTER TABLE employees
ADD COLUMN indexed_salary NUMERIC;

-- ���������� ��������������� �������
UPDATE employees
SET indexed_salary = 
    CASE 
        WHEN bonus_coefficient > 1.2 THEN salary * 1.2
        WHEN bonus_coefficient >= 1 AND bonus_coefficient <= 1.2 THEN salary * 1.1
        ELSE salary
    END;



