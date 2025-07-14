1) Customer Analytics (Detailed Explanation)
Q1: Which customers have spent the most money on music?

SELECT 
  c.customer_id,
  c.first_name || ' ' || c.last_name AS customer_name,
  ROUND(SUM(i.total), 2) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 10;

Q2: What is the average customer lifetime value?

SELECT ROUND(AVG(customer_total), 2) AS avg_lifetime_value
FROM (
  SELECT customer_id, SUM(total) AS customer_total
  FROM invoice
  GROUP BY customer_id
) sub;

Q3: How many customers have made repeat purchases vs one-time purchases?
SELECT 
  purchase_count,
  COUNT(customer_id) AS customer_count
FROM (
  SELECT customer_id, COUNT(*) AS purchase_count
  FROM invoice
  GROUP BY customer_id
) sub
GROUP BY purchase_count
ORDER BY purchase_count;

🔹 Q4: Which country generates the most revenue per customer?
SELECT 
  c.country,
  COUNT(DISTINCT c.customer_id) AS total_customers,
  ROUND(SUM(i.total), 2) AS total_revenue,
  ROUND(SUM(i.total)/COUNT(DISTINCT c.customer_id), 2) AS revenue_per_customer
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.country
ORDER BY revenue_per_customer DESC;

🔹 Q5: Which customers haven’t made a purchase in the last 6 months?
SELECT 
  c.customer_id,
  c.first_name || ' ' || c.last_name AS customer_name,
  MAX(i.invoice_date) AS last_purchase_date
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, customer_name
HAVING MAX(i.invoice_date) < CURRENT_DATE - INTERVAL '6 months';

Sales & Revenue Analysis
Q1)What are the monthly revenue trends for the last two years?
SELECT 
  MIN(invoice_date) AS earliest_date,
  MAX(invoice_date) AS latest_date
FROM invoice;

SELECT 
  DATE_TRUNC('month', invoice_date) AS month,
  ROUND(SUM(total), 2) AS monthly_revenue
FROM invoice
GROUP BY month
ORDER BY month;

🔹 Q2. What is the average value of an invoice (purchase)?
SELECT 
  ROUND(AVG(total), 2) AS average_invoice_value
FROM invoice;


Q3. How much revenue does each sales representative contribute?
SELECT 
  e.employee_id,
  e.first_name || ' ' || e.last_name AS employee_name,
  ROUND(SUM(i.total), 2) AS total_revenue
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, employee_name
ORDER BY total_revenue DESC;

Q4. Which months or quarters have peak music sales?

SELECT 
  EXTRACT(MONTH FROM invoice_date) AS month,
  ROUND(SUM(total), 2) AS total_sales
FROM invoice
GROUP BY month
ORDER BY total_sales DESC;


SELECT 
  EXTRACT(QUARTER FROM invoice_date) AS quarter,
  ROUND(SUM(total), 2) AS total_sales
FROM invoice
GROUP BY quarter
ORDER BY total_sales DESC;

🔹 Q1: Which tracks generated the most revenue?

SELECT 
  t.track_id,
  t.name AS track_name,
  ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
GROUP BY t.track_id, t.name
ORDER BY total_revenue DESC
LIMIT 10;

Q2: Which albums or playlists are most frequently purchased?
Albums

SELECT 
  a.album_id,
  a.title AS album_title,
  ROUND(SUM(il.unit_price * il.quantity), 2) AS total_album_revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN album a ON t.album_id = a.album_id
GROUP BY a.album_id, a.title
ORDER BY total_album_revenue DESC
LIMIT 10;

Playlist
SELECT 
  p.playlist_id,
  p.name AS playlist_name,
  COUNT(pt.track_id) AS total_tracks
FROM playlist p
JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
GROUP BY p.playlist_id, p.name
ORDER BY total_tracks DESC
LIMIT 10;

🔹 Q3: Are there any tracks or albums that have never been purchased?
Track
SELECT 
  t.track_id,
  t.name AS track_name
FROM track t
LEFT JOIN invoice_line il ON t.track_id = il.track_id
WHERE il.track_id IS NULL;

Album
SELECT 
  a.album_id,
  a.title
FROM album a
LEFT JOIN track t ON a.album_id = t.album_id
LEFT JOIN invoice_line il ON t.track_id = il.track_id
WHERE il.track_id IS NULL;

🔹 Q4: What is the average price per track across genres?
SELECT 
  g.name AS genre_name,
  ROUND(AVG(t.unit_price), 2) AS avg_price
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
ORDER BY avg_price DESC;

🔹 Q5: How many tracks per genre, and how does it correlate with sales?
Step 1: Track Count Per Genre
SELECT 
  g.name AS genre_name,
  COUNT(t.track_id) AS total_tracks
FROM genre g
JOIN track t ON g.genre_id = t.genre_id
GROUP BY g.name
ORDER BY total_tracks DESC;

Step 2: Revenue Per Genre
SELECT 
  g.name AS genre_name,
  ROUND(SUM(il.unit_price * il.quantity), 2) AS total_genre_revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
ORDER BY total_genre_revenue DESC;

Artist & Genre Performance Analysis

🔹 Q1: Who are the top 5 highest-grossing artists?
SELECT 
  ar.artist_id,
  ar.name AS artist_name,
  ROUND(SUM(il.unit_price * il.quantity), 2) AS total_revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN album al ON t.album_id = al.album_id
JOIN artist ar ON al.artist_id = ar.artist_id
GROUP BY ar.artist_id, ar.name
ORDER BY total_revenue DESC
LIMIT 5;

🔹 Q2: Which music genres are most popular in terms of:
(a) Number of Tracks Sold
SELECT 
  g.name AS genre_name,
  SUM(il.quantity) AS total_tracks_sold
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
ORDER BY total_tracks_sold DESC;

(b) Total Revenue Generated
SELECT 
  g.name AS genre_name,
  ROUND(SUM(il.unit_price * il.quantity), 2) AS total_genre_revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
ORDER BY total_genre_revenue DESC;

🔹 Q3: Are certain genres more popular in specific countries?
SELECT 
  c.country,
  g.name AS genre_name,
  ROUND(SUM(il.unit_price * il.quantity), 2) AS genre_revenue
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY c.country, g.name
ORDER BY c.country, genre_revenue DESC;

Employee & Operational Efficiency Analysis
Q1: Which employees (support reps) are managing the highest-spending customers?
SELECT 
  e.employee_id,
  e.first_name || ' ' || e.last_name AS employee_name,
  ROUND(SUM(i.total), 2) AS total_customer_spend
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, employee_name
ORDER BY total_customer_spend DESC;

🔹 Q2: What is the average number of customers per employee?
SELECT 
  ROUND(AVG(customer_count), 2) AS avg_customers_per_employee
FROM (
  SELECT 
    e.employee_id,
    COUNT(c.customer_id) AS customer_count
  FROM employee e
  LEFT JOIN customer c ON e.employee_id = c.support_rep_id
  GROUP BY e.employee_id
) sub;

🔹 Q3: Which employee regions bring in the most revenue?
SELECT 
  e.country,
  ROUND(SUM(i.total), 2) AS total_revenue
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.country
ORDER BY total_revenue DESC;


Geographic Trends Analysis
🔹 Q1: Which countries or cities have the highest number of customers?
Country
SELECT 
  country,
  COUNT(customer_id) AS customer_count
FROM customer
GROUP BY country
ORDER BY customer_count DESC;

City
SELECT 
  city,
  COUNT(customer_id) AS customer_count
FROM customer
GROUP BY city
ORDER BY customer_count DESC
LIMIT 10;

Q2: How does revenue vary by region (country)?
SELECT 
  c.country,
  ROUND(SUM(i.total), 2) AS total_revenue
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC;

🔹 Q3: Are there underserved regions (high customers but low revenue)?
SELECT 
  c.country,
  COUNT(DISTINCT c.customer_id) AS total_customers,
  ROUND(SUM(i.total), 2) AS total_revenue,
  ROUND(SUM(i.total) / COUNT(DISTINCT c.customer_id), 2) AS avg_revenue_per_customer
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.country
ORDER BY avg_revenue_per_customer ASC;


Customer Retention & Purchase Patterns

🔹 Q1: What is the average time between purchases per customer?
SELECT 
  customer_id,
  ROUND(AVG(days_between), 2) AS avg_days_between_purchases
FROM (
  SELECT 
    customer_id,
    invoice_date,
    LEAD(invoice_date) OVER (PARTITION BY customer_id ORDER BY invoice_date) - invoice_date AS days_between
  FROM invoice
) sub
WHERE days_between IS NOT NULL
GROUP BY customer_id
ORDER BY avg_days_between_purchases;

🔹 Q3: What percentage of customers purchase from more than one genre?
SELECT 
  ROUND(
    100.0 * COUNT(DISTINCT multi_genre.customer_id) / COUNT(DISTINCT c.customer_id), 2
  ) AS percentage_multi_genre_customers
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN (
  SELECT customer_id
  FROM (
    SELECT 
      c.customer_id,
      COUNT(DISTINCT t.genre_id) AS genre_count
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    GROUP BY c.customer_id
  ) genre_data
  WHERE genre_count > 1
) multi_genre ON c.customer_id = multi_genre.customer_id;

SELECT 
  c.customer_id,
  COUNT(DISTINCT t.genre_id) AS genre_count
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
GROUP BY c.customer_id
ORDER BY genre_count DESC;


Operational Optimization & Purchase Patterns
Q1: What are the most common combinations of tracks purchased together?
SELECT 
    il1.track_id AS track_1,
    il2.track_id AS track_2,
    COUNT(*) AS times_bought_together
FROM invoice_line il1
JOIN invoice_line il2 
    ON il1.invoice_id = il2.invoice_id
    AND il1.track_id < il2.track_id
GROUP BY track_1, track_2
ORDER BY times_bought_together DESC
LIMIT 10;


SELECT 
    t1.name AS track_1_name,
    t2.name AS track_2_name,
    common.times_bought_together
FROM (
    SELECT 
        il1.track_id AS track_1,
        il2.track_id AS track_2,
        COUNT(*) AS times_bought_together
    FROM invoice_line il1
    JOIN invoice_line il2 
        ON il1.invoice_id = il2.invoice_id
        AND il1.track_id < il2.track_id
    GROUP BY track_1, track_2
    ORDER BY times_bought_together DESC
    LIMIT 10
) common
JOIN track t1 ON common.track_1 = t1.track_id
JOIN track t2 ON common.track_2 = t2.track_id;


🔹 Q2: Are there pricing patterns that lead to higher or lower sales?
SELECT 
    unit_price,
    COUNT(*) AS track_sold
FROM invoice_line
GROUP BY unit_price
ORDER BY unit_price;

SELECT 
    unit_price,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(unit_price * quantity), 2) AS total_revenue
FROM invoice_line
GROUP BY unit_price
ORDER BY unit_price;


🔹 Q3: Which media types are increasing or declining in usage?
SELECT 
    mt.name AS media_type,
    COUNT(*) AS tracks_sold
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN media_type mt ON t.media_type_id = mt.media_type_id
GROUP BY mt.name
ORDER BY tracks_sold DESC;
