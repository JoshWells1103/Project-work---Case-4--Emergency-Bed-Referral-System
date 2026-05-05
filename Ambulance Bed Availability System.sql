
CREATE TABLE Hospital (
    hospital_id    SERIAL PRIMARY KEY,
    hospital_name  VARCHAR(50) NOT NULL,
    longitude      DECIMAL(9,6) NOT NULL,
    latitude       DECIMAL(9,6) NOT NULL,
    region         VARCHAR(50) NOT NULL,
    contact_phone  VARCHAR(30) NOT NULL
			 
);

--Create ENUM Types
CREATE TYPE patient_severity AS ENUM (
   'non-urgent',
   'urgent',
   'critical'
  );

--Create ENUM Types
CREATE TYPE patient_gender AS ENUM (
   'male',
   'female'
  );
  
CREATE TABLE Patient (
             Patient_id       VARCHAR (20) PRIMARY KEY,
   			 Patient_name     VARCHAR (50) NOT NULL,
		     patient_age      INTEGER	       NOT NULL,
			 patient_address  TEXT,
			 patientgender    patient_gender NOT NULL DEFAULT 'male',
			 patientseverity   patient_severity NOT NULL DEFAULT 'urgent'
);
--Create ENUM Types
CREATE TYPE ambulance_status AS ENUM (
   'available',
   'en_route',
   'at_scene',
   'transporting',
   'off_duty'
  );


CREATE TABLE Ambulance (
      ambulance_id        VARCHAR ( 30) PRIMARY KEY,
	  plate_number        VARCHAR  (20) NOT NULL,
	  dispatch_time       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  arrival_time        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  drop_off_time       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  last_dispatch_time  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  ambulancestatus    ambulance_status NOT NULL DEFAULT 'available'
);


CREATE TABLE Paramedic(
    	  paramedic_id          VARCHAR (30)   PRIMARY KEY,
		  paramedic_firstname   VARCHAR (30)   NOT NULL,
		  paramedic_lastname    VARCHAR  (30)  NOT NULL
		  
);

--Create ENUM Types
CREATE TYPE bed_status AS ENUM (
   'available',
   'occupied',
   'reserved'
  );
  
CREATE TABLE Bed (
    bed_id          VARCHAR(50) PRIMARY KEY,
    hospital_id     INTEGER NOT NULL REFERENCES Hospital(hospital_id) ON DELETE RESTRICT,
    bedstatus       bed_status NOT NULL DEFAULT 'available',
    admission_date  TIMESTAMP NOT NULL,
    discharged_date TIMESTAMP NOT NULL,
    UNIQUE(bed_id, hospital_id)
);

CREATE TABLE Dispatch (
    dispatch_id      SERIAL PRIMARY KEY,
    ambulance_id     VARCHAR(30) REFERENCES ambulance(ambulance_id) ON DELETE RESTRICT,
    patient_id       VARCHAR(20) REFERENCES patient(patient_id) ON DELETE RESTRICT,
    hospital_id      INTEGER REFERENCES hospital(hospital_id) ON DELETE RESTRICT,
    
    dispatch_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    enroute_time     TIMESTAMP,
    arrival_time     TIMESTAMP,
    drop_off_time    TIMESTAMP,

    ambulance_status VARCHAR(20) DEFAULT 'available',
    
    CHECK (ambulance_status IN ('available','en_route','at_scene','transporting','off_duty'))
);


INSERT INTO Hospital (hospital_id, bed_id, hospital_name, longitude, latitude, region, contact_phone) VALUES
                      ('1', 'KBTH001', 'Korle-Bu', '-0.23', '5.56', 'Greater-Accra', '0302739510'),
					  ('2', '37MH001', '37 Military Hospital', '-0.19', '5.6', 'Greater-Accra', '0302777595'),
					  ('3', 'TGH001', 'Tema General Hospital', '-0.01', '5.56', 'Greater-Accra', '0303302695' );


SELECT * FROM Hospital

INSERT INTO Patient ( patient_id, patient_name, patient_age, patient_address, patientgender, patientseverity)VALUES
                      ('1001', 'Abena', '30', '19 Kaprice street', 'female', 'urgent'),
					  ('1003', 'James', '65', '29 Cliff street', 'male','critical'),
					  ('1002', 'Patrick', '54', '32 Flint street', 'male', 'critical'),
					  ('1005', 'Abigail', '34', '12 Zion street', 'female', 'non-urgent');
					  

SELECT * FROM Patient


INSERT INTO Ambulance (ambulance_id, plate_number, dispatch_time, arrival_time, drop_off_time, last_dispatch_time, ambulancestatus)VALUES
      ('NAS001', 'GA-112', '2026-01-04 10:00:00','2026-01-04 10:30:00','2026-01-04 10:55:00', '2026-01-03 10:30:00','transporting'),
	  ('NAS002', 'GA-124', '2026-01-05 11:10:00','2026-01-05 11:40:00','2026-01-05 13:30:00','2026-01-02 12:00:00','at_scene'),
	  ('NAS004', 'GA-122', '2026-02-05 04:00:00','2026-02-05 04:10:00','2026-02-05 04:30:00', '2026-02-05 11:40:00', 'available');


SELECT * FROM Ambulance


INSERT INTO Paramedic ( paramedic_id, paramedic_firstname, paramedic_lastname ) VALUES
                       ( 'PM001', 'John', 'Brown'),
					   ('PM002', 'Kingsley', 'Hayford'),
					   ('PM003', 'Michael', 'Johnson'),
					   ('PM004', 'Malik', 'Alhassan');

SELECT * FROM Paramedic

INSERT INTO Bed (bed_id, hospital_id, bedstatus, admission_date, discharged_date) VALUES
    ('KBTH001', 1, 'reserved',  '2026-01-04 10:55:00', '2026-01-08 12:00:00'),
    ('KBTH002', 1, 'occupied',  '2026-01-04 10:55:00', '2026-01-05 12:00:00'),
    ('KBTH003', 1, 'reserved',  '2026-01-04 10:55:00', '2026-01-06 12:00:00'),
    ('KBTH006', 1, 'reserved',  '2026-01-04 10:55:00', '2026-01-08 12:00:00'),
    ('KBTH007', 1, 'available', '2026-01-04 10:55:00', '2026-01-05 12:00:00'),
    ('KBTH008', 1, 'occupied',  '2026-01-04 10:55:00', '2026-01-08 12:00:00'),
    ('37MH001', 2, 'reserved',  '2026-01-04 10:55:00', '2026-01-07 12:00:00'),
    ('37MH002', 2, 'occupied',  '2026-01-04 10:55:00', '2026-01-07 12:00:00'),
    ('37MH003', 2, 'occupied',  '2026-01-04 10:55:00', '2026-01-08 12:00:00'),
    ('37MH004', 2, 'occupied',  '2026-01-04 10:55:00', '2026-01-06 12:00:00'),
    ('TGH001',  3, 'occupied',  '2026-01-04 10:55:00', '2026-01-06 12:00:00'),
    ('TGH002',  3, 'available', '2026-01-04 10:55:00', '2026-01-05 12:00:00'),
    ('TGH003',  3, 'occupied',  '2026-01-04 10:55:00', '2026-01-07 12:00:00');
                


INSERT INTO Dispatch (ambulance_id, patient_id, hospital_id, dispatch_time, enroute_time, arrival_time, drop_off_time) VALUES
    ('NAS001', '1001', 1, '2026-01-04 10:00:00', '2026-01-04 10:05:00', '2026-01-04 10:30:00', '2026-01-04 10:55:00'),
    ('NAS002', '1003', 2, '2026-01-05 11:10:00', '2026-01-05 11:15:00', '2026-01-05 11:40:00', '2026-01-05 13:30:00'),
    ('NAS004', '1002', 3, '2026-02-05 04:00:00', '2026-02-05 04:02:00', '2026-02-05 04:10:00', '2026-02-05 04:30:00');
 


SELECT * FROM Dispatch
					  
             