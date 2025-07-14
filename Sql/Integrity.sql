SELECT * 
FROM album 
WHERE artist_id NOT IN (SELECT artist_id FROM artist)
   OR artist_id IS NULL;

SELECT * 
FROM track 
WHERE album_id NOT IN (SELECT album_id FROM album)
   OR album_id IS NULL;


SELECT * 
FROM track 
WHERE media_type_id NOT IN (SELECT media_type_id FROM media_type)
   OR media_type_id IS NULL;

SELECT * 
FROM invoice 
WHERE customer_id NOT IN (SELECT customer_id FROM customer)
   OR customer_id IS NULL;


SELECT * 
FROM invoice_line 
WHERE invoice_id NOT IN (SELECT invoice_id FROM invoice)
   OR invoice_id IS NULL;

SELECT * 
FROM invoice_line 
WHERE track_id NOT IN (SELECT track_id FROM track)
   OR track_id IS NULL;

SELECT * 
FROM customer 
WHERE support_rep_id NOT IN (SELECT employee_id FROM employee)
   OR support_rep_id IS NULL;

SELECT * 
FROM playlist_track 
WHERE playlist_id NOT IN (SELECT playlist_id FROM playlist)
   OR track_id NOT IN (SELECT track_id FROM track)
   OR playlist_id IS NULL
   OR track_id IS NULL;
