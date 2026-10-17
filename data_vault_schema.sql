USE dv_hospital;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ========== ХАБЫ ==========

CREATE TABLE hub_patient (
    patient_hash_key CHAR(32)     NOT NULL,
    load_date        DATETIME     NOT NULL,
    record_source    VARCHAR(100) NOT NULL,
    patient_oms      VARCHAR(20)  NOT NULL,
    patient_snils    VARCHAR(20)  DEFAULT NULL,
    PRIMARY KEY (patient_hash_key),
    UNIQUE KEY uq_hub_patient_oms (patient_oms)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE hub_employee (
    employee_hash_key CHAR(32)     NOT NULL,
    load_date         DATETIME     NOT NULL,
    record_source     VARCHAR(100) NOT NULL,
    employee_tab_num  VARCHAR(20)  NOT NULL,
    PRIMARY KEY (employee_hash_key),
    UNIQUE KEY uq_hub_employee_tab (employee_tab_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE hub_visit (
    visit_hash_key CHAR(32)     NOT NULL,
    load_date      DATETIME     NOT NULL,
    record_source  VARCHAR(100) NOT NULL,
    visit_number   VARCHAR(50)  NOT NULL,
    PRIMARY KEY (visit_hash_key),
    UNIQUE KEY uq_hub_visit_number (visit_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE hub_diagnosis (
    diagnosis_hash_key CHAR(32)     NOT NULL,
    load_date          DATETIME     NOT NULL,
    record_source      VARCHAR(100) NOT NULL,
    diagnosis_code     VARCHAR(10)  NOT NULL,
    PRIMARY KEY (diagnosis_hash_key),
    UNIQUE KEY uq_hub_diagnosis_code (diagnosis_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE hub_study (
    study_hash_key CHAR(32)     NOT NULL,
    load_date      DATETIME     NOT NULL,
    record_source  VARCHAR(100) NOT NULL,
    study_code     VARCHAR(20)  NOT NULL,
    PRIMARY KEY (study_hash_key),
    UNIQUE KEY uq_hub_study_code (study_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE hub_procedure (
    procedure_hash_key CHAR(32)     NOT NULL,
    load_date          DATETIME     NOT NULL,
    record_source      VARCHAR(100) NOT NULL,
    procedure_code     VARCHAR(20)  NOT NULL,
    PRIMARY KEY (procedure_hash_key),
    UNIQUE KEY uq_hub_procedure_code (procedure_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========== ССЫЛКИ ==========

CREATE TABLE link_visit_patient (
    link_visit_patient_hash_key CHAR(32)     NOT NULL,
    load_date                   DATETIME     NOT NULL,
    record_source               VARCHAR(100) NOT NULL,
    visit_hash_key              CHAR(32)     NOT NULL,
    patient_hash_key            CHAR(32)     NOT NULL,
    PRIMARY KEY (link_visit_patient_hash_key),
    KEY idx_lvp_visit   (visit_hash_key),
    KEY idx_lvp_patient (patient_hash_key),
    CONSTRAINT fk_lvp_visit   FOREIGN KEY (visit_hash_key)   REFERENCES hub_visit(visit_hash_key),
    CONSTRAINT fk_lvp_patient FOREIGN KEY (patient_hash_key) REFERENCES hub_patient(patient_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE link_visit_employee (
    link_visit_employee_hash_key CHAR(32)     NOT NULL,
    load_date                    DATETIME     NOT NULL,
    record_source                VARCHAR(100) NOT NULL,
    visit_hash_key               CHAR(32)     NOT NULL,
    employee_hash_key            CHAR(32)     NOT NULL,
    PRIMARY KEY (link_visit_employee_hash_key),
    KEY idx_lve_visit    (visit_hash_key),
    KEY idx_lve_employee (employee_hash_key),
    CONSTRAINT fk_lve_visit    FOREIGN KEY (visit_hash_key)    REFERENCES hub_visit(visit_hash_key),
    CONSTRAINT fk_lve_employee FOREIGN KEY (employee_hash_key) REFERENCES hub_employee(employee_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE link_visit_diagnosis (
    link_visit_diagnosis_hash_key CHAR(32)     NOT NULL,
    load_date                     DATETIME     NOT NULL,
    record_source                 VARCHAR(100) NOT NULL,
    visit_hash_key                CHAR(32)     NOT NULL,
    diagnosis_hash_key            CHAR(32)     NOT NULL,
    PRIMARY KEY (link_visit_diagnosis_hash_key),
    KEY idx_lvd_visit     (visit_hash_key),
    KEY idx_lvd_diagnosis (diagnosis_hash_key),
    CONSTRAINT fk_lvd_visit     FOREIGN KEY (visit_hash_key)     REFERENCES hub_visit(visit_hash_key),
    CONSTRAINT fk_lvd_diagnosis FOREIGN KEY (diagnosis_hash_key) REFERENCES hub_diagnosis(diagnosis_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE link_visit_study (
    link_visit_study_hash_key CHAR(32)     NOT NULL,
    load_date                 DATETIME     NOT NULL,
    record_source             VARCHAR(100) NOT NULL,
    visit_hash_key            CHAR(32)     NOT NULL,
    study_hash_key            CHAR(32)     NOT NULL,
    PRIMARY KEY (link_visit_study_hash_key),
    KEY idx_lvs_visit (visit_hash_key),
    KEY idx_lvs_study (study_hash_key),
    CONSTRAINT fk_lvs_visit FOREIGN KEY (visit_hash_key) REFERENCES hub_visit(visit_hash_key),
    CONSTRAINT fk_lvs_study FOREIGN KEY (study_hash_key) REFERENCES hub_study(study_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE link_visit_procedure (
    link_visit_procedure_hash_key CHAR(32)     NOT NULL,
    load_date                     DATETIME     NOT NULL,
    record_source                 VARCHAR(100) NOT NULL,
    visit_hash_key                CHAR(32)     NOT NULL,
    procedure_hash_key            CHAR(32)     NOT NULL,
    PRIMARY KEY (link_visit_procedure_hash_key),
    KEY idx_lvp2_visit     (visit_hash_key),
    KEY idx_lvp2_procedure (procedure_hash_key),
    CONSTRAINT fk_lvp2_visit     FOREIGN KEY (visit_hash_key)     REFERENCES hub_visit(visit_hash_key),
    CONSTRAINT fk_lvp2_procedure FOREIGN KEY (procedure_hash_key) REFERENCES hub_procedure(procedure_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE link_study_employee (
    link_study_employee_hash_key CHAR(32)     NOT NULL,
    load_date                    DATETIME     NOT NULL,
    record_source                VARCHAR(100) NOT NULL,
    study_hash_key               CHAR(32)     NOT NULL,
    employee_hash_key            CHAR(32)     NOT NULL,
    PRIMARY KEY (link_study_employee_hash_key),
    KEY idx_lse_study    (study_hash_key),
    KEY idx_lse_employee (employee_hash_key),
    CONSTRAINT fk_lse_study    FOREIGN KEY (study_hash_key)    REFERENCES hub_study(study_hash_key),
    CONSTRAINT fk_lse_employee FOREIGN KEY (employee_hash_key) REFERENCES hub_employee(employee_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========== САТЕЛЛИТЫ ==========

CREATE TABLE sat_patient_personal (
    patient_hash_key CHAR(32)     NOT NULL,
    load_date        DATETIME     NOT NULL,
    record_source    VARCHAR(100) NOT NULL,
    hash_diff        CHAR(32)     NOT NULL,
    last_name        VARCHAR(100) DEFAULT NULL,
    first_name       VARCHAR(100) DEFAULT NULL,
    middle_name      VARCHAR(100) DEFAULT NULL,
    birth_date       DATE         DEFAULT NULL,
    gender           CHAR(1)      DEFAULT NULL,
    phone            VARCHAR(20)  DEFAULT NULL,
    address          VARCHAR(500) DEFAULT NULL,
    PRIMARY KEY (patient_hash_key, load_date),
    KEY idx_spp_load_date (load_date),
    CONSTRAINT fk_spp_patient FOREIGN KEY (patient_hash_key) REFERENCES hub_patient(patient_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sat_patient_insurance (
    patient_hash_key  CHAR(32)     NOT NULL,
    load_date         DATETIME     NOT NULL,
    record_source     VARCHAR(100) NOT NULL,
    hash_diff         CHAR(32)     NOT NULL,
    policy_number     VARCHAR(30)  DEFAULT NULL,
    insurance_company VARCHAR(200) DEFAULT NULL,
    policy_type       VARCHAR(10)  DEFAULT NULL,
    valid_from        DATE         DEFAULT NULL,
    valid_to          DATE         DEFAULT NULL,
    PRIMARY KEY (patient_hash_key, load_date),
    KEY idx_spi_load_date (load_date),
    CONSTRAINT fk_spi_patient FOREIGN KEY (patient_hash_key) REFERENCES hub_patient(patient_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sat_employee_details (
    employee_hash_key CHAR(32)     NOT NULL,
    load_date         DATETIME     NOT NULL,
    record_source     VARCHAR(100) NOT NULL,
    hash_diff         CHAR(32)     NOT NULL,
    full_name         VARCHAR(200) DEFAULT NULL,
    position          VARCHAR(100) DEFAULT NULL,
    specialization    VARCHAR(100) DEFAULT NULL,
    department        VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (employee_hash_key, load_date),
    KEY idx_sed_load_date (load_date),
    CONSTRAINT fk_sed_employee FOREIGN KEY (employee_hash_key) REFERENCES hub_employee(employee_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sat_visit_details (
    visit_hash_key     CHAR(32)     NOT NULL,
    load_date          DATETIME     NOT NULL,
    record_source      VARCHAR(100) NOT NULL,
    hash_diff          CHAR(32)     NOT NULL,
    admission_datetime DATETIME     DEFAULT NULL,
    discharge_datetime DATETIME     DEFAULT NULL,
    visit_type         VARCHAR(50)  DEFAULT NULL,
    triage_level       INT          DEFAULT NULL,
    outcome            VARCHAR(50)  DEFAULT NULL,
    ward               VARCHAR(100) DEFAULT NULL,
    bed_number         VARCHAR(20)  DEFAULT NULL,
    PRIMARY KEY (visit_hash_key, load_date),
    KEY idx_svd_load_date (load_date),
    CONSTRAINT fk_svd_visit FOREIGN KEY (visit_hash_key) REFERENCES hub_visit(visit_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sat_diagnosis_description (
    diagnosis_hash_key CHAR(32)     NOT NULL,
    load_date          DATETIME     NOT NULL,
    record_source      VARCHAR(100) NOT NULL,
    hash_diff          CHAR(32)     NOT NULL,
    diagnosis_name     VARCHAR(500) DEFAULT NULL,
    diagnosis_group    VARCHAR(200) DEFAULT NULL,
    icd_chapter        VARCHAR(20)  DEFAULT NULL,
    PRIMARY KEY (diagnosis_hash_key, load_date),
    KEY idx_sdd_load_date (load_date),
    CONSTRAINT fk_sdd_diagnosis FOREIGN KEY (diagnosis_hash_key) REFERENCES hub_diagnosis(diagnosis_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sat_study_results (
    study_hash_key  CHAR(32)      NOT NULL,
    load_date       DATETIME      NOT NULL,
    record_source   VARCHAR(100)  NOT NULL,
    hash_diff       CHAR(32)      NOT NULL,
    study_name      VARCHAR(300)  DEFAULT NULL,
    result_value    VARCHAR(2000) DEFAULT NULL,
    result_unit     VARCHAR(50)   DEFAULT NULL,
    reference_range VARCHAR(100)  DEFAULT NULL,
    study_datetime  DATETIME      DEFAULT NULL,
    PRIMARY KEY (study_hash_key, load_date),
    KEY idx_ssr_load_date (load_date),
    CONSTRAINT fk_ssr_study FOREIGN KEY (study_hash_key) REFERENCES hub_study(study_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sat_link_visit_study (
    link_visit_study_hash_key CHAR(32)     NOT NULL,
    load_date                 DATETIME     NOT NULL,
    record_source             VARCHAR(100) NOT NULL,
    hash_diff                 CHAR(32)     NOT NULL,
    prescribed_datetime       DATETIME     DEFAULT NULL,
    completed_datetime        DATETIME     DEFAULT NULL,
    status                    VARCHAR(30)  DEFAULT NULL,
    PRIMARY KEY (link_visit_study_hash_key, load_date),
    KEY idx_slvs_load_date (load_date),
    CONSTRAINT fk_slvs_link FOREIGN KEY (link_visit_study_hash_key)
        REFERENCES link_visit_study(link_visit_study_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sat_link_visit_procedure (
    link_visit_procedure_hash_key CHAR(32)      NOT NULL,
    load_date                     DATETIME      NOT NULL,
    record_source                 VARCHAR(100)  NOT NULL,
    hash_diff                     CHAR(32)      NOT NULL,
    procedure_datetime            DATETIME      DEFAULT NULL,
    quantity                      INT           DEFAULT NULL,
    notes                         VARCHAR(2000) DEFAULT NULL,
    PRIMARY KEY (link_visit_procedure_hash_key, load_date),
    KEY idx_slvp_load_date (load_date),
    CONSTRAINT fk_slvp_link FOREIGN KEY (link_visit_procedure_hash_key)
        REFERENCES link_visit_procedure(link_visit_procedure_hash_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
