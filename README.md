# Apple iTunes Music Store Analytics 📊🎵

This repository contains a full-scale data analytics project performed on the Apple iTunes Music Store dataset using **PostgreSQL** for querying and **Power BI** for dashboard creation and storytelling.

## 📌 Project Overview

The aim of this project is to extract actionable business insights from Apple’s music store data. The project covers customer segmentation, revenue breakdown, genre and artist performance, purchase patterns, and regional trends.

Through this dashboard, stakeholders can understand:
- Who their best customers are
- What genres and tracks perform best
- When and where revenue peaks occur
- How employees contribute to customer success

---

## 📁 Dataset Information

The dataset is sourced from a mock Apple iTunes database and includes the following tables:

- `customer`
- `invoice`
- `invoice_line`
- `track`
- `album`
- `artist`
- `genre`
- `employee`
- `media_type`
- `playlist`
- `playlist_track`

---

## 🧰 Tools & Technologies Used

| Tool           | Purpose                                 |
|----------------|------------------------------------------|
| PostgreSQL     | Data cleaning and SQL querying           |
| Power BI       | Dashboard development and visualization  |
| DAX            | Measures, KPIs, and filters              |
| Excel (Optional) | Data transformation                    |

---

## 📊 Dashboard Features

The final Power BI dashboard contains:

- ✅ Average Invoice Value, Total Revenue, Total Invoices, Tracks Sold, Active Customers
- ✅ Monthly Revenue Trend (with time slicer)
- ✅ Revenue by Country and by Employee
- ✅ Most Purchased Tracks and Top Revenue-Generating Tracks
- ✅ Top 10 Customers by Spend
- ✅ Sales Distribution by Genre and Media Type
- ✅ Time Between Customer Purchases (Histogram)
- ✅ Popular Playlists in Purchases
- ✅ Filters: Date, Country, Genre

> 🔎 The dashboard provides interactive filtering to help stakeholders drill into specific trends and patterns.

---

## 📈 SQL Query Categories

The project includes over 30 well-structured SQL queries, organized into categories such as:

### 1. Customer Analytics
- Top spending customers
- Customer lifetime value
- One-time vs. repeat customers
- Inactive users (past 6 months)

### 2. Sales & Revenue Analysis
- Monthly & quarterly trends
- Average invoice value
- Employee revenue contribution

### 3. Product Performance
- Tracks & albums never purchased
- Revenue by genre
- Frequently bought together tracks

### 4. Artist & Genre Insights
- Top performing artists
- Popular genres by sales and revenue

### 5. Operational & Regional Analysis
- Revenue by country and city
- Underserved regions (low revenue per customer)
- Average customers per employee

---

## 💡 Key Insights

- 🎯 USA and Canada contribute the highest revenue.
- 🎵 Rock and Metal genres dominate both in availability and popularity.
- 🧍 A small group of customers generates a large portion of revenue.
- 📉 Some regions have high customer counts but low revenue per user.
- ⏱️ Most users make repeat purchases within 10–20 days.

---

## 📝 Conclusion

This project demonstrates how SQL and Power BI can be used together to transform raw music store data into meaningful business insights. It serves as a solid example of real-world data storytelling and dashboarding skills suitable for analytics roles.

---

## 🚀 How to Use

1. Download or clone this repository.
2. Connect Power BI to your PostgreSQL database using the included queries.
3. Import the Power BI `.pbix` dashboard file (if provided).
4. Customize filters to explore insights interactively.

---


