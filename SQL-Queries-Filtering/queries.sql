
-- Query 1: Retrieve after hours failed login attempts.
-- Objective: Retrieve failed login attempts occurring after business hours (after 18:00) to investigate potential unauthorized access or brute-force attempts.

SELECT *
FROM log_in_attempts
WHERE login_time > '18:00' AND success = FALSE;


-- Query 2: Retrieve login attempts on specific dates.
-- Objective: Filter login records from 2022-05-08 and 2022-05-09 to analyze user activity surrounding a reported security event.

SELECT * 
FROM log_in_attempts 
WHERE login_date = '2022-05-08' OR login_date = '2022-05-09';


-- Query 3: Retrieve login attempts outside of Mexico.
-- Objective: Identify login attempts originating outside of Mexico by excluding country codes matching the 'MEX%' pattern.

SELECT * 
FROM log_in_attempts
WHERE NOT country LIKE 'MEX%';


-- Query 4: Retrieve employees in Marketing.
-- Objective: Retrieve employee records for the Marketing department located in the East building offices to prepare for machine security updates.

SELECT *
FROM employees
WHERE department = 'Marketing' AND office LIKE 'East%';


-- Query 5: Retrieve employees in Finance or Sales.
-- Objective: Filter employee data to isolate members of the Finance and Sales departments for system updates.

SELECT *
FROM employees
WHERE department = 'Finance' OR department = 'Sales';


-- Query 6: Retrieve all employees not in IT.
-- Objective: Filter out employees from the Information Technology department to identify remaining personnel requiring machine updates.

SELECT *
FROM employees
WHERE NOT department = 'Information Technology';