--TRIGGER E SEQUENCE HISTORICO
--SEXOS
CREATE OR REPLACE TRIGGER tg_hsexos
BEFORE UPDATE OR DELETE ON sexos
FOR EACH ROW
BEGIN
    INSERT INTO hsexos (hsex_id, hsex_sigla, hsex_data_hist)
    VALUES (:OLD.sex_id, :OLD.sex_sigla, SYSDATE);
END;

--BENEFICIARIOS
CREATE OR REPLACE TRIGGER tg_hbeneficiarios
BEFORE UPDATE OR DELETE ON beneficiarios
FOR EACH ROW
BEGIN
    INSERT INTO hbeneficiarios (
        hben_id, hben_cpf, hben_dt_nascimento, hben_deficiente_fisico,
        hben__loc_id, hben_sex_id, hben_rac_id, hben_data_hist
    )
    VALUES (
        :OLD.ben_id, :OLD.ben_cpf, :OLD.ben_dt_nascimento, :OLD.ben_deficiente_fisico,
        :OLD.ben__loc_id, :OLD.ben_sex_id, :OLD.ben_rac_id, SYSDATE
    );
END;

--BOLSAS
CREATE OR REPLACE TRIGGER tg_hbolsas
BEFORE UPDATE OR DELETE ON bolsas
FOR EACH ROW
BEGIN
    INSERT INTO hbolsas (
        hbol_id, hbol_ano_concessao, hbol_tip_id, hbol_mod_id, hbol_data_hist
    )
    VALUES (
        :OLD.bol_id, :OLD.bol_ano_concessao, :OLD.bol_tip_id, :OLD.bol_mod_id, SYSDATE
    );
END;


--CURSOS
CREATE OR REPLACE TRIGGER tg_hcursos
BEFORE UPDATE OR DELETE ON cursos
FOR EACH ROW
BEGIN
    INSERT INTO hcursos (
        hcrs_id, hcrs_nome, hcrs_tur_id, hcrs_data_hist
    )
    VALUES (
        :OLD.crs_id, :OLD.crs_nome, :OLD.crs_tur_id, SYSDATE
    );
END;



--ESTADOS
CREATE OR REPLACE TRIGGER tg_hestados
BEFORE UPDATE OR DELETE ON estados
FOR EACH ROW
BEGIN
    INSERT INTO hestados (
        hest_id, hest_sigla, hest_reg_id, hest_data_hist
    )
    VALUES (
        :OLD.est_id, :OLD.est_sigla, :OLD.est_reg_id, SYSDATE
    );
END;


--INSTITUICOES
CREATE OR REPLACE TRIGGER tg_hinstituicoes
BEFORE UPDATE OR DELETE ON instituicoes
FOR EACH ROW
BEGIN
    INSERT INTO hinstituicoes (
        hies_id, hies_nome, hies_codigo_emec, hies_data_hist
    )
    VALUES (
        :OLD.ies_id, :OLD.ies_nome, :OLD.ies_codigo_emec, SYSDATE
    );
END;


--LOCALIZACOES
CREATE OR REPLACE TRIGGER tg_hlocalizacoes
BEFORE UPDATE OR DELETE ON localizacoes
FOR EACH ROW
BEGIN
    INSERT INTO hlocalizacoes (
        hloc_id, hloc_municipio, hloc_est_id, hloc_data_hist
    )
    VALUES (
        :OLD.loc_id, :OLD.loc_municipio, :OLD.loc_est_id, SYSDATE
    );
END;


--MATRICULAS
CREATE OR REPLACE TRIGGER tg_hmatriculas
BEFORE UPDATE OR DELETE ON matriculas
FOR EACH ROW
BEGIN
    INSERT INTO hmatriculas (
        hmat_id, hmat_ies_id, hmat_crs_id, hmat_bol_id, hmat_ben_id, hmat_data_hist
    )
    VALUES (
        :OLD.mat_id, :OLD.mat_ies_id, :OLD.mat_crs_id, :OLD.mat_bol_id, :OLD.mat_ben_id, SYSDATE
    );
END;


--MODALIDADES
CREATE OR REPLACE TRIGGER tg_hmodalidades
BEFORE UPDATE OR DELETE ON modalidades
FOR EACH ROW
BEGIN
    INSERT INTO hmodalidades (
        hmod_id, hmod_modalidade, hmod_data_hist
    )
    VALUES (
        :OLD.mod_id, :OLD.mod_modalidade, SYSDATE
    );
END;



--RACAS
CREATE OR REPLACE TRIGGER tg_hracas
BEFORE UPDATE OR DELETE ON racas
FOR EACH ROW
BEGIN
    INSERT INTO hracas (
        hrac_id, hrac_raca, hrac_data_hist
    )
    VALUES (
        :OLD.rac_id, :OLD.rac_raca, SYSDATE
    );
END;


--REGIAO
CREATE OR REPLACE TRIGGER tg_hregiao
BEFORE UPDATE OR DELETE ON regiao
FOR EACH ROW
BEGIN
    INSERT INTO hregiao (
        hreg_id, hreg_nome, hreg_data_hist
    )
    VALUES (
        :OLD.reg_id, :OLD.reg_nome, SYSDATE
    );
END;


--TIPO
CREATE OR REPLACE TRIGGER tg_htipo
BEFORE UPDATE OR DELETE ON tipo
FOR EACH ROW
BEGIN
    INSERT INTO htipo (
        htip_id, htip_tipo, htip_data_hist
    )
    VALUES (
        :OLD.tip_id, :OLD.tip_tipo, SYSDATE
    );
END;


--TURNOS
CREATE OR REPLACE TRIGGER tg_hturnos
BEFORE UPDATE OR DELETE ON turnos
FOR EACH ROW
BEGIN
    INSERT INTO hturnos (
        htur_id, htur_turno, htur_data_hist
    )
    VALUES (
        :OLD.tur_id, :OLD.tur_turno, SYSDATE
    );
END;
