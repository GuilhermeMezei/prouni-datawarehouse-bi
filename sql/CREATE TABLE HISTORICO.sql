--TABELAS HISTÓRICOS

CREATE TABLE hbeneficiarios (
    hben_id                NUMBER(6) NOT NULL,
    hben_cpf               VARCHAR2(15 CHAR) NOT NULL,
    hben_dt_nascimento     DATE NOT NULL,
    hben_deficiente_fisico VARCHAR2(2 CHAR) NOT NULL,
    hben__loc_id           NUMBER(6) NOT NULL,
    hben_sex_id            NUMBER(6) NOT NULL,
    hben_rac_id            NUMBER(6) NOT NULL,
    hben_data_hist         DATE DEFAULT SYSDATE
);
ALTER TABLE hbeneficiarios ADD CONSTRAINT hbeneficiarios_pk PRIMARY KEY ( hben_id );

CREATE TABLE hbolsas (
    hbol_id            NUMBER(6) NOT NULL,
    hbol_ano_concessao DATE NOT NULL,
    hbol_tip_id        NUMBER(6) NOT NULL,
    hbol_mod_id        NUMBER(6) NOT NULL,
    hbol_data_hist     DATE DEFAULT SYSDATE
);
ALTER TABLE hbolsas ADD CONSTRAINT hbolsas_pk PRIMARY KEY ( hbol_id );

CREATE TABLE hcursos (
    hcrs_id        NUMBER(6) NOT NULL,
    hcrs_nome      VARCHAR2(300),
    hcrs_tur_id    NUMBER(6) NOT NULL,
    hcrs_data_hist DATE DEFAULT SYSDATE
);
ALTER TABLE hcursos ADD CONSTRAINT hcursos_pk PRIMARY KEY ( hcrs_id );

CREATE TABLE hestados (
    hest_id        NUMBER(6) NOT NULL,
    hest_sigla     VARCHAR2(3) NOT NULL,
    hest_reg_id    NUMBER(6) NOT NULL,
    hest_data_hist DATE DEFAULT SYSDATE
);
ALTER TABLE hestados ADD CONSTRAINT hestados_pk PRIMARY KEY ( hest_id );

CREATE TABLE hinstituicoes (
    hies_id           NUMBER(6) NOT NULL,
    hies_nome         VARCHAR2(100 CHAR) NOT NULL,
    hies_codigo_emec  VARCHAR2(10 CHAR) NOT NULL,
    hies_data_hist    DATE DEFAULT SYSDATE
);
ALTER TABLE hinstituicoes ADD CONSTRAINT hinstituicoes_pk PRIMARY KEY ( hies_id );

CREATE TABLE hlocalizacoes (
    hloc_id        NUMBER(6) NOT NULL,
    hloc_municipio VARCHAR2(40 CHAR) NOT NULL,
    hloc_est_id    NUMBER(6) NOT NULL,
    hloc_data_hist DATE DEFAULT SYSDATE
);
ALTER TABLE hlocalizacoes ADD CONSTRAINT hlocalizacoes_pk PRIMARY KEY ( hloc_id );

CREATE TABLE hmatriculas (
    hmat_id        NUMBER(6) NOT NULL,
    hmat_ies_id    NUMBER(6) NOT NULL,
    hmat_crs_id    NUMBER(6),
    hmat_bol_id    NUMBER(6) NOT NULL,
    hmat_ben_id    NUMBER(6) NOT NULL,
    hmat_data_hist DATE DEFAULT SYSDATE
);
ALTER TABLE hmatriculas ADD CONSTRAINT hmatriculas_pk PRIMARY KEY ( hmat_id );

CREATE TABLE hmodalidades (
    hmod_id         NUMBER(6) NOT NULL,
    hmod_modalidade VARCHAR2(10) NOT NULL,
    hmod_data_hist  DATE DEFAULT SYSDATE
);
ALTER TABLE hmodalidades ADD CONSTRAINT hmodelidades_pk PRIMARY KEY ( hmod_id );

CREATE TABLE hracas (
    hrac_id        NUMBER(6) NOT NULL,
    hrac_raca      VARCHAR2(20),
    hrac_data_hist DATE DEFAULT SYSDATE
);
ALTER TABLE hracas ADD CONSTRAINT hracas_pk PRIMARY KEY ( hrac_id );

CREATE TABLE hregiao (
    hreg_id        NUMBER(6) NOT NULL,
    hreg_nome      VARCHAR2(20),
    hreg_data_hist DATE DEFAULT SYSDATE
);
ALTER TABLE hregiao ADD CONSTRAINT hregiao_pk PRIMARY KEY ( hreg_id );

CREATE TABLE hsexos (
    hsex_id        NUMBER(6) NOT NULL,
    hsex_sigla     VARCHAR2(2) NOT NULL,
    hsex_data_hist DATE DEFAULT SYSDATE
);
ALTER TABLE hsexos ADD CONSTRAINT hsexos_pk PRIMARY KEY ( hsex_id );

CREATE TABLE htipo (
    htip_id        NUMBER(6) NOT NULL,
    htip_tipo      VARCHAR2(20),
    htip_data_hist DATE DEFAULT SYSDATE
);
ALTER TABLE htipo ADD CONSTRAINT htipo_pk PRIMARY KEY ( htip_id );

CREATE TABLE hturnos (
    htur_id        NUMBER(6) NOT NULL,
    htur_turno     VARCHAR2(30),
    htur_data_hist DATE DEFAULT SYSDATE
);
ALTER TABLE hturnos ADD CONSTRAINT hturnos_pk PRIMARY KEY ( htur_id );
