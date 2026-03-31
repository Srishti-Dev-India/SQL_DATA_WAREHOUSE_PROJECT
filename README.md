# SQL_DATA_WAREHOUSE_PROJECT
Building a modern data warehouse with SQL server, including ELT processes, data modeling and analytics

## 📌 Project Overview

This project showcases the design and implementation of a **modern data warehouse** using **SQL Server**, following the **Medallion Architecture (Bronze, Silver, Gold layers)**.

The solution transforms raw data from multiple sources into **business-ready datasets** for reporting, analytics, and machine learning.

---

## 🎯 Objectives

* Build a scalable data warehouse using SQL Server
* Implement ELT pipelines for structured data transformation
* Apply layered architecture (Bronze → Silver → Gold)
* Enable analytics, reporting, and ad-hoc querying

---

## 🧱 High-Level Architecture

```text id="arch001"
Sources (CRM, ERP CSV Files)
        ↓
Bronze Layer (Raw Data)
        ↓
Silver Layer (Cleaned & Standardized Data)
        ↓
Gold Layer (Business-Ready Data)
        ↓
Consumption (BI, SQL Queries, ML)
```

---

## 📥 Data Sources

* CRM data (CSV files)
* ERP data (CSV files)

**Interface:** Files are ingested from folders into SQL Server.

---

## 🥉 Bronze Layer (Raw Data)

**Purpose:**
Store raw, unprocessed data exactly as received from source systems.

**Key Characteristics:**

* Data is loaded **as-is**
* No transformations applied
* Maintains original structure

**Load Strategy:**

* Batch processing
* Full load
* Truncate & Insert

**Data Model:**

* None (raw tables)

---

## 🥈 Silver Layer (Cleaned & Standardized Data)

**Purpose:**
Clean, validate, and standardize data for downstream use.

**Transformations Applied:**

* Data cleansing (handling nulls, duplicates)
* Data standardization (formats, naming)
* Data normalization
* Derived columns
* Data enrichment

**Load Strategy:**

* Batch processing
* Full load
* Truncate & Insert

**Data Model:**

* Structured tables (still close to source)

---

## 🥇 Gold Layer (Business-Ready Data)

**Purpose:**
Provide optimized datasets for analytics and reporting.

**Transformations Applied:**

* Data integration (combining multiple sources)
* Aggregations
* Business logic implementation

**Data Model:**

* Star Schema
* Fact tables
* Dimension tables
* Aggregated tables

---

## 📊 Data Modeling

### ⭐ Star Schema Design

**Fact Tables:**

* Store measurable business metrics (e.g., sales, transactions)

**Dimension Tables:**

* Provide context (e.g., customer, product, date)

---

## 📈 Data Consumption

The Gold Layer supports:

* 📊 BI & Reporting (e.g., dashboards)
* 🧮 Ad-hoc SQL queries
* 🤖 Machine Learning use cases

---

## ⚙️ Technologies Used

* Microsoft SQL Server
* T-SQL (SQL Server)
* Git & GitHub

---

## 🔄 ELT Workflow

1. **Extract**

   * Data collected from CRM and ERP CSV files

2. **Load**

   * Raw data loaded into Bronze tables

3. **Transform**

   * Data cleaned in Silver layer
   * Business logic applied in Gold layer

---

## 📂 Project Structure

```text id="arch002"
├── data/              # Source CSV files (CRM, ERP)
├── bronze/            # Raw data loading scripts
├── silver/            # Data cleaning & transformation scripts
├── gold/              # Final data models (fact & dimension tables)
├── analytics/         # SQL queries for insights
└── README.md
```

---

## 🚀 Key Features

* Layered Medallion Architecture
* Scalable ELT pipeline design
* Clean separation of raw, processed, and business data
* Optimized for analytics and reporting

---

## 📊 Future Enhancements

* Incremental data loading
* Indexing and performance tuning
* Integration with Power BI dashboards
* Pipeline automation (SQL Server Agent)
* Data quality monitoring

---

## 🙌 Acknowledgements

This project was built as part of a guided data engineering learning journey.

Special thanks to **Mr. Baraa Khatib Salkini** for his mentorship and for providing clear guidance on building modern data warehouse architectures using SQL Server.

---

## 🌟 About Me

Hi, I'm **Srishti Dev** — a **Data Engineer specializing in SQL Server, Python, and Data Warehousing**.  

I approach data handling with a structured, problem-solving mindset—transforming raw data into clean, scalable, and insight-ready systems.

---

## 🔗 Connect With Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/srishti-dev-sr1r1s/)
[![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/srishti_devv/)
[![Facebook](https://img.shields.io/badge/Facebook-1877F2?style=for-the-badge&logo=facebook&logoColor=white)](https://www.facebook.com/srishti.dev.1)

---

📞 **Phone:** +91-8151815223  
📍 **Location:** India  
🚀 **Open to:** Data Engineering | SQL Developer | Analytics Roles  

---
