-- -----------------------------------------------------
-- Schema meat_poultry_wareouse
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema meat_poultry_wareouse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS meat_poultry_wareouse ;
USE meat_poultry_wareouse ;

-- -----------------------------------------------------
-- state
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS state (
  state_id VARCHAR(2) NOT NULL,
  state_name VARCHAR(45) NULL,
  PRIMARY KEY (state_id));


-- -----------------------------------------------------
-- Table city
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS city (
  city_id INT NOT NULL AUTO_INCREMENT,
  state_id VARCHAR(2) NOT NULL,
  city_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (city_id),
  INDEX fk_state_id_idx (state_id ASC) VISIBLE,
  CONSTRAINT fk_city_state_id
    FOREIGN KEY (state_id)
    REFERENCES state (state_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table activity
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS activity (
  activity_id INT NOT NULL AUTO_INCREMENT,
  activity_name TEXT NOT NULL,
  insert_date DATE NOT NULL,
  PRIMARY KEY (activity_id));


-- -----------------------------------------------------
-- Table company
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS company (
  company_id INT NOT NULL AUTO_INCREMENT,
  company_name VARCHAR(100) NOT NULL,
  insert_date DATE NOT NULL,
  PRIMARY KEY (company_id));


-- -----------------------------------------------------
-- Table business
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS business (
  business_id INT NOT NULL AUTO_INCREMENT,
  company_id INT NOT NULL,
  activity_id INT NOT NULL,
  city_id INT NOT NULL,
  address VARCHAR(100) NOT NULL,
  zip VARCHAR(5) NOT NULL,
  insert_date DATE NOT NULL,
  PRIMARY KEY (business_id),
  INDEX fk_company_id_idx (company_id ASC) VISIBLE,
  INDEX fk_activity_1_idx (activity_id ASC) VISIBLE,
  INDEX fk_business_city_id_idx (city_id ASC) VISIBLE,
  CONSTRAINT fk_business_company_id
    FOREIGN KEY (company_id)
    REFERENCES company (company_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_business_activity_id
    FOREIGN KEY (activity_id)
    REFERENCES activity (activity_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_business_city_id
    FOREIGN KEY (city_id)
    REFERENCES city (city_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table dba
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS dba (
  business_id INT NOT NULL,
  company_id INT NOT NULL,
  INDEX fk_dba_business_id_idx (business_id ASC) VISIBLE,
  INDEX fk_dba_company_id_idx (company_id ASC) VISIBLE,
  CONSTRAINT fk_dba_business_id_1
    FOREIGN KEY (business_id)
    REFERENCES business (business_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_dba_company_id
    FOREIGN KEY (company_id)
    REFERENCES company (company_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table establishment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS establishment (
  est_id VARCHAR(50) NOT NULL,
  bussiness_id INT NOT NULL,
  grant_date DATE NOT NULL,
  insert_date DATE NOT NULL,
  PRIMARY KEY (est_id),
  INDEX fk_establishment_business_id_idx (bussiness_id ASC) VISIBLE,
  CONSTRAINT fk_establishment_business_id
    FOREIGN KEY (bussiness_id)
    REFERENCES business (business_id)
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
