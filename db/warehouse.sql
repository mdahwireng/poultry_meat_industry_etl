-- -----------------------------------------------------
-- Schema meat_poultry_wareouse
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema meat_poultry_wareouse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS meat_poultry_wareouse ;

-- -----------------------------------------------------
-- state
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS meat_poultry_wareouse.state (
  state_id VARCHAR(2) NOT NULL,
  state_name VARCHAR(45) NULL,
  PRIMARY KEY (state_id));


-- -----------------------------------------------------
-- Table city
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS meat_poultry_wareouse.city (
  city_id SERIAL NOT NULL,
  state_id VARCHAR(2) NOT NULL,
  city_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (city_id),
  CONSTRAINT fk_city_state_id
    FOREIGN KEY (state_id)
    REFERENCES meat_poultry_wareouse.state (state_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table activity
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS meat_poultry_wareouse.activity (
  activity_id SERIAL NOT NULL,
  activity_name TEXT NOT NULL,
  insert_date DATE NOT NULL,
  PRIMARY KEY (activity_id));


-- -----------------------------------------------------
-- Table company
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS meat_poultry_wareouse.company (
  company_id SERIAL NOT NULL,
  company_name VARCHAR(100) NOT NULL,
  insert_date DATE NOT NULL,
  PRIMARY KEY (company_id));


-- -----------------------------------------------------
-- Table business
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS meat_poultry_wareouse.business (
  business_id SERIAL NOT NULL,
  company_id INT NOT NULL,
  activity_id INT NOT NULL,
  city_id INT NOT NULL,
  address VARCHAR(100) NOT NULL,
  zip VARCHAR(5) NOT NULL,
  insert_date DATE NOT NULL,
  PRIMARY KEY (business_id),
  CONSTRAINT fk_business_company_id
    FOREIGN KEY (company_id)
    REFERENCES meat_poultry_wareouse.company (company_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_business_activity_id
    FOREIGN KEY (activity_id)
    REFERENCES meat_poultry_wareouse.activity (activity_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_business_city_id
    FOREIGN KEY (city_id)
    REFERENCES meat_poultry_wareouse.city (city_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table dba
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS meat_poultry_wareouse.dba (
  business_id INT NOT NULL,
  company_id INT NOT NULL,
  CONSTRAINT fk_dba_business_id_1
    FOREIGN KEY (business_id)
    REFERENCES meat_poultry_wareouse.business (business_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_dba_company_id
    FOREIGN KEY (company_id)
    REFERENCES meat_poultry_wareouse.company (company_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table establishment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS meat_poultry_wareouse.establishment (
  est_id VARCHAR(50) NOT NULL,
  bussiness_id INT NOT NULL,
  grant_date DATE NOT NULL,
  insert_date DATE NOT NULL,
  PRIMARY KEY (est_id),
  CONSTRAINT fk_establishment_business_id
    FOREIGN KEY (bussiness_id)
    REFERENCES meat_poultry_wareouse.business (business_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table phone
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS meat_poultry_wareouse.phone (
  business_id INT NOT NULL,
  phone VARCHAR(14) NOT NULL,
  PRIMARY KEY (business_id),
  CONSTRAINT fk_phone_business_id
    FOREIGN KEY (business_id)
    REFERENCES meat_poultry_wareouse.business (business_id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);
