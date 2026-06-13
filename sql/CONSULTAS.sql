--CONSULTAS--
--Evasão Potencial: Beneficiários com mais de uma matrícula em instituições diferentes
SELECT b.ben_id, COUNT(DISTINCT m.mat_ies_id) AS instituicoes_distintas
FROM beneficiarios b
JOIN matriculas m ON b.ben_id = m.mat_ben_id
GROUP BY b.ben_id
HAVING COUNT(DISTINCT m.mat_ies_id) > 1;

--Instituições com maior concentração de cursos noturnos
SELECT i.ies_nome, COUNT(*) AS total_noturnos
FROM cursos c
JOIN instituicoes i ON c.crs_id = i.ies_id
JOIN turnos t ON c.crs_tur_id = t.tur_id
WHERE t.tur_turno = 'Noturno'
GROUP BY i.ies_nome
ORDER BY total_noturnos DESC;

--Ranking de Raças mais atendidas por tipo de bolsa
SELECT 
    tp.tip_tipo, 
    r.rac_raca, 
    COUNT(*) AS total_bolsas,
    ROUND((COUNT(*) * 100.0) / (
        SELECT COUNT(*) 
        FROM beneficiarios b
        JOIN matriculas m ON m.mat_ben_id = b.ben_id
        JOIN bolsas bol ON bol.bol_id = m.mat_bol_id
    ), 2) AS porcentagem
FROM beneficiarios b
JOIN racas r ON b.ben_rac_id = r.rac_id
JOIN matriculas m ON m.mat_ben_id = b.ben_id
JOIN bolsas bol ON bol.bol_id = m.mat_bol_id
JOIN tipo tp ON tp.tip_id = bol.bol_tip_id
GROUP BY tp.tip_tipo, r.rac_raca
ORDER BY r.rac_raca, tp.tip_tipo;

--Porcentagem de beneficiários por modalidade de ensino (presencial/EAD)
SELECT mo.mod_modalidade, 
       COUNT(*) AS total,
       ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM matriculas), 2) AS porcentagem
FROM matriculas m
JOIN bolsas b ON b.bol_id = m.mat_bol_id
JOIN modalidades mo ON mo.mod_id = b.bol_mod_id
GROUP BY mo.mod_modalidade;

--Quantidade de cursos por turno e modalidade
SELECT t.tur_turno, mo.mod_modalidade, COUNT(*) AS total_cursos
FROM cursos c
JOIN turnos t ON c.crs_tur_id = t.tur_id
JOIN bolsas b ON c.crs_id = (SELECT mat_crs_id FROM matriculas WHERE mat_bol_id = b.bol_id FETCH FIRST 1 ROWS ONLY)
JOIN modalidades mo ON b.bol_mod_id = mo.mod_id
GROUP BY t.tur_turno, mo.mod_modalidade
ORDER BY total_cursos DESC;

--Evolução anual de beneficiários deficientes
SELECT 
    CASE
        WHEN TO_NUMBER(TO_CHAR(ben_dt_nascimento, 'YY')) > 20 THEN
            '19' || TO_CHAR(ben_dt_nascimento, 'YY')  -- Século 20 para anos menores ou iguais a 20
        ELSE
            '20' || TO_CHAR(ben_dt_nascimento, 'YY')  -- Século 21 para anos maiores que 20
    END AS ano_nasc,
    COUNT(*) AS total_deficientes
FROM beneficiarios
WHERE ben_deficiente_fisico = 'S'
GROUP BY 
    CASE
        WHEN TO_NUMBER(TO_CHAR(ben_dt_nascimento, 'YY')) > 20 THEN
            '19' || TO_CHAR(ben_dt_nascimento, 'YY')
        ELSE
            '20' || TO_CHAR(ben_dt_nascimento, 'YY')
    END
ORDER BY ano_nasc;

--Auditoria: Últimas alterações em beneficiários
SELECT *
FROM hbeneficiarios
WHERE hben_data_hist >= SYSDATE - 7
ORDER BY hben_data_hist DESC;

--Top 10 municípios com mais beneficiários
SELECT 
    l.loc_municipio, 
    COUNT(b.ben_id) AS total,
    ROUND((COUNT(b.ben_id) / (SELECT COUNT(*) FROM beneficiarios)) * 100, 2) AS porcentagem
FROM beneficiarios b
JOIN localizacoes l ON b.ben__loc_id = l.loc_id
GROUP BY l.loc_municipio
ORDER BY total DESC
FETCH FIRST 10 ROWS ONLY;

  
