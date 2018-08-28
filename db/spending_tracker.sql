DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;
DROP TABLE budgets;

CREATE TABLE merchants(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE tags(
  id SERIAL8 PRIMARY KEY,
  category VARCHAR(255)
);

CREATE TABLE transactions(
  id SERIAL8 PRIMARY KEY,
  description VARCHAR(255),
  merchant_id INT8 REFERENCES merchants(id),
  tag_id INT8 REFERENCES tags(id),
  amount REAL,
  transaction_date DATE
);

CREATE TABLE budgets(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  amount REAL,
  start_date DATE,
  finish_date DATE
);

--You won't be able to delete tags or merchants that have transactions linked. Data safety feature
