# Apply Filters to SQL Queries

## Description
This project demonstrates the application of SQL filters to query database tables containing organizational security logs and employee data. The queries were executed to investigate potential security incidents, analyze suspicious login activities, and filter employee records for machine updates.

## Objectives
- Apply conditional logic using SQL operators (WHERE, AND, OR, NOT, LIKE).
- Analyze access logs to identify after-hours failed login attempts and anomalous geographic activity.
- Filter employee records based on departmental and office location criteria.

## Summary of Queries & Results

### 1. Retrieve After-Hours Failed Login Attempts
Identified unsuccessful login attempts occurring after business hours (18:00) to detect potential unauthorized access or brute-force attempts.

```sql
SELECT *
FROM log_in_attempts
WHERE login_time > '18:00' AND success = FALSE;
```

### 2. Retrieve Login Attempts on Specific Dates
Filtered login records from 2022-05-08 and 2022-05-09 to analyze user activity surrounding a reported security event.

```sql
SELECT *
FROM log_in_attempts
WHERE login_date = '2022-05-08' OR login_date = '2022-05-09';
```

### 3. Retrieve Login Attempts Outside of Mexico
Isolated international login attempts by excluding country 
codes matching the 'MEX%' pattern.

```sql
SELECT *
FROM log_in_attempts
WHERE NOT country LIKE 'MEX%';
```

### 4. Retrieve Employees in Marketing
Retrieved employee records for the Marketing department located in the East building offices to prepare for machine security updates.

```sql
SELECT *
FROM employees
WHERE department = 'Marketing' AND office LIKE 'East%';
```

### 5. Retrieve Employees in Finance or Sales
Filtered employee data to isolate members of the Finance and Sales departments for system updates.

```sql
SELECT *
FROM employees
WHERE department = 'Finance' OR department = 'Sales';
```

### 6. Retrieve All Employees Not in IT
Filtered out employees from the Information Technology department to identify remaining personnel requiring machine updates.

```sql
SELECT *
FROM employees
WHERE NOT department = 'Information Technology';
```

## Tools Used
- Language: SQL (MariaDB / MySQL syntax)
- Environment: Linux Terminal / SQL Shell