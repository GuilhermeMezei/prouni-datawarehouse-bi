-- INSERÇÃO DE DADOS

INSERT INTO matriculas (
    mat_id,
    mat_ies_id,
    mat_crs_id,
    mat_bol_id,
    mat_ben_id
)
SELECT
    seq_matriculas_id.NEXTVAL,
    i.ies_id,
    c.crs_id,
    b.bol_id,
    bn.ben_id
FROM DADOS2020 d
JOIN instituicoes i ON i.ies_nome = d.NOME_IES_BOLSA
JOIN turnos t ON t.tur_turno = d.NOME_TURNO_CURSO_BOLSA
JOIN cursos c ON c.crs_nome = d.NOME_CURSO_BOLSA AND c.crs_tur_id = t.tur_id
JOIN tipo tp ON tp.tip_tipo = d.TIPO_BOLSA
JOIN modalidades m ON m.mod_modalidade = d.MODALIDADE_ENSINO_BOLSA
JOIN bolsas b ON b.bol_ano_concessao = TO_DATE(d.ANO_CONCESSAO_BOLSA, 'YYYY') 
              AND b.bol_tip_id = tp.tip_id 
              AND b.bol_mod_id = m.mod_id
JOIN estados e ON e.est_sigla = d.SIGLA_UF_BENEFICIARIO_BOLSA
JOIN localizacoes l ON l.loc_municipio = d.MUNICIPIO_BENEFICIARIO_BOLSA AND l.loc_est_id = e.est_id
JOIN racas r ON r.rac_raca = d.RACA_BENEFICIARIO_BOLSA
JOIN sexos s ON s.sex_sigla = d.SEXO_BENEFICIARIO_BOLSA
JOIN beneficiarios bn ON bn.ben_cpf = d.CPF_BENEFICIARIO_BOLSA 
                       AND bn.ben_dt_nascimento = TO_DATE(d.DT_NASCIMENTO_BENEFICIARIO, 'DD/MM/YY')
                       AND bn.ben__loc_id = l.loc_id
                       AND bn.ben_rac_id = r.rac_id
                       AND bn.ben_sex_id = s.sex_id
WHERE 
    d.NOME_IES_BOLSA IS NOT NULL
    AND d.NOME_CURSO_BOLSA IS NOT NULL
    AND d.NOME_TURNO_CURSO_BOLSA IS NOT NULL
    AND d.TIPO_BOLSA IS NOT NULL
    AND d.MODALIDADE_ENSINO_BOLSA IS NOT NULL
    AND d.ANO_CONCESSAO_BOLSA IS NOT NULL
    AND d.CPF_BENEFICIARIO_BOLSA IS NOT NULL
    AND d.DT_NASCIMENTO_BENEFICIARIO IS NOT NULL;

SELECT column_name, data_type, data_precision, data_scale
FROM all_tab_columns
WHERE table_name = 'MATRICULAS'
  AND column_name IN ('MAT_IES_ID', 'MAT_CRS_ID', 'MAT_BOL_ID', 'MAT_BEN_ID');

SELECT
    i.ies_id,
    c.crs_id,
    b.bol_id,
    bn.ben_id
FROM DADOS2020 d
JOIN instituicoes i ON i.ies_nome = d.NOME_IES_BOLSA
JOIN turnos t ON t.tur_turno = d.NOME_TURNO_CURSO_BOLSA
JOIN cursos c ON c.crs_nome = d.NOME_CURSO_BOLSA AND c.crs_tur_id = t.tur_id
JOIN tipo tp ON tp.tip_tipo = d.TIPO_BOLSA
JOIN modalidades m ON m.mod_modalidade = d.MODALIDADE_ENSINO_BOLSA
JOIN bolsas b ON b.bol_ano_concessao = TO_DATE(d.ANO_CONCESSAO_BOLSA, 'YYYY') 
              AND b.bol_tip_id = tp.tip_id 
              AND b.bol_mod_id = m.mod_id
JOIN estados e ON e.est_sigla = d.SIGLA_UF_BENEFICIARIO_BOLSA
JOIN localizacoes l ON l.loc_municipio = d.MUNICIPIO_BENEFICIARIO_BOLSA AND l.loc_est_id = e.est_id
JOIN racas r ON r.rac_raca = d.RACA_BENEFICIARIO_BOLSA
JOIN sexos s ON s.sex_sigla = d.SEXO_BENEFICIARIO_BOLSA
JOIN beneficiarios bn ON bn.ben_cpf = d.CPF_BENEFICIARIO_BOLSA 
                       AND bn.ben_dt_nascimento = TO_DATE(d.DT_NASCIMENTO_BENEFICIARIO, 'DD/MM/YY')
                       AND bn.ben__loc_id = l.loc_id
                       AND bn.ben_rac_id = r.rac_id
                       AND bn.ben_sex_id = s.sex_id
WHERE 
    (i.ies_id > 99999 OR c.crs_id > 99999 OR b.bol_id > 99999 OR bn.ben_id > 99999);

INSERT INTO beneficiarios (
    ben_cpf,
    ben_dt_nascimento,
    ben_deficiente_fisico,
    ben__loc_id,
    ben_sex_id,
    ben_rac_id
)
SELECT DISTINCT
    d.CPF_BENEFICIARIO_BOLSA,
    TO_DATE(d.DT_NASCIMENTO_BENEFICIARIO, 'DD/MM/YY'),
    d.BENEFICIARIO_DEFICIENTE_FISICO,
    l.loc_id,
    s.sex_id,
    r.rac_id
FROM DADOS2020 d
JOIN localizacoes l ON l.loc_municipio = d.MUNICIPIO_BENEFICIARIO_BOLSA
JOIN estados e ON e.est_sigla = d.SIGLA_UF_BENEFICIARIO_BOLSA AND e.est_id = l.loc_est_id
JOIN sexos s ON s.sex_sigla = d.SEXO_BENEFICIARIO_BOLSA
JOIN racas r ON r.rac_raca = d.RACA_BENEFICIARIO_BOLSA
WHERE d.CPF_BENEFICIARIO_BOLSA IS NOT NULL
  AND TO_DATE(d.DT_NASCIMENTO_BENEFICIARIO, 'DD/MM/YY') IS NOT NULL
  AND d.BENEFICIARIO_DEFICIENTE_FISICO IS NOT NULL
  AND d.MUNICIPIO_BENEFICIARIO_BOLSA IS NOT NULL
  AND d.SIGLA_UF_BENEFICIARIO_BOLSA IS NOT NULL
  AND d.SEXO_BENEFICIARIO_BOLSA IS NOT NULL
  AND d.RACA_BENEFICIARIO_BOLSA IS NOT NULL;


INSERT INTO localizacoes (loc_municipio, loc_est_id)
SELECT DISTINCT
    d.MUNICIPIO_BENEFICIARIO_BOLSA,
    e.est_id
FROM DADOS2020 d
JOIN estados e ON e.est_sigla = d.SIGLA_UF_BENEFICIARIO_BOLSA
WHERE d.MUNICIPIO_BENEFICIARIO_BOLSA IS NOT NULL
  AND d.SIGLA_UF_BENEFICIARIO_BOLSA IS NOT NULL
  AND d.MUNICIPIO_BENEFICIARIO_BOLSA NOT IN (SELECT loc_municipio FROM localizacoes);



INSERT INTO racas (rac_raca)
SELECT d.RACA_BENEFICIARIO_BOLSA
FROM (
    SELECT DISTINCT RACA_BENEFICIARIO_BOLSA
    FROM DADOS2020
    WHERE RACA_BENEFICIARIO_BOLSA IS NOT NULL
      AND RACA_BENEFICIARIO_BOLSA NOT IN (SELECT rac_raca FROM racas)
) d;


INSERT INTO estados (est_sigla, est_reg_id)
SELECT DISTINCT
    d.SIGLA_UF_BENEFICIARIO_BOLSA,
    r.reg_id
FROM DADOS2020 d
JOIN regiao r ON r.reg_nome = d.REGIAO_BENEFICIARIO_BOLSA
WHERE d.SIGLA_UF_BENEFICIARIO_BOLSA IS NOT NULL
  AND d.REGIAO_BENEFICIARIO_BOLSA IS NOT NULL
  AND d.SIGLA_UF_BENEFICIARIO_BOLSA NOT IN (SELECT est_sigla FROM estados);


INSERT INTO regiao (reg_nome)
SELECT d.REGIAO_BENEFICIARIO_BOLSA
FROM (
    SELECT DISTINCT REGIAO_BENEFICIARIO_BOLSA
    FROM DADOS2020
    WHERE REGIAO_BENEFICIARIO_BOLSA IS NOT NULL
      AND REGIAO_BENEFICIARIO_BOLSA NOT IN (SELECT reg_nome FROM regiao)
) d;



INSERT INTO cursos (crs_nome, crs_tur_id)
SELECT DISTINCT
    d.NOME_CURSO_BOLSA,
    t.tur_id
FROM DADOS2020 d
JOIN turnos t ON t.tur_turno = d.NOME_TURNO_CURSO_BOLSA
WHERE d.NOME_CURSO_BOLSA IS NOT NULL
  AND d.NOME_TURNO_CURSO_BOLSA IS NOT NULL
  AND d.NOME_CURSO_BOLSA NOT IN (SELECT crs_nome FROM cursos);
  

INSERT INTO turnos (tur_turno)
SELECT d.NOME_TURNO_CURSO_BOLSA
FROM (
    SELECT DISTINCT NOME_TURNO_CURSO_BOLSA
    FROM DADOS2020
    WHERE NOME_TURNO_CURSO_BOLSA IS NOT NULL
      AND NOME_TURNO_CURSO_BOLSA NOT IN (SELECT tur_turno FROM turnos)
) d;



INSERT INTO bolsas (bol_ano_concessao, bol_tip_id, bol_mod_id)
SELECT DISTINCT
    TO_DATE(d.ANO_CONCESSAO_BOLSA, 'YYYY'),
    t.tip_id,
    m.mod_id
FROM DADOS2020 d
JOIN tipo t ON t.tip_tipo = d.tipo_bolsa
JOIN modalidades m ON m.mod_modalidade = d.modalidade_ensino_bolsa
WHERE d.ano_concessao_bolsa IS NOT NULL
  AND d.tipo_bolsa IS NOT NULL
  AND d.modalidade_ensino_bolsa IS NOT NULL;




INSERT INTO tipo (TIP_TIPO)
SELECT d.TIPO_BOLSA
FROM (
    SELECT DISTINCT TIPO_BOLSA
    FROM DADOS2020
    WHERE TIPO_BOLSA IS NOT NULL
      AND TIPO_BOLSA NOT IN (SELECT TIP_TIPO FROM tipo)
) d;



INSERT INTO instituicoes (IES_ID, IES_CODIGO_EMEC, IES_NOME)
SELECT seq_instituicoes_id.NEXTVAL, d.CODIGO_EMEC_IES_BOLSA, d.NOME_IES_BOLSA
FROM (
    SELECT DISTINCT CODIGO_EMEC_IES_BOLSA, NOME_IES_BOLSA
    FROM DADOS2020
    WHERE CODIGO_EMEC_IES_BOLSA IS NOT NULL
      AND NOME_IES_BOLSA IS NOT NULL
      AND CODIGO_EMEC_IES_BOLSA NOT IN (SELECT IES_CODIGO_EMEC FROM instituicoes)
) d;


INSERT INTO sexos (sex_id, sex_sigla)
SELECT seq_sexos_id.NEXTVAL, d.sexo_beneficiario_bolsa
FROM (
    SELECT DISTINCT sexo_beneficiario_bolsa
    FROM dados2020
    WHERE sexo_beneficiario_bolsa IS NOT NULL
      AND sexo_beneficiario_bolsa NOT IN (SELECT sex_sigla FROM sexos)
) d;


INSERT INTO modalidades (mod_id, mod_modalidade)
SELECT seq_modalidades_id.NEXTVAL, d.modalidade_ensino_bolsa
FROM (
    SELECT DISTINCT modalidade_ensino_bolsa
    FROM dados2020
    WHERE modalidade_ensino_bolsa IS NOT NULL
      AND modalidade_ensino_bolsa NOT IN (SELECT mod_modalidade FROM modalidades)
) d;
