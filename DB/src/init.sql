-- Esse arquivo serve para mapearmos a execução dos scripts SQL que queremos que rode na inicialização do container, garantindo que as tabelas, views, triggers e procedures sejam criadas na ordem correta, evitando erros de dependência (Foreign Key).

-- 📁 01. CRIAÇÃO DAS TABELAS (Ordem correta para evitar erro de Foreign Key)
\i /docker-entrypoint-initdb.d/01_Tabelas/01_campus.sql
\i /docker-entrypoint-initdb.d/01_Tabelas/02_cursos.sql
\i /docker-entrypoint-initdb.d/01_Tabelas/03_usuarios.sql
\i /docker-entrypoint-initdb.d/01_Tabelas/04_produtos.sql
\i /docker-entrypoint-initdb.d/01_Tabelas/05_chats.sql
\i /docker-entrypoint-initdb.d/01_Tabelas/06_mensagens.sql

-- 📁 02. CRIAÇÃO DAS VIEWS
\i /docker-entrypoint-initdb.d/02_Views/01_vw_produtos_disponiveis.sql
\i /docker-entrypoint-initdb.d/02_Views/02_vw_usuarios_por_periodo.sql
\i /docker-entrypoint-initdb.d/02_Views/03_vw_ranking_campi_ativos.sql
\i /docker-entrypoint-initdb.d/02_Views/04_ultimos_anuncios.sql
\i /docker-entrypoint-initdb.d/02_Views/05_demanda_categorias.sql
\i /docker-entrypoint-initdb.d/02_Views/06_historico_compra.sql
\i /docker-entrypoint-initdb.d/02_Views/07_usuarios_bloqueados.sql
\i /docker-entrypoint-initdb.d/02_Views/08_vw_metrica_economia_comunidade.sql

-- 📁 03. CRIAÇÃO DOS GATILHOS (TRIGGERS)
\i /docker-entrypoint-initdb.d/03_Triggers/01_trigger_atualiza_produto.sql
\i /docker-entrypoint-initdb.d/03_Triggers/02_tg_trava_chat_vendido.sql
\i /docker-entrypoint-initdb.d/03_Triggers/03_tg_valida_email.sql
\i /docker-entrypoint-initdb.d/03_Triggers/04_tg_fecha_chats_automatico.sql
\i /docker-entrypoint-initdb.d/03_Triggers/05_tg_impede_auto_chat.sql
\i /docker-entrypoint-initdb.d/03_Triggers/06_tg_limita_periodo.sql

-- 📁 04. CRIAÇÃO DAS PROCEDURES
\i /docker-entrypoint-initdb.d/04_Procedures/01_proc_concluir_negociacao.sql
\i /docker-entrypoint-initdb.d/04_Procedures/02_proc_limpar_anuncios_antigos.sql

-- Inserção de dados obrigatórios para testes e funcionamento do sistema
\i /docker-entrypoint-initdb.d/05_Dados_ficticios_teste/01_insets_campus.sql
\i /docker-entrypoint-initdb.d/05_Dados_ficticios_teste/02_inserts_cursos.sql