-- 1. Tabela de Espécies de Peixes
CREATE TABLE peixes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_cientifico VARCHAR(100) NOT NULL,
    nome_popular VARCHAR(50),
    status_extincao VARCHAR(30) DEFAULT 'Pouco Preocupante'
);

-- 2. Tabela de Pontos Geográficos de Amostragem (Mudanças Climáticas)
CREATE TABLE pontos_amostragem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    localidade VARCHAR(100) NOT NULL,
    bacia_hidrografica VARCHAR(100),
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL
);

-- 3. Tabela Relacional de Capturas e Variáveis Ambientais
CREATE TABLE registros_captura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    peixe_id INT,
    ponto_id INT,
    data_coleta DATE NOT NULL,
    temperatura_agua DECIMAL(4,2), -- Crucial para checar aquecimento global
    ph_agua DECIMAL(3,1),
    oxigenio_dissolvido DECIMAL(4,2),
    FOREIGN KEY (peixe_id) REFERENCES peixes(id) ON DELETE CASCADE,
    FOREIGN KEY (ponto_id) REFERENCES pontos_amostragem(id) ON DELETE CASCADE
);

-- INSERÇÃO DE DADOS PARA TESTE (População do banco)
INSERT INTO peixes (nome_cientifico, nome_popular, status_extincao) VALUES
('Astyanax bimaculatus', 'Lambari-do-rabo-amarelo', 'Pouco Preocupante'),
('Glandulocauda melanogenys', 'Cambeva', 'Vulnerável'),
('Phalloptychus januarius', 'Barrigudinho', 'Pouco Preocupante');

INSERT INTO pontos_amostragem (localidade, bacia_hidrografica, latitude, longitude) VALUES
('Rio Paraíba do Sul - Trecho Guaratinguetá', 'Bacia do Paraíba do Sul', -22.8139, -45.1925),
('Ribeirão Grande - Pindamonhangaba', 'Bacia do Paraíba do Sul', -22.9254, -45.4611);

INSERT INTO registros_captura (peixe_id, ponto_id, data_coleta, temperatura_agua, ph_agua, oxigenio_dissolvido) VALUES
(1, 1, '2026-05-15', 24.5, 6.8, 5.2),
(2, 2, '2026-05-16', 19.2, 6.5, 7.1), -- Água mais fria de altitude
(3, 1, '2026-05-17', 26.1, 7.2, 4.8); -- Temperatura elevada registrada


-- =====================================================================
-- 4. CONSULTA DEMONSTRATIVA COM JOIN (Ajustada para os dados aparecerem)
-- =====================================================================
SELECT 
    p.nome_popular, 
    p.nome_cientifico, 
    p.status_extincao,
    r.temperatura_agua, 
    pa.localidade
FROM registros_captura r
JOIN peixes p ON r.peixe_id = p.id
JOIN pontos_amostragem pa ON r.ponto_id = pa.id
WHERE r.temperatura_agua > 15.0 AND p.status_extincao = 'Vulnerável';
