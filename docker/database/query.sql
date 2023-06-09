CREATE TABLE IF NOT EXISTS  items (
    id serial PRIMARY KEY,
    name VARCHAR (50) NOT NULL,
    quantity INT NOT NULL
);

INSERT INTO items VALUES (1,'MACARRONES',8); -- on CONFLICT (name,quantity) do nothing; 
INSERT INTO items VALUES (2,'PANCETA',72); -- on CONFLICT (name,quantity) do nothing; 
INSERT INTO items VALUES (3,'COCACOLA',81); -- on CONFLICT (name,quantity) do nothing; 
INSERT INTO items VALUES (4,'FANTA',52); -- on CONFLICT (name,quantity) do nothing; 
INSERT INTO items VALUES (5,'PIZZA',45); -- on CONFLICT (name,quantity) do nothing; 
