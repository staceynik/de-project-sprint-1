# RFM Data Mart for Food Delivery App

## Overview

This repository contains SQL scripts and documentation for building a data mart used for RFM (Recency, Frequency, Monetary) classification of users for a food delivery application. The RFM model is a marketing analysis tool used to identify the best customers by examining how recently a customer has ordered (recency), how often they order (frequency), and how much the customer spends (monetary).

## Repository Structure

- `README.md`: This document, providing an overview of the project and descriptions of the contents of the repository.
- `data_quality.md`: Documentation that assesses the quality of the source data from the production schema and the tools used to ensure data quality.
- `datamart_ddl.sql`: Data Definition Language (DDL) SQL script for creating the data mart structure in the `analysis` schema.
- `datamart_query.sql`: SQL script for populating the data mart with RFM segments based on the calculations from temporary tables.
- `orders_view.sql`: SQL script that creates or updates the `analysis.Orders` view to reflect changes in the `production` schema, particularly the new `OrderStatusLog` table.
- `tmp_rfm_frequency.sql`: SQL script for calculating and storing the frequency aspect of the RFM analysis in a temporary table.
- `tmp_rfm_monetary_value.sql`: SQL script for calculating and storing the monetary value aspect of the RFM analysis in a temporary table.
- `tmp_rfm_recency.sql`: SQL script for calculating and storing the recency aspect of the RFM analysis in a temporary table.
- `views.sql`: SQL script containing all the create view statements for the `analysis` schema, which reflect data from the `production` schema without duplication.

## Project Steps

1. **Data Mart Construction for RFM Analysis**:
   - Connection to the company database to study the table structures.
   - Creation of views in the `analysis` schema to reflect the `production` schema data.
   - Writing DDL scripts for the data mart creation and SQL scripts for populating it.

2. **Data Quality Analysis**:
   - Evaluation of the source data's quality.
   - Use of data quality tools within the `production` schema tables.

3. **Temporary RFM Calculation Tables**:
   - Step-by-step calculation of RFM metrics in temporary tables.

4. **Finalizing the RFM Data Mart**:
   - Compilation of the final RFM segments into the data mart.

5. **Updating Views Post-Changes in Production Schema**:
   - Modification of the `analysis.Orders` view to incorporate changes from the backend application data structure updates.

## How to Use

Each SQL script is named according to its function within the project. To replicate the data mart, execute the scripts in the following order:
1. `views.sql`
2. `tmp_rfm_recency.sql`
3. `tmp_rfm_frequency.sql`
4. `tmp_rfm_monetary_value.sql`
5. `datamart_ddl.sql`
6. `datamart_query.sql`
7. `orders_view.sql` (if the `production` schema structure has changed)

Refer to `data_quality.md` for information on the quality of the source data and the methods used to ensure it.

## Requirements

- Access to the company's database with the `production` and `analysis` schemas.
- Permissions to create views, tables, and execute scripts within the database.

