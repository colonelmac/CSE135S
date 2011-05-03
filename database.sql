CREATE DATABASE "CSE135S"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'English_United States.1252'
       LC_CTYPE = 'English_United States.1252'
       CONNECTION LIMIT = -1;
	   
CREATE SCHEMA public
  AUTHORIZATION postgres;

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
COMMENT ON SCHEMA public IS 'standard public schema';

CREATE TABLE applicant_status
(
  id serial NOT NULL,
  "name" text NOT NULL,
  CONSTRAINT applicant_status_pkey PRIMARY KEY (id),
  CONSTRAINT applicant_status_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE applicant_status OWNER TO postgres;

CREATE TABLE applicants
(
  id serial NOT NULL,
  firstname text NOT NULL,
  lastname text NOT NULL,
  middleinitial text,
  countrycode integer,
  areacode integer,
  phonenumber integer,
  citizenshipid integer NOT NULL,
  residenceid integer NOT NULL,
  address text,
  city text,
  zipcode integer,
  uuid uuid NOT NULL,
  state text,
  statusid integer NOT NULL DEFAULT 1,
  CONSTRAINT applicants_pkey PRIMARY KEY (id),
  CONSTRAINT applicants_citizenshipid_fkey FOREIGN KEY (citizenshipid)
      REFERENCES locations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT applicants_residenceid_fkey FOREIGN KEY (residenceid)
      REFERENCES locations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT applicants_statusid_fkey FOREIGN KEY (statusid)
      REFERENCES applicant_status (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE applicants OWNER TO postgres;

CREATE TABLE degrees
(
  id serial NOT NULL,
  applicantid integer NOT NULL,
  title text NOT NULL,
  majorid integer NOT NULL,
  specializationid integer,
  universityid integer NOT NULL,
  graduationdate date NOT NULL,
  gpa integer NOT NULL,
  CONSTRAINT degrees_pkey PRIMARY KEY (id),
  CONSTRAINT degrees_applicantid_fkey FOREIGN KEY (applicantid)
      REFERENCES applicants (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT degrees_majorid_fkey FOREIGN KEY (majorid)
      REFERENCES majors (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT degrees_specializationid_fkey FOREIGN KEY (specializationid)
      REFERENCES specializations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT degrees_universityid_fkey FOREIGN KEY (universityid)
      REFERENCES universities (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE degrees OWNER TO postgres;

CREATE TABLE locations
(
  id serial NOT NULL,
  "name" text NOT NULL,
  isstate bit(1),
  CONSTRAINT locations_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE locations OWNER TO postgres;

CREATE TABLE majors
(
  id serial NOT NULL,
  "name" text NOT NULL,
  applicantcount integer DEFAULT 0,
  CONSTRAINT majors_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE majors OWNER TO postgres;

CREATE TABLE specializations
(
  id serial NOT NULL,
  "name" text NOT NULL,
  applicantcount integer DEFAULT 0,
  CONSTRAINT specializations_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE specializations OWNER TO postgres;

CREATE TABLE universities
(
  id serial NOT NULL,
  locationid integer NOT NULL,
  "name" text NOT NULL,
  CONSTRAINT universities_pkey PRIMARY KEY (id),
  CONSTRAINT universities_locationid_fkey FOREIGN KEY (locationid)
      REFERENCES locations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE universities OWNER TO postgres;