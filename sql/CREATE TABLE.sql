CREATE TABLE beneficiarios (
    ben_id                NUMBER(6) NOT NULL,
    ben_cpf               VARCHAR2(15 CHAR) NOT NULL,
    ben_dt_nascimento     DATE NOT NULL,
    ben_deficiente_fisico VARCHAR2(2 CHAR) NOT NULL,
    ben__loc_id           NUMBER(6) NOT NULL,
    ben_sex_id            NUMBER(6) NOT NULL,
    ben_rac_id            NUMBER(6) NOT NULL
);

ALTER TABLE beneficiarios ADD CONSTRAINT beneficiarios_pk PRIMARY KEY ( ben_id );

CREATE TABLE bolsas (
    bol_id            NUMBER(6) NOT NULL,
    bol_ano_concessao DATE NOT NULL,
    bol_tip_id        NUMBER(6) NOT NULL,
    bol_mod_id        NUMBER(6) NOT NULL
);

ALTER TABLE bolsas ADD CONSTRAINT bolsas_pk PRIMARY KEY ( bol_id );

CREATE TABLE cursos (
    crs_id     NUMBER(6) NOT NULL,
    crs_nome   VARCHAR2(70 CHAR),
    crs_tur_id NUMBER(6) NOT NULL
);
ALTER TABLE cursos
MODIFY crs_nome VARCHAR2(300);

ALTER TABLE cursos ADD CONSTRAINT cursos_pk PRIMARY KEY ( crs_id );

CREATE TABLE estados (
    est_id     NUMBER(6) NOT NULL,
    est_sigla  VARCHAR2(3) NOT NULL,
    est_reg_id NUMBER(6) NOT NULL
);

ALTER TABLE estados ADD CONSTRAINT estados_pk PRIMARY KEY ( est_id );

CREATE TABLE instituicoes (
    ies_id          NUMBER(6) NOT NULL,
    ies_nome        VARCHAR2(100 CHAR) NOT NULL,
    ies_codigo_emec VARCHAR2(10 CHAR) NOT NULL
);

ALTER TABLE instituicoes ADD CONSTRAINT instituicoes_pk PRIMARY KEY ( ies_id );

CREATE TABLE localizacoes (
    loc_id        NUMBER(6) NOT NULL,
    loc_municipio VARCHAR2(40 CHAR) NOT NULL,
    loc_est_id    NUMBER(6) NOT NULL
);

ALTER TABLE localizacoes ADD CONSTRAINT localizacoes_pk PRIMARY KEY ( loc_id );

CREATE TABLE matriculas (
    mat_id     NUMBER(6) NOT NULL,
    mat_ies_id NUMBER(6) NOT NULL,
    mat_crs_id NUMBER(6),
    mat_bol_id NUMBER(6) NOT NULL,
    mat_ben_id NUMBER(6) NOT NULL
);

ALTER TABLE matriculas
MODIFY mat_ies_id number(10);

ALTER TABLE matriculas
MODIFY mat_id number(10);

ALTER TABLE matriculas
MODIFY mat_crs_id number(10);

ALTER TABLE matriculas
MODIFY mat_bol_id number(10);

ALTER TABLE matriculas
MODIFY mat_ben_id number(10);

ALTER TABLE matriculas ADD CONSTRAINT matriculas_pk PRIMARY KEY ( mat_id );

CREATE TABLE modalidades (
    mod_id         NUMBER(6) NOT NULL,
    mod_modalidade VARCHAR2(10) NOT NULL
);

ALTER TABLE modalidades ADD CONSTRAINT modelidades_pk PRIMARY KEY ( mod_id );

CREATE TABLE racas (
    rac_id   NUMBER(6) NOT NULL,
    rac_raca VARCHAR2(10) NOT NULL
);
ALTER TABLE racas
MODIFY rac_raca VARCHAR2(20);

ALTER TABLE racas ADD CONSTRAINT racas_pk PRIMARY KEY ( rac_id );

CREATE TABLE regiao (
    reg_id   NUMBER(6) NOT NULL,
    reg_nome VARCHAR2(20) NOT NULL
);

ALTER TABLE regiao
MODIFY reg_nome VARCHAR2(20);

ALTER TABLE regiao ADD CONSTRAINT regiao_pk PRIMARY KEY ( reg_id );

CREATE TABLE sexos (
    sex_id    NUMBER(6) NOT NULL,
    sex_sigla VARCHAR2(2) NOT NULL
);

ALTER TABLE sexos ADD CONSTRAINT sexos_pk PRIMARY KEY ( sex_id );

CREATE TABLE tipo (
    tip_id   NUMBER(6) NOT NULL,
    tip_tipo VARCHAR2(10) NOT NULL
);

ALTER TABLE tipo
MODIFY (tip_tipo VARCHAR2(20));

ALTER TABLE tipo ADD CONSTRAINT tipo_pk PRIMARY KEY ( tip_id );

CREATE TABLE turnos (
    tur_id    NUMBER(6) NOT NULL,
    tur_turno VARCHAR2(15) NOT NULL
);

ALTER TABLE turnos
MODIFY tur_turno VARCHAR2(30);


ALTER TABLE turnos ADD CONSTRAINT turnos_pk PRIMARY KEY ( tur_id );

ALTER TABLE beneficiarios
    ADD CONSTRAINT ben_loc_fk FOREIGN KEY ( ben__loc_id )
        REFERENCES localizacoes ( loc_id );

ALTER TABLE beneficiarios
    ADD CONSTRAINT ben_rac_fk FOREIGN KEY ( ben_rac_id )
        REFERENCES racas ( rac_id );

ALTER TABLE beneficiarios
    ADD CONSTRAINT ben_sex_fk FOREIGN KEY ( ben_sex_id )
        REFERENCES sexos ( sex_id );

ALTER TABLE bolsas
    ADD CONSTRAINT bol_mod_fk FOREIGN KEY ( bol_mod_id )
        REFERENCES modelidades ( mod_id );

ALTER TABLE bolsas
    ADD CONSTRAINT bol_tip_fk FOREIGN KEY ( bol_tip_id )
        REFERENCES tipo ( tip_id );

ALTER TABLE cursos
    ADD CONSTRAINT crs_tur_fk FOREIGN KEY ( crs_tur_id )
        REFERENCES turnos ( tur_id );

ALTER TABLE estados
    ADD CONSTRAINT est_reg_fk FOREIGN KEY ( est_reg_id )
        REFERENCES regiao ( reg_id );

ALTER TABLE localizacoes
    ADD CONSTRAINT loc_est_fk FOREIGN KEY ( loc_est_id )
        REFERENCES estados ( est_id );

ALTER TABLE matriculas
    ADD CONSTRAINT mat_ben_fk FOREIGN KEY ( mat_ben_id )
        REFERENCES beneficiarios ( ben_id );

ALTER TABLE matriculas
    ADD CONSTRAINT mat_bol_fk FOREIGN KEY ( mat_bol_id )
        REFERENCES bolsas ( bol_id );

ALTER TABLE matriculas
    ADD CONSTRAINT mat_ies_fk FOREIGN KEY ( mat_ies_id )
        REFERENCES instituicoes ( ies_id );

ALTER TABLE matriculas
    ADD CONSTRAINT met_crs_fk FOREIGN KEY ( mat_crs_id )
        REFERENCES cursos ( crs_id );
