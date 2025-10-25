# Indian-Census-2011-Data-Exploration

This repository showcases my **data analysis skills** using **SQL**, focused on exploring the **Indian Census 2011 datasets**. The project demonstrates how to clean, aggregate, and derive insights from real-world population data using **MS SQL Server**.

---

## Project Overview

The repository contains three files:  

- **Dataset1.xlsx** – Census data including district-wise population, literacy, sex ratio, and growth.  
- **Dataset2.xlsx** – Supporting dataset with district area and additional demographic information.  
- **SQL_Code.sql** – Contains all SQL queries used to explore and analyze the datasets.

The objective was to explore demographic patterns across India, understand growth trends, and calculate key statistics using SQL.

---

## Key Analyses Performed

### 1. Dataset Exploration
- Displaying all records from the datasets.  
- Counting total rows to understand dataset size.  
- Filtering specific states (`Jharkhand`, `Bihar`) for focused analysis.

### 2. Population Analysis
- Calculating **total population of India**.  
- Estimating **previous census population** using growth rates.  
- Analyzing **population vs area** to calculate density trends.

### 3. Growth, Literacy, and Sex Ratio
- Computing **average population growth** at national and state levels.  
- Calculating **average literacy rates** and identifying top/bottom states.  
- Determining **average sex ratio** and estimating male/female population counts using T-SQL formulas.

### 4. Ranking and Top/Bottom Analysis
- Identifying **top 3 districts in each state** by literacy using the `RANK()` window function.  
- Creating temporary tables to combine and compare **top and bottom states** in literacy.

### 5. Advanced SQL Techniques
- Use of **temporary tables** (`#topstates`, `#bottomstates`).  
- Aggregations with `SUM()`, `AVG()`, `ROUND()`.  
- **Window functions** like `RANK()` and `PARTITION BY`.  
- Handling missing data and joining datasets with `INNER JOIN`.  

---

## Skills Demonstrated

- **SQL & T-SQL:** Aggregations, joins, window functions, temporary tables, data filtering.  
- **Data Analysis:** Population, literacy, sex ratio, and growth analysis.  
- **Problem Solving:** Translating demographic formulas into SQL queries.  
- **Database Management:** Importing Excel datasets into SQL Server and querying efficiently.

---

## How to Use

1. **Import Datasets:** Load `Dataset1.xlsx` and `Dataset2.xlsx` into SQL Server as `Data1` and `Data2`.  
2. **Run Queries:** Execute `SQL_Code.sql` in **SQL Server Management Studio (SSMS)** or **Azure Data Studio**.  
3. **Explore Results:** The queries provide detailed state-wise and district-wise insights.

---

## Repository Structure
  - Dataset1.xlsx
  - Dataset2.xlsx
  - SQL_Code.sql
