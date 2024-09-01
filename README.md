# Linu_Git-Assignment

# CoreDataEngineers ETL Pipeline and Data Analysis

## Project Overview

This repository contains Bash scripts and SQL queries designed to manage an ETL (Extract, Transform, Load) pipeline for CoreDataEngineers. The pipeline downloads, transforms, and loads data into specified directories, as well as handles data movement and database operations. Additionally, SQL queries are included to perform data analysis on competitor data.

## Directory Structure

```
CoreDataEngineers/
├── Scripts/
│   ├── Bash/
│   │   ├── etl_script.sh
│   │   ├── move_files.sh
│   │   └── load_to_postgres.sh
│   └── SQL/
│       ├── query1.sql
│       ├── query2.sql
│       ├── query3.sql
│       └── query4.sql
├── README.md
└── architecture_diagram.png
```

- **Bash Scripts:** Contains scripts for the ETL process, file movement, and loading data into a PostgreSQL database.
- **SQL Scripts:** Contains SQL queries for data analysis tasks.
- **README.md:** This documentation file.
- **architecture_diagram.png:** Visual representation of the ETL pipeline.

## ETL Pipeline

### 1. **Extraction**

- **Script:** `etl_script.sh`
- **Description:** 
  - Downloads a CSV file from a specified URL and saves it into the `raw` directory.
  - Confirms the file download.

### 2. **Transformation**

- **Script:** `etl_script.sh`
- **Description:**
  - Renames the column `Variable_code` to `variable_code`.
  - Selects the columns: `year`, `Value`, `Units`, and `variable_code`.
  - Saves the transformed data into `2023_year_finance.csv` in the `Transformed` directory.

### 3. **Loading**

- **Script:** `etl_script.sh`
- **Description:**
  - Moves the transformed file from the `Transformed` directory to the `Gold` directory.
  - Confirms the file movement.

### Cron Job Scheduling

To automate the ETL script, a cron job is scheduled to run daily at 12:00 AM. The cron job configuration is as follows:

```bash
0 0 * * * /path/to/your/etl_script.sh
```

This ensures the ETL process is executed every day at midnight.

## File Movement Script

### **Script:** `move_files.sh`

- **Description:** 
  - Moves all CSV and JSON files from a source folder to a `json_and_CSV` folder.
  - Confirms the files have been moved.

## Loading Data into PostgreSQL

### **Script:** `load_to_postgres.sh`

- **Description:**
  - Iterates through each CSV file in a directory and copies the data into a PostgreSQL database named `posey`.
  - Confirms each file's successful copy into the database.

## Data Analysis with SQL

### 1. **Query:** `query1.sql`

```sql
-- Find a list of order IDs where either gloss_qty or poster_qty is greater than 4000.
-- Only include the id field in the resulting table.

SELECT id 
FROM orders 
WHERE gloss_qty > 4000 OR poster_qty > 4000;
```

### 2. **Query:** `query2.sql`

```sql
-- Write a query that returns a list of orders where the standard_qty is zero 
-- and either the gloss_qty or poster_qty is over 1000.

SELECT * 
FROM orders 
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);
```

### 3. **Query:** `query3.sql`

```sql
-- Find all the company names that start with a 'C' or 'W',
-- and where the primary contact contains 'ana' or 'Ana', but does not contain 'eana'.

SELECT company_name 
FROM companies 
WHERE (company_name LIKE 'C%' OR company_name LIKE 'W%') 
AND (primary_contact LIKE '%ana%' OR primary_contact LIKE '%Ana%') 
AND primary_contact NOT LIKE '%eana%';
```

### 4. **Query:** `query4.sql`

```sql
-- Provide a table that shows the region for each sales rep along with their associated accounts.
-- Your final table should include three columns: the region name, the sales rep name, and the account name.
-- Sort the accounts alphabetically (A-Z) by account name.

SELECT regions.region_name, sales_reps.sales_rep_name, accounts.account_name
FROM regions
JOIN sales_reps ON regions.region_id = sales_reps.region_id
JOIN accounts ON sales_reps.sales_rep_id = accounts.sales_rep_id
ORDER BY accounts.account_name;
```

## Architectural Diagram

The ETL pipeline's architectural diagram is included in this repository. It visualizes the stages of data extraction, transformation, and loading.

![ETL Pipeline Architecture](architecture_diagram.png)

## Git Workflow

To ensure a smooth development process, follow these steps:

1. **Create a new branch:**
   ```bash
   git checkout -b feature/etl-pipeline
   ```
   
2. **Add and commit your changes:**
   ```bash
   git add .
   git commit -m "Added ETL pipeline scripts and SQL queries"
   ```

3. **Push the branch:**
   ```bash
   git push origin feature/etl-pipeline
   ```

4. **Open a pull request:** 
   - Merge your feature branch into the master branch via a pull request. Ensure all changes are reviewed before merging.

---

This README provides a comprehensive overview of the project, including the purpose of each script, the structure of the repository, and instructions for running and scheduling the scripts.
