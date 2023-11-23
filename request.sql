-- 1. Создать таблицу с основной информацией о сотрудниках: ФИО, дата рождения, 
-- дата начала работы, должность, уровень сотрудника (jun, middle, senior, lead), 
-- уровень зарплаты, идентификатор отдела, наличие/отсутствие прав(True/False). 
-- При этом в таблице обязательно должен быть уникальный номер для каждого сотрудника.
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    start_date DATE NOT NULL,
    position VARCHAR(255) NOT NULL,
    employee_level VARCHAR(10) CHECK (
        employee_level IN ('jun', 'middle', 'senior', 'lead')
    ),
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT NOT NULL,
    has_permissions BOOLEAN NOT NULL
);
-- 2. Для будущих отчетов аналитики попросили вас создать еще одну таблицу с информацией 
-- по отделам – в таблице должен быть идентификатор для каждого отдела, название отдела 
-- (например, Бухгалтерский или IT отдел), ФИО руководителя и количество сотрудников.
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL,
    head_name VARCHAR(255) NOT NULL,
    employee_count INT NOT NULL
);
-- 3. На кону конец года и необходимо выплачивать сотрудникам премию. 
-- Премия будет выплачиваться по совокупным оценкам, которые сотрудники получают в каждом квартале года. 
-- Создайте таблицу, в которой для каждого сотрудника будут его оценки за каждый квартал. 
-- Диапазон оценок от A – самая высокая, до E – самая низкая.
CREATE TABLE employee_ratings (
    rating_id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(employee_id) ON DELETE CASCADE,
    quarter INT CHECK (
        quarter BETWEEN 1 AND 4
    ) NOT NULL,
    rating VARCHAR(1) CHECK (rating IN ('A', 'B', 'C', 'D', 'E')) NOT NULL
);
-- 4. Несколько уточнений по предыдущим заданиям – в первой таблице должны быть записи как 
-- минимум о 5 сотрудниках, которые работают как минимум в 2-х разных отделах. Содержимое 
-- соответствующих атрибутов остается на совесть вашей фантазии, но, желательно соблюдать 
-- осмысленность и правильно выбирать типы данных (для зарплаты – числовой тип, для ФИО – строковый и т.д.).
INSERT INTO employees (
        full_name,
        birth_date,
        start_date,
        position,
        employee_level,
        salary,
        department_id,
        has_permissions
    )
VALUES (
        'Иванов Алексей Викторович',
        '1992-04-15',
        '2018-01-10',
        'Разработчик',
        'senior',
        85000,
        1,
        TRUE
    ),
    (
        'Петрова Елена Игоревна',
        '1987-08-20',
        '2014-06-15',
        'Тестировщик',
        'middle',
        72000,
        2,
        TRUE
    ),
    (
        'Смирнов Дмитрий Александрович',
        '1990-12-10',
        '2019-03-01',
        'Аналитик',
        'jun',
        60000,
        1,
        FALSE
    ),
    (
        'Ковалева Мария Павловна',
        '1985-06-03',
        '2015-11-20',
        'Разработчик',
        'senior',
        95000,
        2,
        TRUE
    ),
    (
        'Новиков Артем Сергеевич',
        '1993-02-28',
        '2020-04-10',
        'Дизайнер',
        'jun',
        55000,
        1,
        TRUE
    ),
    (
        'Сергеева Анна Владимировна',
        '1988-11-17',
        '2016-08-05',
        'Менеджер проекта',
        'lead',
        120000,
        2,
        TRUE
    ),
    (
        'Козлов Александр Андреевич',
        '1991-06-22',
        '2017-02-15',
        'Тестировщик',
        'middle',
        78000,
        1,
        FALSE
    ),
    (
        'Миронов Игорь Валентинович',
        '1984-04-30',
        '2013-11-10',
        'Аналитик',
        'senior',
        88000,
        2,
        TRUE
    ),
    (
        'Воронина Екатерина Дмитриевна',
        '1989-09-12',
        '2012-07-25',
        'Разработчик',
        'jun',
        65000,
        1,
        TRUE
    ),
    (
        'Павлова Анна Вадимовна',
        '1996-12-08',
        '2021-08-01',
        'Дизайнер',
        'middle',
        73000,
        2,
        TRUE
    );
INSERT INTO departments (department_name, head_name, employee_count)
VALUES ('Бухгалтерия', 'Володин Владимир Петрович', 4),
    ('IT отдел', 'Аксенова Мария Павловна', 7);
-- 5. Ваша команда расширяется и руководство запланировало открыть новый отдел – 
-- отдел Интеллектуального анализа данных. На начальном этапе в команду наняли 
-- одного руководителя отдела и двух сотрудников. Добавьте необходимую информацию 
-- в соответствующие таблицы.
INSERT INTO departments (department_name, head_name, employee_count)
VALUES (
        'Отдел Интеллектуального анализа данных',
        'Петрова Екатерина Семеновна',
        3
    );
INSERT INTO employees (
        full_name,
        birth_date,
        start_date,
        position,
        employee_level,
        salary,
        department_id,
        has_permissions
    )
VALUES (
        'Иванова Ирина Игоревна',
        '1991-05-20',
        '2023-01-15',
        'Аналитик данных',
        'jun',
        60000,
        3,
        TRUE
    ),
    (
        'Петров Павел Павлович',
        '1995-02-15',
        '2023-01-15',
        'Аналитик данных',
        'jun',
        60000,
        3,
        TRUE
    );
-- 6. Теперь пришла пора анализировать наши данные – напишите запросы для получения следующей информации:
-- 6.1 Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании.
SELECT employee_id,
    full_name,
    start_date,
    AGE(CURRENT_DATE, start_date) AS experience
FROM employees;
-- 6.2 Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников.
SELECT employee_id,
    full_name,
    start_date,
    AGE(CURRENT_DATE, start_date) AS experience
FROM employees
LIMIT 3;
-- 6.3 Уникальный номер сотрудников – водителей.
INSERT INTO employees (
        full_name,
        birth_date,
        start_date,
        position,
        employee_level,
        salary,
        department_id,
        has_permissions
    )
VALUES (
        'Иванов Владимир Викторович',
        '1985-06-10',
        '2019-03-01',
        'Водитель',
        'jun',
        60000,
        1,
        FALSE
    ),
    (
        'Петрова Ольга Игоревна',
        '1990-08-15',
        '2020-06-15',
        'Водитель',
        'jun',
        70000,
        2,
        FALSE
    ),
    (
        'Сидоров Алексей Сидорович',
        '1988-01-01',
        '2017-11-20',
        'Водитель',
        'jun',
        80000,
        1,
        FALSE
    ),
    (
        'Козлова Марина Павловна',
        '1992-03-15',
        '2021-01-10',
        'Водитель',
        'jun',
        65000,
        2,
        FALSE
    ),
    (
        'Новиков Игорь Сергеевич',
        '1987-12-20',
        '2018-08-05',
        'Водитель',
        'jun',
        85000,
        1,
        FALSE
    );
SELECT employee_id
FROM employees
WHERE position = 'Водитель';
-- 6.4 Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E.
INSERT INTO employee_ratings (employee_id, quarter, rating)
VALUES (1, 1, 'A'),
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
-- 6.5 Выведите самую высокую зарплату в компании.
SELECT MAX(salary) AS highest_salary
FROM employees;
-- 6.6 * Выведите название самого крупного отдела.
SELECT department_name
FROM departments
ORDER BY employee_count DESC
LIMIT 1;
-- 6.7 * Выведите номера сотрудников от самых опытных до вновь прибывших
SELECT employee_id,
    full_name,
    start_date,
    AGE(CURRENT_DATE, start_date) AS experience
FROM employees
ORDER BY start_date ASC;
-- 6.8 * Рассчитайте среднюю зарплату для каждого уровня сотрудников
SELECT employee_level,
    AVG(salary) AS average_salary
FROM employees
GROUP BY employee_level;
-- 6.9 Добавьте столбец с информацией о коэффициенте годовой премии к основной таблице. 
-- Коэффициент рассчитывается по такой схеме: базовое значение коэффициента – 1, 
-- каждая оценка действует на коэффициент так: Е – минус 20% D – минус 10% С – без изменений 
-- B – плюс 10% A – плюс 20% Соответственно, сотрудник с оценками А, В, С, D – должен получить 
-- коэффициент 1.2.
ALTER TABLE employees
ADD COLUMN bonus_coefficient NUMERIC;
UPDATE employees
SET bonus_coefficient = CASE
        WHEN employee_id IN (
            SELECT employee_id
            FROM employee_ratings
            WHERE rating = 'A'
        ) THEN 1.2
        WHEN employee_id IN (
            SELECT employee_id
            FROM employee_ratings
            WHERE rating = 'B'
        ) THEN 1.1
        WHEN employee_id IN (
            SELECT employee_id
            FROM employee_ratings
            WHERE rating = 'C'
        ) THEN 1.0
        WHEN employee_id IN (
            SELECT employee_id
            FROM employee_ratings
            WHERE rating = 'D'
        ) THEN 0.9
        WHEN employee_id IN (
            SELECT employee_id
            FROM employee_ratings
            WHERE rating = 'E'
        ) THEN 0.8
    END;
-- Теперь мы знакомы с гораздо большим перечнем операторов языка SQL и это дает нам 
-- дополнительные возможности для анализа данных. Выполните следующие запросы:
-- a.	Попробуйте вывести не просто самую высокую зарплату во всей команде, 
-- а вывести именно фамилию сотрудника с самой высокой зарплатой.
SELECT full_name,
    salary
FROM employees
ORDER BY salary DESC
LIMIT 1;
-- b.	Попробуйте вывести фамилии сотрудников в алфавитном порядке
SELECT full_name
FROM employees
ORDER BY full_name ASC;
-- c.	Рассчитайте средний стаж для каждого уровня сотрудников
SELECT employee_level,
    AVG(
        EXTRACT(
            YEAR
            FROM AGE(CURRENT_DATE, start_date)
        )
    ) AS average_experience
FROM employees
GROUP BY employee_level;
-- d.	Выведите фамилию сотрудника и название отдела, в котором он работает
SELECT e.full_name,
    d.department_name
FROM employees e
    JOIN departments d ON e.department_id = d.department_id;
-- e.	Выведите название отдела и фамилию сотрудника с самой высокой зарплатой в данном отделе и саму зарплату также.
SELECT d.department_name,
    e.full_name,
    e.salary
FROM employees e
    JOIN departments d ON e.department_id = d.department_id
WHERE (e.department_id, e.salary) IN (
        SELECT department_id,
            MAX(salary) AS max_salary
        FROM employees
        GROUP BY department_id
    );
-- f.   *Выведите название отдела, сотрудники которого получат 
-- наибольшую премию по итогам года. Как рассчитать премию можно узнать в 
-- последнем задании предыдущей домашней работы
SELECT d.department_name,
    SUM(e.salary * COALESCE(e.bonus_coefficient, 1.0)) AS total_bonus
FROM employees e
    JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_bonus DESC
LIMIT 1;
-- g.   Проиндексируйте зарплаты сотрудников с учетом коэффициента премии. 
-- Для сотрудников с коэффициентом премии больше 1.2 – размер индексации составит 20%, 
-- для сотрудников с коэффициентом премии от 1 до 1.2 размер индексации составит 10%. 
-- Для всех остальных сотрудников индексация не предусмотрена.
ALTER TABLE employees
ADD COLUMN indexed_salary NUMERIC;
UPDATE employees
SET indexed_salary = CASE
        WHEN bonus_coefficient > 1.2 THEN salary * 1.2
        WHEN bonus_coefficient >= 1
        AND bonus_coefficient <= 1.2 THEN salary * 1.1
        ELSE salary
    END;
-- h.    ***По итогам индексации отдел финансов хочет получить следующий отчет: вам необходимо на уровень каждого отдела вывести следующую информацию:
-- i. Название отдела, фамилия руководителя, количество сотрудников, количество сотрудников по уровням, общий размер оплаты труда до и после индексации, общий размер премии, общая сумма зарплат(+премии) до индексации, общая сумма зарплат(+премии) после индексации, разница в %
SELECT d.department_name,
    MAX(e.full_name) AS department_head,
    COUNT(e.employee_id) AS employee_count,
    COUNT(
        CASE
            WHEN e.employee_level = 'jun' THEN 1
        END
    ) AS junior_count,
    COUNT(
        CASE
            WHEN e.employee_level = 'middle' THEN 1
        END
    ) AS middle_count,
    COUNT(
        CASE
            WHEN e.employee_level = 'senior' THEN 1
        END
    ) AS senior_count,
    COUNT(
        CASE
            WHEN e.employee_level = 'lead' THEN 1
        END
    ) AS lead_count,
    SUM(e.salary) AS total_payment_before_index,
    SUM(e.indexed_salary) AS total_payment_after_index,
    SUM(e.salary * e.bonus_coefficient) AS total_bonus,
    SUM(e.salary + e.salary * e.bonus_coefficient) AS total_payment_before_index_with_bonus,
    SUM(
        e.indexed_salary + e.salary * e.bonus_coefficient
    ) AS total_payment_after_index_with_bonus,
    (
        SUM(
            e.indexed_salary + e.salary * e.bonus_coefficient
        ) / SUM(e.salary + e.salary * e.bonus_coefficient)
    ) * 100 AS percentage_difference,
    COUNT(
        CASE
            WHEN er.rating = 'A' THEN 1
        END
    ) AS a_count,
    COUNT(
        CASE
            WHEN er.rating = 'B' THEN 1
        END
    ) AS b_count,
    COUNT(
        CASE
            WHEN er.rating = 'C' THEN 1
        END
    ) AS c_count,
    COUNT(
        CASE
            WHEN er.rating = 'D' THEN 1
        END
    ) AS d_count,
    COUNT(
        CASE
            WHEN er.rating = 'E' THEN 1
        END
    ) AS e_count,
    AVG(e.bonus_coefficient) AS avg_bonus_coefficient
FROM departments d
    JOIN employees e ON d.department_id = e.department_id
    LEFT JOIN employee_ratings er ON e.employee_id = er.employee_id
WHERE e.position = 'Head'
GROUP BY d.department_name;
-- ii. Средний стаж, средний уровень зарплаты, количество сотрудников по уровням, общий размер оплаты труда до и после индексации, общий размер премии, общая сумма зарплат(+премии) до индексации, общая сумма зарплат(+премии) после индексации, разница в %
SELECT d.department_name,
    MAX(e.full_name) AS department_head,
    COUNT(e.employee_id) AS employee_count,
    COUNT(
        CASE
            WHEN e.employee_level = 'jun' THEN 1
        END
    ) AS junior_count,
    COUNT(
        CASE
            WHEN e.employee_level = 'middle' THEN 1
        END
    ) AS middle_count,
    COUNT(
        CASE
            WHEN e.employee_level = 'senior' THEN 1
        END
    ) AS senior_count,
    COUNT(
        CASE
            WHEN e.employee_level = 'lead' THEN 1
        END
    ) AS lead_count,
    SUM(e.salary) AS total_payment_before_index,
    SUM(e.indexed_salary) AS total_payment_after_index,
    SUM(e.salary * e.bonus_coefficient) AS total_bonus,
    SUM(e.salary + e.salary * e.bonus_coefficient) AS total_payment_before_index_with_bonus,
    SUM(
        e.indexed_salary + e.salary * e.bonus_coefficient
    ) AS total_payment_after_index_with_bonus,
    (
        SUM(
            e.indexed_salary + e.salary * e.bonus_coefficient
        ) / SUM(e.salary + e.salary * e.bonus_coefficient)
    ) * 100 AS percentage_difference,
    COUNT(
        CASE
            WHEN er.rating = 'A' THEN 1
        END
    ) AS a_count,
    COUNT(
        CASE
            WHEN er.rating = 'B' THEN 1
        END
    ) AS b_count,
    COUNT(
        CASE
            WHEN er.rating = 'C' THEN 1
        END
    ) AS c_count,
    COUNT(
        CASE
            WHEN er.rating = 'D' THEN 1
        END
    ) AS d_count,
    COUNT(
        CASE
            WHEN er.rating = 'E' THEN 1
        END
    ) AS e_count,
    AVG(
        EXTRACT(
            YEAR
            FROM AGE(CURRENT_DATE, e.start_date)
        )
    ) AS average_experience,
    AVG(e.indexed_salary) AS average_salary,
    AVG(e.bonus_coefficient) AS avg_bonus_coefficient
FROM departments d
    JOIN employees e ON d.department_id = e.department_id
    LEFT JOIN employee_ratings er ON e.employee_id = er.employee_id
GROUP BY d.department_name;