CREATE DATABASE AIRLINE;
USE AIRLINE;
CREATE TABLE AIRPORT(
	AIRPORT_CODE CHAR(3) ,
	LOCATION VARCHAR(50),
	NO_OF_TERMINALS INTEGER,
	AIRPORT_TYPE VARCHAR(50),
	PRIMARY KEY (AIRPORT_CODE)
);

CREATE TABLE PASSENGER(
	PASSENGER_ID CHAR(6) UNIQUE,
	P_NAME VARCHAR(50),
	PASSPORT_NUMBER CHAR(15),
	ADDRESS VARCHAR(50),
	EMAIL VARCHAR(50) UNIQUE,
	PHONE_NUMBER BIGINT,
	AGE INTEGER,
	PRIMARY KEY (PASSENGER_ID)
);

CREATE TABLE FLIGHT(
	FLIGHT_ID VARCHAR(10),
	MODEL VARCHAR(50),
	CAPACITY INTEGER,
	PRICE FLOAT,
	CLASS VARCHAR(10) CHECK(CLASS IN('ECONOMY','BUSINESS')),
	PRIMARY KEY (FLIGHT_ID,CLASS)
);

CREATE TABLE ROUTE(
	FLIGHT_ID VARCHAR(10),
	CLASS VARCHAR(10) CHECK(CLASS IN('ECONOMY','BUSINESS')),
	ROUTE_NUMBER INTEGER,
	START_POINT CHAR(3),
	END_POINT CHAR(3),
	INTERMEDIATE_POINT CHAR(3),
	ARRIVAL_TIME VARCHAR(10),
	DEPARTURE_TIME VARCHAR(10),
	PRIMARY KEY (ROUTE_NUMBER,ARRIVAL_TIME,DEPARTURE_TIME),
	FOREIGN KEY (FLIGHT_ID,CLASS) REFERENCES FLIGHT(FLIGHT_ID,CLASS),
	FOREIGN KEY (START_POINT) REFERENCES AIRPORT(AIRPORT_CODE),
	FOREIGN KEY (INTERMEDIATE_POINT) REFERENCES AIRPORT(AIRPORT_CODE),
	FOREIGN KEY (END_POINT) REFERENCES AIRPORT(AIRPORT_CODE)
);

CREATE TABLE BOOKING(
	FLIGHT_ID VARCHAR(10),
	TICKET_NUMBER BIGINT,
    	DATE_OF_FLYING DATE,
	PASSENGER_ID CHAR(6),
	CLASS VARCHAR(10) CHECK(CLASS IN('ECONOMY','BUSINESS')),
	PAYMENT_MODE VARCHAR(10) CHECK(PAYMENT_MODE IN ('ONLINE','OFFLINE')),
	TICKET_STATUS VARCHAR(10) CHECK(TICKET_STATUS IN('CONFIRM','WAITING','CANCELLED')),
	PRIMARY KEY (TICKET_NUMBER),
	FOREIGN KEY (FLIGHT_ID,CLASS) REFERENCES FLIGHT(FLIGHT_ID,CLASS),
	FOREIGN KEY (PASSENGER_ID) REFERENCES PASSENGER(PASSENGER_ID)
);

INSERT INTO AIRPORT (AIRPORT_CODE, LOCATION, NO_OF_TERMINALS, AIRPORT_TYPE) VALUES
('JFK', 'New York, USA', 6, 'International'),
('LAX', 'Los Angeles, USA', 9, 'International'),
('ORD', 'Chicago, USA', 4, 'International'),
('DFW', 'Dallas, USA', 5, 'International'),
('DEN', 'Denver, USA', 3, 'International'),
('SFO', 'San Francisco, USA', 4, 'International'),
('SEA', 'Seattle, USA', 1, 'International'),
('LAS', 'Las Vegas, USA', 2, 'International'),
('MIA', 'Miami, USA', 3, 'International'),
('PHX', 'Phoenix, USA', 3, 'International'),
('IAH', 'Houston, USA', 5, 'International'),
('CLT', 'Charlotte, USA', 2, 'International'),
('EWR', 'Newark, USA', 3, 'International'),
('BOS', 'Boston, USA', 4, 'International'),
('ATL', 'Atlanta, USA', 2, 'International'),
('YUL', 'Montreal, Canada', 2, 'International'),
('YYZ', 'Toronto, Canada', 2, 'International'),
('LHR', 'London, UK', 5, 'International'),
('CDG', 'Paris, France', 3, 'International'),
('FRA', 'Frankfurt, Germany', 3, 'International');


INSERT INTO PASSENGER (PASSENGER_ID, P_NAME, PASSPORT_NUMBER, ADDRESS, EMAIL, PHONE_NUMBER, AGE) VALUES
('P001', 'John Doe', 'P123456789', '123 Main St, New York, USA', 'john.doe@example.com', 1234567890, 30),
('P002', 'Jane Smith', 'P987654321', '456 Elm St, Los Angeles, USA', 'jane.smith@example.com', 9876543210, 28),
('P003', 'Alice Johnson', 'P111111111', '789 Oak St, Chicago, USA', 'alice.johnson@example.com', 5551234567, 35),
('P004', 'Mike Brown', 'P222222222', '321 Pine St, Dallas, USA', 'bob.brown@example.com', 7778889999, 32),
('P005', 'Charlie Davis', 'P333333333', '901 Maple St, Denver, USA', 'charlie.davis@example.com', 3334445555, 29),
('P006', 'Emily White', 'P444444444', '234 Cedar St, San Francisco, USA', 'emily.white@example.com', 4445556666, 27),
('P007', 'Michael Green', 'P555555555', '567 Spruce St, Seattle, USA', 'michael.green@example.com', 5556667777, 33),
('P008', 'Sarah Taylor', 'P666666666', '890 Fir St, Las Vegas, USA', 'sarah.taylor@example.com', 6667778888, 31),
('P009', 'David Lee', 'P777777777', '345 Elm St, Miami, USA', 'david.lee@example.com', 7778889999, 36),
('P010', 'Laura Wilson', 'P888888888', '678 Oak St, Houston, USA', 'laura.wilson@example.com', 8889990000, 40),
('P011', 'George Harris', 'P999999999', '111 Maple St, Boston, USA', 'george.harris@example.com', 9990001111, 45),
('P012', 'Nancy Clark', 'P101010101', '222 Cedar St, Atlanta, USA', 'nancy.clark@example.com', 1010101010, 38),
('P013', 'Robert Lewis', 'P202020202', '333 Pine St, Charlotte, USA', 'robert.lewis@example.com', 2020202020, 29),
('P014', 'Linda Robinson', 'P303030303', '444 Spruce St, Denver, USA', 'linda.robinson@example.com', 3030303030, 26),
('P015', 'William Walker', 'P404040404', '555 Fir St, San Francisco, USA', 'william.walker@example.com', 4040404040, 34),
('P016', 'Patricia Martin', 'P505050505', '666 Elm St, Seattle, USA', 'patricia.martin@example.com', 5050505050, 31),
('P017', 'Kevin Thompson', 'P606060606', '777 Oak St, Las Vegas, USA', 'kevin.thompson@example.com', 6060606060, 39),
('P018', 'Susan Jackson', 'P707070707', '888 Maple St, Miami, USA', 'susan.jackson@example.com', 7070707070, 42),
('P019', 'Mark Davis', 'P808080808', '999 Cedar St, Houston, USA', 'mark.davis@example.com', 8080808080, 35),
('P020', 'Rebecca Hall', 'P909090909', '1010 Pine St, Boston, USA', 'rebecca.hall@example.com', 9090909090, 30),
('P021', 'James Brown', 'P1010101010', '1111 Spruce St, Atlanta, USA', 'james.brown@example.com', 1010101010, 28),
('P022', 'Jessica Lee', 'P2020202020', '1212 Fir St, Charlotte, USA', 'jessica.lee@example.com', 2020202020, 29),
('P023', 'Brian Taylor', 'P3030303030', '1313 Elm St, Denver, USA', 'brian.taylor@example.com', 3030303030, 31),
('P024', 'Lisa Nguyen', 'P4040404040', '1414 Oak St, San Francisco, USA', 'lisa.nguyen@example.com', 4040404040, 33),
('P025', 'Matthew White', 'P5050505050', '1515 Maple St, Seattle, USA', 'matthew.white@example.com', 5050505050, 36),
('P026', 'Amanda Martin', 'P6060606060', '1616 Cedar St, Las Vegas, USA', 'amanda.martin@example.com', 6060606060, 38),
('P027', 'Daniel Harris', 'P7070707070', '1717 Pine St, Miami, USA', 'daniel.harris@example.com', 7070707070, 40),
('P028', 'Elizabeth Clark', 'P8080808080', '1818 Spruce St, Houston, USA', 'elizabeth.clark@example.com', 8080808080, 42),
('P029', 'Frank Wilson', 'P9090909090', '1919 Fir St, Boston, USA', 'frank.wilson@example.com', 9090909090, 45),
('P030', 'Geraldine Lewis', 'P10101010101', '2020 Elm St, Atlanta, USA', 'geraldine.lewis@example.com', 10101010101, 38),
('P031', 'Helen Robinson', 'P20202020201', '2121 Oak St, Charlotte, USA', 'helen.robinson@example.com', 20202020201, 29),
('P032', 'Ian Walker', 'P30303030301', '2222 Maple St, Denver, USA', 'ian.walker@example.com', 30303030301, 26),
('P033', 'Julia Martin', 'P40404040401', '2323 Cedar St, San Francisco, USA', 'julia.martin@example.com', 40404040401, 34),
('P034', 'Kenneth Thompson', 'P50505050501', '2424 Pine St, Seattle, USA', 'kenneth.thompson@example.com', 50505050501, 31),
('P035', 'Lori Jackson', 'P60606060601', '2525 Spruce St, Las Vegas, USA', 'lori.jackson@example.com', 60606060601, 39),
('P036', 'Melissa Davis', 'P70707070701', '2626 Fir St, Miami, USA', 'melissa.davis@example.com', 70707070701, 42),
('P037', 'Natalie Hall', 'P80808080801', '2727 Elm St, Houston, USA', 'natalie.hall@example.com', 80808080801, 35),
('P038', 'Olivia Brown', 'P90909090901', '2828 Oak St, Boston, USA', 'olivia.brown@example.com', 90909090901, 30),
('P039', 'Peter Lee', 'P101010101011', '2929 Maple St, Atlanta, USA', 'peter.lee@example.com', 101010101011, 28),
('P040', 'Rachel Taylor', ' P202020202011', '3030 Cedar St, Charlotte, USA', 'rachel.taylor@example.com', 202020202011, 29),
('P041', 'Samantha White', 'P303030303011', '3131 Pine St, Denver, USA', 'samantha.white@example.com', 303030303011, 31),
('P042', 'Teresa Nguyen', 'P404040404011', '3232 Spruce St, San Francisco, USA', 'teresa.nguyen@example.com', 404040404011, 33),
('P043', 'Ursula Martin', 'P505050505011', '3333 Fir St, Seattle, USA', 'ursula.martin@example.com', 505050505011, 36),
('P044', 'Vincent Harris', 'P606060606011', '3434 Elm St, Las Vegas, USA', 'vincent.harris@example.com', 606060606011, 38),
('P045', 'Wendy Clark', 'P707070707011', '3535 Oak St, Miami, USA', 'wendy.clark@example.com', 707070707011, 40),
('P046', 'Xavier Lewis', 'P808080808011', '3636 Maple St, Houston, USA', 'xavier.lewis@example.com', 808080808011, 42),
('P047', 'Yvonne Robinson', 'P909090909011', '3737 Cedar St, Boston, USA', 'yvonne.robinson@example.com', 909090909011, 45),
('P048', 'Zachary Walker', 'P101010101012', '3838 Pine St, Atlanta, USA', 'zachary.walker@example.com', 101010101012, 38),
('P049', 'Abigail Martin', 'P202020202012', '3939 Spruce St, Charlotte, USA', 'abigail.martin@example.com', 202020202012, 29),
('P050', 'Benjamin Thompson', 'P303030303012', '4040 Fir St, Denver, USA', 'benjamin.thompson@example.com', 303030303012, 26),
('P051', 'Catherine Jackson', 'P404040404012', '4141 Elm St, San Francisco, USA', 'catherine.jackson@example.com', 404040404012, 34),
('P052', 'Diana Davis', 'P505050505012', '4242 Oak St, Seattle, USA', 'diana.davis@example.com', 505050505012, 31),
('P053', 'Eleanor Hall', 'P606060606012', '4343 Maple St, Las Vegas, USA', 'eleanor.hall@example.com', 606060606012, 39),
('P054', 'Florence Brown', 'P707070707012', '4444 Cedar St, Miami, USA', 'florence.brown@example.com', 707070707012, 42),
('P055', 'Gabriella Lee', 'P808080808012', '4545 Pine St, Houston, USA', 'gabriella.lee@example.com', 808080808012, 35),
('P056', 'Hannah Taylor', 'P909090909012', '4646 Spruce St, Boston, USA', 'hannah.taylor@example.com', 909090909012, 30),
('P057', 'Isabella White', 'P101010101013', '4747 Fir St, Atlanta, USA', 'isabella.white@example.com', 101010101013, 28),
('P058', 'Julian Nguyen', 'P202020202013', '4848 Elm St, Charlotte, USA', 'julian.nguyen@example.com', 202020202013, 29),
('P059', 'Katherine Martin', 'P303030303013', '4949 Oak St, Denver, USA', 'katherine.martin@example.com', 303030303013, 31),
('P060', 'Lucas Harris', 'P404040404013', '5050 Maple St, San Francisco, USA', 'lucas.harris@example.com', 404040404013, 33);

INSERT INTO FLIGHT (FLIGHT_ID, MODEL, CAPACITY, PRICE, CLASS) VALUES
('F001', 'Boeing 737', 150, 200.00, 'ECONOMY'),
('F001', 'Airbus A320', 180, 250.00, 'BUSINESS'),
('F003', 'Boeing 777', 300, 400.00, 'BUSINESS'),
('F004', 'Airbus A330', 250, 350.00, 'BUSINESS'),
('F005', 'Boeing 747', 400, 500.00, 'ECONOMY'),
('F006', 'Airbus A380', 500, 600.00, 'ECONOMY'),
('F007', 'Boeing 737', 150, 200.00, 'ECONOMY'),
('F008', 'Airbus A320', 180, 250.00, 'ECONOMY'),
('F009', 'Boeing 777', 300, 400.00, 'BUSINESS'),
('F010', 'Airbus A330', 250, 350.00, 'BUSINESS'),
('F011', 'Boeing 747', 400, 500.00, 'ECONOMY'),
('F012', 'Airbus A380', 500, 600.00, 'ECONOMY'),
('F012', 'Boeing 737', 150, 200.00, 'BUSINESS'),
('F014', 'Airbus A320', 180, 250.00, 'ECONOMY'),
('F015', 'Boeing 777', 300, 400.00, 'BUSINESS'),
('F016', 'Airbus A330', 250, 350.00, 'BUSINESS'),
('F017', 'Boeing 747', 400, 500.00, 'ECONOMY'),
('F018', 'Airbus A380', 500, 600.00, 'ECONOMY'),
('F019', 'Boeing 737', 150, 200.00, 'ECONOMY'),
('F021', 'Airbus A320', 180, 250.00, 'ECONOMY'),
('F021', 'Boeing 777', 300, 400.00, 'BUSINESS'),
('F022', 'Airbus A330', 250, 350.00, 'BUSINESS'),
('F023', 'Boeing 747', 400, 500.00, 'ECONOMY'),
('F024', 'Airbus A380', 500, 600.00, 'ECONOMY'),
('F025', 'Boeing 737', 150, 200.00, 'ECONOMY'),
('F026', 'Airbus A320', 180, 250.00, 'ECONOMY'),
('F027', 'Boeing 777', 300, 400.00, 'BUSINESS'),
('F028', 'Airbus A330', 250, 350.00, 'BUSINESS'),
('F029', 'Boeing 747', 400, 500.00, 'ECONOMY'),
('F030', 'Airbus A380', 500, 600.00, 'ECONOMY'),
('F031', 'Boeing 737', 150, 200.00, 'ECONOMY'),
('F033', 'Airbus A320', 180, 250.00, 'ECONOMY'),
('F033', 'Boeing 777', 300, 400.00, 'BUSINESS'),
('F034', 'Airbus A330', 250, 350.00, 'BUSINESS'),
('F035', 'Boeing 747', 400, 500.00, 'ECONOMY'),
('F036', 'Airbus A380', 500, 600.00, 'ECONOMY'),
('F037', 'Boeing 737', 150, 200.00, 'ECONOMY'),
('F038', 'Airbus A320', 180, 250.00, 'ECONOMY'),
('F039', 'Boeing 777', 300, 400.00, 'BUSINESS'),
('F040', 'Airbus A330', 250, 350.00, 'BUSINESS'),
('F041', 'Boeing 747', 400, 500.00, 'ECONOMY'),
('F042', 'Airbus A380', 500, 600.00, 'ECONOMY'),
('F043', 'Boeing 737', 150, 200.00, 'ECONOMY'),
('F044', 'Airbus A320', 180, 250.00, 'ECONOMY'),
('F044', 'Boeing 777', 300, 400.00, 'BUSINESS'),
('F046', 'Airbus A330', 250, 350.00, 'BUSINESS'),
('F047', 'Boeing 747', 400, 500.00, 'ECONOMY'),
('F048', ' Airbus A380', 500, 600.00, 'ECONOMY'),
('F049', 'Boeing 737', 150, 200.00, 'ECONOMY'),
('F050', 'Airbus A320', 180, 250.00, 'ECONOMY');


INSERT INTO ROUTE (FLIGHT_ID, CLASS, ROUTE_NUMBER, START_POINT, END_POINT, INTERMEDIATE_POINT, ARRIVAL_TIME, DEPARTURE_TIME) VALUES
('F001', 'ECONOMY', 1, 'JFK', 'LAX', 'ORD', '10:00:00', '08:00:00'),
('F001', 'BUSINESS', 2, 'LAX', 'JFK', 'DEN', '12:00:00', '10:00:00'),
('F003', 'BUSINESS', 3, 'ORD', 'SFO', 'SEA', '14:00:00', '12:00:00'),
('F004', 'BUSINESS', 4, 'SFO', 'ORD', 'LAS', '16:00:00', '14:00:00'),
('F005', 'ECONOMY', 5, 'LAS', 'MIA', 'PHX', '18:00:00', '16:00:00'),
('F006', 'ECONOMY', 6, 'MIA', 'LAS', 'IAH', '20:00:00', '18:00:00'),
('F007', 'ECONOMY', 7, 'IAH', 'CLT', 'ATL', '22:00:00', '20:00:00'),
('F008', 'ECONOMY', 8, 'CLT', 'IAH', 'BOS', '00:00:00', '22:00:00'),
('F009', 'BUSINESS', 9, 'BOS', 'CLT', 'EWR', '02:00:00', '00:00:00'),
('F010', 'BUSINESS', 10, 'EWR', 'BOS', 'LHR', '04:00:00', '02:00:00'),
('F011', 'ECONOMY', 11, 'LHR', 'EWR', 'CDG', '06:00:00', '04:00:00'),
('F012', 'ECONOMY', 12, 'CDG', 'LHR', 'FRA', '08:00:00', '06:00:00'),
('F012', 'BUSINESS', 13, 'FRA', 'CDG', 'JFK', '10:00:00', '08:00:00'),
('F014', 'ECONOMY', 14, 'JFK', 'FRA', 'LAX', '12:00:00', '10:00:00'),
('F015', 'BUSINESS', 15, 'LAX', 'JFK', 'ORD', '14:00:00', '12:00:00'),
('F016', 'BUSINESS', 16, 'ORD', 'LAX', 'SFO', '16:00:00', '14:00:00'),
('F017', 'ECONOMY', 17, 'SFO', 'ORD', 'SEA', '18:00:00', '16:00:00'),
('F018', 'ECONOMY', 18, 'SEA', 'SFO', 'LAS', '20:00:00', '18:00:00'),
('F019', 'ECONOMY', 19, 'LAS', 'SEA', 'MIA', '22:00:00', '20:00:00'),
('F021', 'ECONOMY', 20, 'MIA', 'LAS', 'PHX', '00:00:00', '22:00:00'),
('F021', 'BUSINESS', 21, 'PHX', 'MIA', 'IAH', '02:00:00', '00:00:00'),
('F022', 'BUSINESS', 22, 'IAH', 'PHX', 'CLT', '04:00:00', '02:00:00'),
('F023', 'ECONOMY', 23, 'CLT', 'IAH', 'ATL', '06:00:00', '04:00:00'),
('F024', 'ECONOMY', 24, 'ATL', 'CLT', 'BOS', '08:00:00', '06:00:00'),
('F025', 'ECONOMY', 25, 'BOS', 'ATL', 'EWR', '10:00:00', '08:00:00'),
('F026', 'ECONOMY', 26, 'EWR', 'BOS', 'LHR', '12:00:00', '10:00:00'),
('F027', 'BUSINESS', 27, 'LHR', 'EWR', 'CDG', '14:00:00', '12:00:00'),
('F028', 'BUSINESS', 28, 'CDG', 'LHR', 'FRA', '16:00:00', '14:00:00'),
('F029', 'ECONOMY', 29, 'FRA', 'CDG', 'JFK', '18:00:00', '16:00:00'),
('F030', 'ECONOMY', 30, 'JFK', 'FRA', 'LAX', '20:00:00', '18:00:00'),
('F031', 'ECONOMY', 31, 'LAX', 'JFK', 'ORD', '22:00:00', '20:00:00'),
('F033', 'ECONOMY', 32, 'ORD', 'LAX', 'SFO', '00:00:00', '22:00:00'),
('F033', 'BUSINESS', 33, 'SFO', 'ORD', 'SEA', '02:00:00', '00:00:00'),
('F034', 'BUSINESS', 34, 'SEA', 'SFO', 'LAS', '04:00:00', '02:00:00'),
('F035', 'ECONOMY', 35, 'LAS', 'SEA', 'MIA', '06:00:00', '04:00:00'),
('F036', 'ECONOMY', 36, 'MIA', 'LAS', 'PHX', '08:00:00', '06:00:00'),
('F037', 'ECONOMY', 37, 'PHX', 'MIA', 'IAH', '10:00:00', '08:00:00'),
('F038', 'ECONOMY', 38, 'IAH', 'PHX', 'CLT', '12:00:00', '10:00:00'),
('F039', 'BUSINESS', 39, 'CLT', 'IAH', 'ATL', '14:00:00', '12:00:00'),
('F040', 'BUSINESS', 40, 'ATL', 'CLT', 'BOS', '16:00:00', '14:00:00'),
('F041', 'ECONOMY', 41, 'BOS', 'ATL', 'EWR', '18:00:00', '16:00:00'),
('F042', 'ECONOMY', 42, 'EWR', 'BOS', 'LHR', '20:00:00', '18:00:00'),
('F043', 'ECONOMY', 43, 'LHR', 'EWR', 'CDG', '22:00:00', '20:00:00'),
('F044', 'ECONOMY', 44, 'CDG', 'LHR', 'FRA', '00:00:00', '22:00:00'),
('F044', 'BUSINESS', 45, 'FRA', 'CDG', 'JFK', '02:00:00', '00:00:00'),
('F046', 'BUSINESS', 46, 'JFK', 'FRA', 'LAX', '04:00:00', '02:00:00'),
('F047', 'ECONOMY', 47, 'LAX', 'JFK', 'ORD', '06:00:00', '04:00:00'),
('F048', 'ECONOMY', 48, 'ORD', 'LAX', 'SFO', '08:00:00', '06:00:00'),
('F049', 'ECONOMY', 49, 'SFO', 'ORD', 'SEA', '10:00:00', '08:00:00'),
('F050', 'ECONOMY', 50, 'SEA', 'SFO', 'LAS', '12:00:00', '10:00:00');

INSERT INTO BOOKING (FLIGHT_ID, TICKET_NUMBER, DATE_OF_FLYING, PASSENGER_ID, CLASS, PAYMENT_MODE, TICKET_STATUS) VALUES
('F001', 1001, '2023-01-01', 'P001', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F001', 1002, '2023-01-02',  'P002', 'BUSINESS', 'OFFLINE', 'WAITING'),
('F003', 1003, '2023-01-03', 'P003', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F004', 1004, '2023-01-04', 'P004', 'BUSINESS', 'OFFLINE', 'CANCELLED'),
('F005', 1005, '2023-01-05', 'P005', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F006', 1006, '2023-01-06', 'P006', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F007', 1007, '2023-01-07', 'P007', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F008', 1008, '2023-01-08', 'P008', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F009', 1009, '2023-01-10', 'P009', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F010', 1010, '2023-01-11', 'P010', 'BUSINESS', 'OFFLINE', 'WAITING'),
('F011', 1011, '2023-01-11', 'P011', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F012', 1012, '2023-01-12', 'P012', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F012', 1013, '2023-01-12', 'P013', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F014', 1014, '2023-01-14', 'P014', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F015', 1015, '2023-01-15', 'P015', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F016', 1016, '2023-01-15', 'P016', 'BUSINESS', 'OFFLINE', 'WAITING'),
('F017', 1017, '2023-01-17', 'P017', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F018', 1018, '2023-01-18', 'P018', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F019', 1019, '2023-01-18', 'P019', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F021', 1020, '2023-01-20', 'P020', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F021', 1021, '2023-01-22', 'P021', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F022', 1022, '2023-01-22', 'P022', 'BUSINESS', 'OFFLINE', 'WAITING'),
('F023', 1023, '2023-01-24', 'P023', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F024', 1024, '2023-01-24', 'P024', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F025', 1025, '2023-01-25', 'P025', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F026', 1026, '2023-01-26', 'P026', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F027', 1027, '2023-01-03', 'P027', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F028', 1028, '2023-01-03', 'P028', 'BUSINESS', 'OFFLINE', 'WAITING'),
('F029', 1029, '2023-01-29', 'P029', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F030', 1030, '2023-01-31', 'P030', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F031', 1031, '2023-01-31', 'P031', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F033', 1032, '2023-02-01', 'P032', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F033', 1033, '2023-02-03', 'P033', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F034', 1034, '2023-02-03', 'P034', 'BUSINESS', 'OFFLINE', 'WAITING'),
('F035', 1035, '2023-02-04', 'P035', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F036', 1036, '2023-02-05', 'P036', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F037', 1037, '2023-02-06', 'P037', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F038', 1038, '2023-02-07', 'P038', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F039', 1039, '2023-02-08', 'P039', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F040', 1040, '2023-02-09', 'P040', 'BUSINESS', 'OFFLINE', 'WAITING'),
('F041', 1041, '2023-02-10', 'P041', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F042', 1042, '2023-02-11', 'P042', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F043', 1043, '2023-02-12', 'P043', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F044', 1044, '2023-02-13', 'P044', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F044', 1045, '2023-02-14', 'P045', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F046', 1046, '2023-02-15', 'P046', 'BUSINESS', 'OFFLINE', 'CONFIRM'),
('F047', 1047, '2023-02-16', 'P047', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F048', 1048, '2023-02-17', 'P048', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F049', 1049, '2023-02-18', 'P049', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F050', 1050, '2023-02-19', 'P050', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F001', 1051, '2023-02-20', 'P051', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F001', 1052, '2023-02-21', 'P052', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F003', 1053, '2023-02-22', 'P053', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F004', 1054, '2023-02-23', 'P054', 'BUSINESS', 'OFFLINE', 'WAITING'),
('F005', 1055, '2023-02-24', 'P055', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F006', 1056, '2023-02-25', 'P056', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F007', 1057, '2023-02-26', 'P057', 'ECONOMY', 'ONLINE', 'CONFIRM'),
('F008', 1058, '2023-02-27', 'P058', 'ECONOMY', 'OFFLINE', 'WAITING'),
('F009', 1059, '2023-02-28', 'P059', 'BUSINESS', 'ONLINE', 'CONFIRM'),
('F010', 1060, '2023-03-01', 'P060', 'BUSINESS', 'OFFLINE', 'WAITING');


CREATE VIEW TIMING 
	AS SELECT FLIGHT_ID,CLASS,DEPARTURE_TIME,ARRIVAL_TIME 
	FROM ROUTE 
	WHERE START_POINT='JFK' AND END_POINT='FRA'; 

CREATE VIEW FLIGHTS1 
	AS SELECT FLIGHT_ID,CLASS,COUNT(*) AS SEATS 
	FROM BOOKING 
	WHERE TICKET_STATUS='CONFIRM' AND DATE_OF_FLYING='2023-02-15' 
	GROUP BY FLIGHT_ID,CLASS;

CREATE VIEW FLIGHTS2 
	AS SELECT F.FLIGHT_ID,F1.SEATS,F.CLASS,F.PRICE 
	FROM FLIGHT F JOIN FLIGHTS1 F1 
	ON F.FLIGHT_ID=F1.FLIGHT_ID AND F.CLASS=F1.CLASS 
	WHERE CAPACITY-SEATS > 0;

SELECT S.FLIGHT_ID,T.DEPARTURE_TIME,T.ARRIVAL_TIME,FF.CAPACITY-S.SEATS AS AVAILABLE_SEATS,S.CLASS,S.PRICE 
	FROM FLIGHTS2 S JOIN TIMING T 
	ON S.FLIGHT_ID=T.FLIGHT_ID AND S.CLASS=T.CLASS JOIN FLIGHT FF 
	ON S.FLIGHT_ID=FF.FLIGHT_ID AND S.CLASS=FF.CLASS;












