

CREATE TABLE Customer (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  second_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  genre VARCHAR(10) NOT NULL,
  address VARCHAR(100),
  date_of_birth DATE NOT NULL,
  item_id INTEGER REFERENCES Item(id)
);

CREATE TABLE IF NOT EXISTS CustomerType(
  id SERIAL PRIMARY KEY,
  descriptions VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS CustomerCustomertype(
   id SERIAL PRIMARY KEY,
   customer_id INTEGER REFERENCES Customer(id),
   customer_type_id INTEGER REFERENCES CustomerType(id)
);

CREATE TABLE IF NOT EXISTS Category (
  id SERIAL PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  path VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS ItemCategory(
   id SERIAL PRIMARY KEY,
   item_id INTEGER REFERENCES Item(id),
   category_id INTEGER REFERENCES Category(id)
);


CREATE TABLE IF NOT EXISTS Status(
  id SERIAL PRIMARY KEY,
  description VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Item (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  price DECIMAL NOT NULL,
  end_date DATE,
  status_id INTEGER REFERENCES Status(id)
);

CREATE TABLE IF NOT EXISTS Orders (
  id SERIAL PRIMARY KEY,
  purchase_date DATE NOT NULL,
  quantity INTEGER NOT NULL,
  item_id INTEGER REFERENCES Item(id) NOT NULL
);

CREATE TABLE IF NOT EXISTS ItemDaily(
  id SERIAL PRIMARY KEY, 
  item_id INTEGER REFERENCES Item(id),
  price DECIMAL NOT NULL,
  status_id INTEGER REFERENCES Status(id)
);

-- Insert multiple rows into the Customer table
INSERT INTO Customer (id, first_name, second_name, email, genre, address, date_of_birth, item_id)
VALUES
  (1,'John', 'Doe', 'john@example.com', 'Male', '123 Main St', '1990-01-01', 1),
  (2, 'Jane', 'Smith', 'jane@example.com', 'Female', '456 Elm St', '1992-05-15', 2),
  (3, 'Bob', 'Johnson', 'bob@example.com', 'Male', '789 Oak St', '1988-11-30', 3),
  (4,'Alice', 'Johnson', 'alice@example.com', 'Female', '789 Oak St', '1995-08-10', 1),
  (5, 'Michael', 'Brown', 'michael@example.com', 'Male', '456 Elm St', '1991-03-25', 3),
  (6,'Emily', 'Davis', 'emily@example.com', 'Female', '123 Main St', '1993-07-12', 2),
  (7,'Daniel', 'Wilson', 'daniel@example.com', 'Male', '789 Oak St', '1989-09-05', 4),
  (8,'Sophia', 'Martinez', 'sophia@example.com', 'Female', '456 Elm St', '1994-12-08', 5),
  (9, 'William', 'Anderson', 'william@example.com', 'Male', '123 Main St', '1996-02-18', 6),
  (10,'Olivia', 'Thomas', 'olivia@example.com', 'Female', '789 Oak St', '1997-06-21', 7),
  (11,'David', 'Taylor', 'david@example.com', 'Male', '456 Elm St', '1992-07-17', 1),
    (12,'Lipe', 'Doe', 'lipe@example.com', 'Male', '123 Main St', '1995-07-17', 1);


INSERT INTO CustomerType (id, descriptions)
VALUES 
   (1, 'seller'),
   (2, 'buyer')

INSERT INTO CustomerCustomertype (id, customer_id, customer_type_id)
VALUES 
   (1, 1, 1),
   (2, 2, 1),
   (3, 3, 1),
   (4, 4, 1),
   (5, 5, 2),
   (6, 6, 2),
   (7, 7, 1),
   (8, 8, 1),
   (9, 9, 2),
   (10, 10, 1),
   (11, 11, 1),
   (12, 12, 1);
-- Insert multiple rows into the Category table
INSERT INTO Category (id, description, path)
VALUES
  (1, 'Cellphone', 'fakepath'),
  (2,'Telefones', 'fakepath'), 
  (3,'Smartphone', 'fakepath'),
  (4, 'Books', 'fakepath'),
  (5, 'notebook','fakepath');

INSERT INTO Status (id, description)
VALUES
   (1, 'Ativo'),
   (2, 'Inativo')

-- Insert multiple rows into the Item table
INSERT INTO Item (id, name, status,price, end_date, status_id)
VALUES
  (1,'Item 1', 'Active', 2000.50, null, 1),
  (2, 'Item 2', 'Inactive', 1000, '2023-06-29', 2),
  (3,'Item 3', 'Active', 500, null, 1),
  (4,'Item 4', 'Active', 900, null, 1),
  (5,'Item 5', 'Inactive', 300, '2023-05-21', 2),
  (6,'Item 6', 'Active', 250, null, 1),
  (7,'Item 7', 'Inactive', 1500.90 ,'2023-04-29', 2),
  (8,'Item 8', 'Active', 550, null, 1),
  (9,'Item 9', 'Active', 660, null, 1),
  (10,'Item 10', 'Inactive', 340.99, '2023-07-14', 2),
  (11,'Item 11', 'Active', 425, null, 1),
  (12,'Item 12', 'Active', 125, null, 1),
  (13,'Item 13', 'Inactive', 1000, '2023-07-14', 2),
  (14,'Item 14', 'Active', 1500, null, 1),
  (15,'Item 15', 'Inactive', 1050, '2023-03-20', 2);


INSERT INTO ItemCategory(id, item_id, category_id)
VALUES
  (1, 1, 1),
  (2, 1, 2),
  (3, 1, 3),
  (4, 2, 1),
  (5, 2, 2),
  (6, 2, 3),
  (7, 3, 4),
  (8, 4, 1),
  (9, 4, 2),
  (10, 4, 3);

INSERT INTO Orders (id, purchase_date, quantity, item_id)
VALUES
  (1, '2020-01-05', 3,1),
  (2,'2020-02-12', 2,2),
  (3,'2020-03-20', 5, 3),
  (4,'2020-04-10', 1, 4),
  (5,'2020-05-15', 4, 5),
  (6,'2020-06-08', 2, 1),
  (7,'2020-07-25', 3, 6),
  (8,'2020-08-18', 2, 1),
  (9,'2020-09-02', 4, 2),
  (10,'2020-10-30', 3, 7),
  (11,'2020-10-30', 6, 7),
  (12,'2020-01-15', 6, 6);

  INSERT INTO TransactionType(id, customer_id, order_id, customer_type_id)
  VALUES
    (1, 1, 1, 1),
    (2, 2, 1, 2),
    (3, 3, 2, 2),
    (4, 4, 2, 1),
    (5, 5, 3, 1),
    (6,6, 3, 2 ),
    (7, 7, 4, 1),
    (8, 8, 4, 2),
    (9, 12, 11, 1),
    (10, 10, 11, 2)
    (11, 12, 12, 1),
    (12, 10, 12, 2);