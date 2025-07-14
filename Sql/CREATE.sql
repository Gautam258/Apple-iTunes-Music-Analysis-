create table Artist(
	artist_id INT PRIMARY KEY,	
	name varchar(80)
)

ALTER TABLE public.artist
ALTER COLUMN name TYPE VARCHAR(100);

SELECT * FROM ARTIST;

CREATE TABLE album (
    album_id INTEGER PRIMARY KEY,
    title VARCHAR(200),
    artist_id INTEGER REFERENCES artist(artist_id)
);

CREATE TABLE genre (
    genre_id INTEGER PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE media_type (
    media_type_id INTEGER PRIMARY KEY,
    name VARCHAR(100)
);


CREATE TABLE track (
    track_id INTEGER PRIMARY KEY,
    name VARCHAR(200),
    album_id INTEGER REFERENCES album(album_id),
    media_type_id INTEGER REFERENCES media_type(media_type_id),
    genre_id INTEGER REFERENCES genre(genre_id),
    composer VARCHAR(200),
    milliseconds INTEGER,
    bytes INTEGER,
    unit_price NUMERIC(5,2)
);

CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    company VARCHAR(100),
    address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    phone VARCHAR(50),
    fax VARCHAR(50),
    email VARCHAR(150),
    support_rep_id INTEGER
);

CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY,
    last_name VARCHAR(100),
    first_name VARCHAR(100),
    title VARCHAR(100),
    reports_to INTEGER,
    levels INTEGER,
    birthdate DATE,
    hire_date DATE,
    address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    phone VARCHAR(50),
    fax VARCHAR(50),
    email VARCHAR(150)
);

CREATE TABLE invoice (
    invoice_id INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES customer(customer_id),
    invoice_date DATE,
    billing_address VARCHAR(200),
    billing_city VARCHAR(100),
    billing_state VARCHAR(100),
    billing_country VARCHAR(100),
    billing_postal_code VARCHAR(20),
    total NUMERIC(6,2)
);


CREATE TABLE invoice_line (
    invoice_line_id INTEGER PRIMARY KEY,
    invoice_id INTEGER REFERENCES invoice(invoice_id),
    track_id INTEGER REFERENCES track(track_id),
    unit_price NUMERIC(5,2),
    quantity INTEGER
);

CREATE TABLE playlist (
    playlist_id INTEGER PRIMARY KEY,
    name VARCHAR(100)
);


CREATE TABLE playlist_track (
    playlist_id INTEGER REFERENCES playlist(playlist_id),
    track_id INTEGER REFERENCES track(track_id),
    PRIMARY KEY (playlist_id, track_id)
);

SELECT * FROM artist;
SELECT COUNT(*) FROM customer;

SELECT * FROM track WHERE name IS NULL;
SELECT * FROM customer WHERE email IS NULL;

SELECT * FROM invoice WHERE total < 0;
SELECT * FROM employee WHERE birthdate > CURRENT_DATE;

