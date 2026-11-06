# Airline Customer Satisfaction & Service Analytics

A beginner-friendly end-to-end analytics project exploring passenger satisfaction, service ratings and flight delays using a public airline passenger satisfaction dataset.

## Project overview

This project analyses **103,904 passenger records across 25 columns** from the public Kaggle airline passenger satisfaction training dataset. It demonstrates a workflow spanning data inspection, relational database loading, SQL analysis, Python exploration and an interactive Power BI dashboard.

> **Dataset note:** This is a public sample dataset. It is not United Airlines' internal or confidential customer data.

## Objectives

- Inspect the dataset and assess basic data quality.
- Load passenger records into PostgreSQL.
- Use SQL to summarise satisfaction, passenger segments, service ratings and delays.
- Use Python and Pandas for data checks and exploratory visualisation.
- Build an interactive Power BI dashboard with KPI cards, charts and slicers.
- Translate analytical patterns into practical areas for further investigation.

## Tools

- Microsoft Excel
- PostgreSQL and pgAdmin
- SQL
- Python, Pandas and Matplotlib
- SQLAlchemy and psycopg2
- Power BI Desktop and DAX

## Repository structure

```text
Airline-Customer-Satisfaction-Analytics/
├── README.md
├── docs/
│   ├── Airline_Customer_Satisfaction_Professional_Report.docx
│   └── Airline_Customer_Satisfaction_Professional_Report.pdf
├── sql/
│   └── analysis_queries.sql
├── python/
│   └── import_airline_data_template.py
└── images/
    └── (add dashboard screenshots here)
```

## Key findings recorded during the project

| Analysis | Result |
|---|---:|
| Passenger records analysed | 103,904 |
| Dataset columns | 25 |
| Missing arrival-delay values | 310 |
| Duplicate passenger IDs found | 0 |
| Exact duplicate rows found | 0 |
| Satisfied passengers | 58,879 (56.67%) |
| Neutral or dissatisfied passengers | 45,025 (43.33%) |

### Selected findings

- Business Class had the highest recorded satisfaction rate among the three classes analysed (69.43%).
- Loyal customers had a higher recorded satisfaction rate than disloyal customers (47.73% versus 23.67%).
- Satisfaction rates declined across the departure-delay categories in the analysis.
- Online boarding showed the largest rating gap among the three selected services compared: 1.37 points.
- In-flight Wi-Fi had the lowest overall average rating among the listed services (2.73).

These are descriptive results from this dataset. They indicate associations and differences, not causal relationships or guaranteed outcomes for any particular airline.

## Dashboard

The Power BI report includes:
- KPI cards for total, satisfied, and neutral or dissatisfied passengers.
- Satisfaction comparisons by class, customer type, travel type and age group.
- Departure-delay and average-delay analysis.
- Service rating comparisons and selected service rating gaps.
- Four slicers: Satisfaction, Customer Type, Class and Type of Travel.

**Add your Power BI file** (`Airline_Customer_Satisfaction_Analysis.pbix`) to the repository before publishing if you want visitors to download and inspect it. Also add screenshots of the finished dashboard to `images/` and link them here.

## How to use

1. Obtain the public dataset from its original Kaggle source and review its terms of use.
2. Create a PostgreSQL database named `airline_analysis`.
3. Create the `passengers` table using the schema used in your project.
4. Review `python/import_airline_data_template.py`, update the CSV path and database connection details, and run it locally.
5. Run the SQL statements in `sql/analysis_queries.sql` after confirming that your table and column names match.
6. Open the `.pbix` file in Power BI Desktop and configure the PostgreSQL connection if prompted.

Do not commit database passwords, API keys, personal data or other secrets. Do not upload a dataset unless its licence and redistribution terms permit it.

## Project report

See the Word and PDF reports in the `docs/` folder. Replace `[Your Name]` in the report cover page before sharing.

## Limitations

- The project uses a public sample dataset, not proprietary airline data.
- There are 310 missing arrival-delay values; averages for this field use available values.
- The analysis is primarily descriptive and does not establish causation.
- Results should not be generalised to all airlines or passenger populations without further validation.

## Author

**[Your Name]**  
B.Sc. Statistics, Loyola College, Chennai

