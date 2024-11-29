--ONE TO ONE RELATIONSHIP(WITH INNER JOIN)


CREATE TABLE AccountHolders (
                                account_holder_id INTEGER PRIMARY KEY,
                                first_name VARCHAR(100),
                                last_name VARCHAR(100)
);

CREATE TABLE CreditCards (
                             card_id SERIAL PRIMARY KEY,
                             account_holder_id INTEGER UNIQUE REFERENCES AccountHolders(account_holder_id),
                             card_number VARCHAR(16),
                             issuance_date DATE,
                             expiration_date DATE
);

INSERT INTO AccountHolders(account_holder_id,first_name,last_name)
VALUES (1,'Emrah','Garashov'),
       (2,'Ferid','Hacibabazade'),
       (3,'Vaqif','Bennali');

INSERT INTO CreditCards(card_id,account_holder_id, card_number, issuance_date, expiration_date)
VALUES(1001,1,'1234567812345678','2024-11-28','2034-11-28'),
      (1002,2,'2345678923456789','2024-11-28','2034-11-28'),
      (1003,3,'3456789034567890','2024-11-28','2034-11-28');

SELECT a.account_holder_id,a.first_name,a.last_name,cc.card_number,cc.issuance_date,cc.expiration_date
FROM CreditCards cc
INNER JOIN AccountHolders a on cc.account_holder_id = a.account_holder_id;





-- ONE TO MANY RELATIONSHIP (WITH LEFT JOIN)





CREATE TABLE Companies (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(100) UNIQUE
);



CREATE TABLE Projects (
                          project_id SERIAL PRIMARY KEY,
                          company_id INTEGER REFERENCES Companies(id),
                          project_name VARCHAR(100) UNIQUE,
                          has_patent BOOLEAN
);

INSERT INTO Companies(id,name)
VALUES (1,'ACCORD MMC'),
       (2,'BCC Group'),
       (3,'AZERCONS');

INSERT INTO Projects(project_id,company_id, project_name, has_patent)
VALUES (101,1,'BAKU INTERNATIONAL CENTER',FALSE),
       (102,2,'QOBU POWER PLANT',TRUE),
       (103,3,'Muganli-Ismayilli-Gabala Road',TRUE),
       (104,2,'Baku White City Project',TRUE),
       (105,3,'Pert Baku Towers',True);

SELECT c.id,c.name,p.project_name,p.has_patent
FROM Projects p
LEFT JOIN Companies c ON c.id = p.company_id;




--MANY TO MANY RELATIONSHIP(WITH FULL JOIN)


CREATE TABLE Restaurants (
                             restaurant_id INT PRIMARY KEY,
                             restaurant_name VARCHAR(100),
                             location VARCHAR(100)
);


CREATE TABLE Chefs (
                       chef_id INT PRIMARY KEY,
                       chef_name VARCHAR(100),
                       specialty VARCHAR(100)
);


CREATE TABLE Restaurant_Chef (
                                 restaurant_id INT,
                                 chef_id INT,
                                 PRIMARY KEY (restaurant_id, chef_id),
                                 FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id),
                                 FOREIGN KEY (chef_id) REFERENCES Chefs(chef_id)
);

INSERT INTO Restaurants (restaurant_id, restaurant_name, location)
VALUES
    (1, 'EG', 'BAKU'),
    (2, 'BAVEL', 'LOS ANGELES');

INSERT INTO Chefs (chef_id, chef_name, specialty)
VALUES
    (1, 'DANILO ZANNA', 'Italian Cuisine'),
    (2, 'PAUL BOCUSE', 'French Cuisine'),
    (3, 'JIRO ONO', 'Japanese Cuisine');

INSERT INTO Restaurant_Chef (restaurant_id, chef_id)
VALUES (1, 1),
       (1, 2),
       (2, 2),
       (2, 3);



SELECT
    Restaurants.restaurant_id,
    Restaurants.restaurant_name AS restaurant_name,
    Restaurants.location,
    Chefs.chef_id,
    Chefs.chef_name AS chef_name,
    Chefs.specialty
FROM Restaurant_Chef
FULL JOIN Restaurants ON Restaurant_Chef.restaurant_id = Restaurants.restaurant_id
FULL JOIN Chefs ON Restaurant_Chef.chef_id = Chefs.chef_id;

