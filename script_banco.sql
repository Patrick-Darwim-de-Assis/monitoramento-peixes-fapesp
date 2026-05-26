/*-- Tabela Pai 1: Peixes*/
CREATE TABLE peixes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_popular VARCHAR(50) NOT NULL,
    nome_cientifico VARCHAR(100) NOT NULL,
    status_extincao VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

/*-- Tabela Pai 2: Pontos de Amostragem (Localidades)*/
CREATE TABLE pontos_amostragem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    localidade VARCHAR(100) NOT NULL,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6)
) ENGINE=InnoDB;

/*-- Tabela Filha: Registros de Captura (Depende de Peixes e Pontos)*/
/*-- O MySQL cria os índices para as FKs automaticamente aqui.*/
CREATE TABLE registros_captura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    peixe_id INT,
    ponto_id INT,
    peso_gramas DECIMAL(6,2),
    comprimento_cm DECIMAL(4,1),
    temperatura_agua DECIMAL(3,1),
    data_coleta DATE,
    CONSTRAINT fk_registros_peixes 
        FOREIGN KEY (peixe_id) REFERENCES peixes(id) 
        ON DELETE RESTRICT,
    CONSTRAINT fk_registros_pontos 
        FOREIGN KEY (ponto_id) REFERENCES pontos_amostragem(id) 
        ON DELETE RESTRICT
) ENGINE=InnoDB;


-- =====================================================================
-- 3. INSERÇÃO DE DADOS DE TESTE (População do Banco)
-- =====================================================================

-- Inserindo Peixes
INSERT INTO peixes (nome_popular, nome_cientifico, status_extincao) VALUES 
('Cascudo', 'Hypostomus punctatus', 'Preocupação menor'),
('Cambeva', 'Trichomycterus iheringi', 'Vulnerável'),
('Lambari', 'Astyanax bimaculatus', 'Preocupação menor');

-- Inserindo Pontos de Amostragem
INSERT INTO pontos_amostragem (localidade, latitude, longitude) VALUES 
('Ribeirão Grande - Montante', -22.854100, -45.223400),
('Córrego do Cedro - Jusante', -22.861200, -45.210500);

-- Inserindo Registros de Captura
INSERT INTO registros_captura (peixe_id, ponto_id, peso_gramas, comprimento_cm, temperatura_agua, data_coleta) VALUES 
(1, 1, 150.50, 18.2, 21.5, '2026-05-20'),
(2, 1, 45.20, 8.5, 19.2, '2026-05-21'),
(3, 2, 25.00, 6.1, 22.0, '2026-05-21');


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
