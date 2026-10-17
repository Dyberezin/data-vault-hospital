CREATE TABLE patient (
    patient_id     INT AUTO_INCREMENT PRIMARY KEY,
    last_name      VARCHAR(100) NOT NULL,
    first_name     VARCHAR(100) NOT NULL,
    middle_name    VARCHAR(100),
    birth_date     DATE         NOT NULL,
    gender         CHAR(1)      NOT NULL,
    phone          VARCHAR(20),
    address        VARCHAR(500),
    oms_number     VARCHAR(20)  NOT NULL UNIQUE,
    snils          VARCHAR(20)  UNIQUE,
    created_at     DATETIME     DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE employee (
    employee_id    INT AUTO_INCREMENT PRIMARY KEY,
    tab_number     VARCHAR(20)  NOT NULL UNIQUE,
    full_name      VARCHAR(200) NOT NULL,
    position       VARCHAR(100),
    specialization VARCHAR(100),
    department     VARCHAR(100),
    created_at     DATETIME     DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE visit (
    visit_id           INT AUTO_INCREMENT PRIMARY KEY,
    visit_number       VARCHAR(50) NOT NULL UNIQUE,
    admission_datetime DATETIME    NOT NULL,
    discharge_datetime DATETIME,
    visit_type         VARCHAR(50),
    triage_level       INT,
    outcome            VARCHAR(50),
    ward               VARCHAR(100),
    bed_number         VARCHAR(20),
    patient_id         INT         NOT NULL,
    doctor_id          INT         NOT NULL,
    created_at         DATETIME    DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_visit_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    CONSTRAINT fk_visit_doctor  FOREIGN KEY (doctor_id)  REFERENCES employee(employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE diagnosis (
    diagnosis_id    INT AUTO_INCREMENT PRIMARY KEY,
    icd_code        VARCHAR(10)  NOT NULL UNIQUE,
    diagnosis_name  VARCHAR(500) NOT NULL,
    diagnosis_group VARCHAR(200),
    icd_chapter     VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE visit_diagnosis (
    visit_id     INT NOT NULL,
    diagnosis_id INT NOT NULL,
    is_main      BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (visit_id, diagnosis_id),
    CONSTRAINT fk_vd_visit     FOREIGN KEY (visit_id)     REFERENCES visit(visit_id),
    CONSTRAINT fk_vd_diagnosis FOREIGN KEY (diagnosis_id) REFERENCES diagnosis(diagnosis_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE study (
    study_id        INT AUTO_INCREMENT PRIMARY KEY,
    study_code      VARCHAR(20)  NOT NULL UNIQUE,
    study_name      VARCHAR(300) NOT NULL,
    result_value    VARCHAR(2000),
    result_unit     VARCHAR(50),
    reference_range VARCHAR(100),
    study_datetime  DATETIME,
    visit_id        INT          NOT NULL,
    employee_id     INT          NOT NULL,
    CONSTRAINT fk_study_visit    FOREIGN KEY (visit_id)    REFERENCES visit(visit_id),
    CONSTRAINT fk_study_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE medical_procedure (
    procedure_id       INT AUTO_INCREMENT PRIMARY KEY,
    procedure_code     VARCHAR(20)  NOT NULL UNIQUE,
    procedure_name     VARCHAR(300) NOT NULL,
    procedure_datetime DATETIME,
    quantity           INT,
    notes              VARCHAR(2000),
    visit_id           INT          NOT NULL,
    CONSTRAINT fk_proc_visit FOREIGN KEY (visit_id) REFERENCES visit(visit_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE insurance (
    insurance_id      INT AUTO_INCREMENT PRIMARY KEY,
    policy_number     VARCHAR(30)  NOT NULL,
    insurance_company VARCHAR(200) NOT NULL,
    policy_type       VARCHAR(10),
    valid_from        DATE,
    valid_to          DATE,
    patient_id        INT          NOT NULL,
    CONSTRAINT fk_ins_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
