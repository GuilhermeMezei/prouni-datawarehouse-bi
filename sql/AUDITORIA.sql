-- AUDITORIA --

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

    CREATE USER AUDITORIA IDENTIFIED BY 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA UNLIMITED ON USERS;
    
    GRANT CONNECT, RESOURCE TO AUDITORIA;
  
-- TRIGGER DO SEXO DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_aud_sexos
AFTER UPDATE OR DELETE ON hsexos
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'HSEXOS';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.hsex_id <> :OLD.hsex_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'HSEX_ID', :OLD.hsex_id, :NEW.hsex_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.hsex_sigla <> :OLD.hsex_sigla) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'HSEX_SIGLA', :OLD.hsex_sigla, :NEW.hsex_sigla, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.hsex_data_hist <> :OLD.hsex_data_hist) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'HSEX_DATA_HIST', :OLD.hsex_data_hist, :NEW.hsex_data_hist, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
-- TRIGGER DO BENEFICIARIO DA AUDITORIA--

CREATE OR REPLACE TRIGGER tg_hbeneficiarios
AFTER UPDATE OR DELETE ON beneficiarios
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'BENEFICIARIOS';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.ben_id <> :OLD.ben_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BEN_ID', :OLD.ben_id, :NEW.ben_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.ben_cpf <> :OLD.ben_cpf) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BEN_CPF', :OLD.ben_cpf, :NEW.ben_cpf, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.ben_dt_nascimento <> :OLD.ben_dt_nascimento) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BEN_DT_NASCIMENTO', :OLD.ben_dt_nascimento, :NEW.ben_dt_nascimento, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.ben_deficiente_fisico <> :OLD.ben_deficiente_fisico) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BEN_DEFICIENTE_FISICO', :OLD.ben_deficiente_fisico, :NEW.ben_deficiente_fisico, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.ben__loc_id <> :OLD.ben__loc_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BEN__LOC_ID', :OLD.ben__loc_id, :NEW.ben__loc_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.ben_sex_id <> :OLD.ben_sex_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BEN_SEX_ID', :OLD.ben_sex_id, :NEW.ben_sex_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.ben_rac_id <> :OLD.ben_rac_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BEN_RAC_ID', :OLD.ben_rac_id, :NEW.ben_rac_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/

-- TRIGGER DO BOLSAS DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_hbolsas
AFTER UPDATE OR DELETE ON bolsas
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'BOLSAS';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.bol_id <> :OLD.bol_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BOL_ID', :OLD.bol_id, :NEW.bol_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.bol_ano_concessao <> :OLD.bol_ano_concessao) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BOL_ANO_CONCESSAO', :OLD.bol_ano_concessao, :NEW.bol_ano_concessao, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.bol_tip_id <> :OLD.bol_tip_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BOL_TIP_ID', :OLD.bol_tip_id, :NEW.bol_tip_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.bol_mod_id <> :OLD.bol_mod_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'BOL_MOD_ID', :OLD.bol_mod_id, :NEW.bol_mod_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/

-- TRIGGER DO CURSOS DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_hcursos
AFTER UPDATE OR DELETE ON cursos
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'CURSOS';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.crs_id <> :OLD.crs_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'CRS_ID', :OLD.crs_id, :NEW.crs_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.crs_nome <> :OLD.crs_nome) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'CRS_NOME', :OLD.crs_nome, :NEW.crs_nome, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.crs_tur_id <> :OLD.crs_tur_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'CRS_TUR_ID', :OLD.crs_tur_id, :NEW.crs_tur_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/


-- TRIGGER DO ESTADOS DA AUDITORIA--

CREATE OR REPLACE TRIGGER tg_hestados
AFTER UPDATE OR DELETE ON estados
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'ESTADOS';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.est_id <> :OLD.est_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'EST_ID', :OLD.est_id, :NEW.est_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.est_sigla <> :OLD.est_sigla) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'EST_SIGLA', :OLD.est_sigla, :NEW.est_sigla, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.est_reg_id <> :OLD.est_reg_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'EST_REG_ID', :OLD.est_reg_id, :NEW.est_reg_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/

-- TRIGGER DO INSTITUICOES DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_hinstituicoes
AFTER UPDATE OR DELETE ON instituicoes
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'INSTITUICOES';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.ies_id <> :OLD.ies_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'IES_ID', :OLD.ies_id, :NEW.ies_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.ies_nome <> :OLD.ies_nome) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'IES_NOME', :OLD.ies_nome, :NEW.ies_nome, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.ies_codigo_emec <> :OLD.ies_codigo_emec) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'IES_CODIGO_EMEC', :OLD.ies_codigo_emec, :NEW.ies_codigo_emec, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/

-- TRIGGER DO LOCALIZACOES DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_hlocalizacoes
AFTER UPDATE OR DELETE ON localizacoes
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'LOCALIZACOES';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.loc_id <> :OLD.loc_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'LOC_ID', :OLD.loc_id, :NEW.loc_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.loc_municipio <> :OLD.loc_municipio) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'LOC_MUNICIPIO', :OLD.loc_municipio, :NEW.loc_municipio, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.loc_est_id <> :OLD.loc_est_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'LOC_EST_ID', :OLD.loc_est_id, :NEW.loc_est_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/

-- TRIGGER DO MATRICULAS DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_hmatriculas
AFTER UPDATE OR DELETE ON matriculas
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'MATRICULAS';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.mat_id <> :OLD.mat_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'MAT_ID', :OLD.mat_id, :NEW.mat_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.mat_ies_id <> :OLD.mat_ies_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'MAT_IES_ID', :OLD.mat_ies_id, :NEW.mat_ies_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.mat_crs_id <> :OLD.mat_crs_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'MAT_CRS_ID', :OLD.mat_crs_id, :NEW.mat_crs_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.mat_bol_id <> :OLD.mat_bol_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'MAT_BOL_ID', :OLD.mat_bol_id, :NEW.mat_bol_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.mat_ben_id <> :OLD.mat_ben_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'MAT_BEN_ID', :OLD.mat_ben_id, :NEW.mat_ben_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/


-- TRIGGER DO MODALIDADES DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_hmodalidades
AFTER UPDATE OR DELETE ON modalidades
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'MODALIDADES';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.mod_id <> :OLD.mod_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'MOD_ID', :OLD.mod_id, :NEW.mod_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.mod_modalidade <> :OLD.mod_modalidade) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'MOD_MODALIDADE', :OLD.mod_modalidade, :NEW.mod_modalidade, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/

-- TRIGGER DO RACAS DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_hracas
AFTER UPDATE OR DELETE ON racas
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'RACAS';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.rac_id <> :OLD.rac_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'RAC_ID', :OLD.rac_id, :NEW.rac_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.rac_raca <> :OLD.rac_raca) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'RAC_RACA', :OLD.rac_raca, :NEW.rac_raca, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/

-- TRIGGER DO REGIAO DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_hregiao
AFTER UPDATE OR DELETE ON regiao
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'REGIAO';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.reg_id <> :OLD.reg_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'REG_ID', :OLD.reg_id, :NEW.reg_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.reg_nome <> :OLD.reg_nome) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'REG_NOME', :OLD.reg_nome, :NEW.reg_nome, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/

-- TRIGGER DO TIPOS DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_htipo
AFTER UPDATE OR DELETE ON tipo
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'TIPO';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.tip_id <> :OLD.tip_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'TIP_ID', :OLD.tip_id, :NEW.tip_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.tip_tipo <> :OLD.tip_tipo) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'TIP_TIPO', :OLD.tip_tipo, :NEW.tip_tipo, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/

-- TRIGGER DO TURNOS DA AUDITORIA--
CREATE OR REPLACE TRIGGER tg_hturnos
AFTER UPDATE OR DELETE ON turnos
FOR EACH ROW
DECLARE
    v_usu_bd   VARCHAR2(30);
    v_usu_so   VARCHAR2(255) := SYS_CONTEXT('USERENV', 'OS_USER');
    v_tp_op    CHAR(1);
    v_rowid    VARCHAR2(20);
    v_tabela   VARCHAR2(30) := 'TURNOS';
BEGIN
    SELECT USER INTO v_usu_bd FROM DUAL;
    v_rowid := :OLD.ROWID;

    IF DELETING THEN
        v_tp_op := 'D';
        AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, NULL, NULL, NULL, v_usu_bd, v_usu_so, SYSDATE);
    ELSE
        v_tp_op := 'U';
        IF (:NEW.tur_id <> :OLD.tur_id) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'TUR_ID', :OLD.tur_id, :NEW.tur_id, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
        IF (:NEW.tur_turno <> :OLD.tur_turno) THEN
            AUDITORIA.PROC_AUDITORIA(v_tabela, v_rowid, v_tp_op, 'TUR_TURNO', :OLD.tur_turno, :NEW.tur_turno, v_usu_bd, v_usu_so, SYSDATE);
        END IF;
    END IF;
END;
/