CREATE DATABASE clinic;

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type VARCHAR(100),
    name VARCHAR(100)
);

CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INTEGER REFERENCES patients(id),
    status VARCHAR(100)
);

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL(10,2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INTEGER REFERENCES medical_histories(id)
);

/* creat table of invoice_items */
CREATE TABLE invoice_items(
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL(10,2),
    quantity INTEGER,
    total_price DECIMAL(10,2),
    invoice_id INTEGER REFERENCES invoices(id),
    treatment_id INTEGER REFERENCES treatments(id)
);


/* create tabel of medical_history_treatments for many to many relationship */
CREATE TABLE midical_history_treatments (
    id SERIAL PRIMARY KEY,
    medical_history_id INTEGER REFERENCES medical_histories(id),
    treatment_id INTEGER REFERENCES treatments(id)
);

-- Create an index on the patient_id column in the medical_histories table
CREATE INDEX idx_patient_id ON medical_histories(patient_id);

-- Create an index on the medical_history_id column in the invoices table
CREATE INDEX idx_medical_history_id ON invoices(medical_history_id);

-- Create an index on the invoice_id column in the invoice_items table
CREATE INDEX idx_invoice_id ON invoice_items(invoice_id);

-- Create an index on the treatment_id column in the invoice_items table
CREATE INDEX idx_treatment_id ON invoice_items(treatment_id);

-- Create an index on the medical_history_id column in the medical_history_treatments table
CREATE INDEX idx_medical_history_id ON midical_history_treatments(medical_history_id);

-- Create an index on the treatment_id column in the medical_history_treatments table
CREATE INDEX idx_treatment_id ON midical_history_treatments(treatment_id);
