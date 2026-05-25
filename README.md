# Sistema de Monitoramento de Espécies (FAPESP)

Este repositório apresenta a modelagem física, persistência e consulta de dados para o monitoramento de peixes e variáveis ambientais, utilizando um banco de dados relacional hospedado na nuvem.

## 🚀 Como testar e consultar este banco do seu computador

O banco de dados está ativo e hospedado em um cluster na nuvem através do **Aiven.io**. Você pode se conectar a ele diretamente utilizando qualquer client SQL (como DBeaver ou MySQL Workbench) usando as credenciais abaixo:

* **SGBD:** MySQL 8
* **Host (Host/IP):** mysql-fapesp-peixes-patrickdarwimdeassis-123.b.aivencloud.com
* **Port (Porta):** 26590
* **Database (Banco de dados):** defaultdb
* **Username (Usuário):** avnadmin
* **Password (Senha):** AVNS_JrhdDoABd7ttlyV6oiA

---

## 📊 Estrutura das Tabelas

![Diagrama do Banco de Dados](Dados%20Captura%20de%20Peixes.png)

O modelo foi normalizado para garantir a integridade referencial através de Chaves Estrangeiras (com restrição `ON DELETE RESTRICT`), estruturando-se em:

1. **`peixes`**: Dados taxonômicos e status de conservação (ex: vulnerável).
2. **`pontos_amostragem`**: Localidades geográficas das coletas.
3. **`registros_captura`**: Dados métricos de campo e variáveis climáticas (temperatura da água).
