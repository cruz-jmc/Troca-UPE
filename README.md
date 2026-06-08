# 🚀 Troca-UPE

> **Marketplace Acadêmico e Sustentável para a UPE Garanhuns**

O **Troca-UPE** é uma plataforma de marketplace exclusiva para a comunidade acadêmica da Universidade de Pernambuco (UPE). O objetivo principal é incentivar a economia circular e facilitar o acesso a materiais de estudo, permitindo que alunos possam anunciar, vender, trocar ou doar livros, jalecos, calculadoras científicas, materiais de desenho técnico e outros insumos acadêmicos entre os diversos campi (Benfica, Garanhuns, etc.).

---

## 🛠️ Escopo Técnico & Arquitetura do Banco de Dados

Para atender aos exigentes critérios de integridade e automação de sistemas de banco de dados, o projeto conta com uma arquitetura relacional robusta em **PostgreSQL**, isolada via **Docker**, integrada a uma API moderna desenvolvida em **Python (FastAPI)**.

- **Modelagem Completa:** Desenvolvimento dos modelos Conceitual (Diagrama ER), Lógico e Físico.
- **Camada de Banco de Dados:** Estrutura normalizada com chaves estrangeiras, restrições exclusivas e tipos enumerados (`ENUM`).
- **Automação Nativa (PL/pgSQL):** Uso estratégico de _Triggers_ (Gatilhos de automação pós-venda) e _Stored Procedures_ (Procedimentos armazenados para manutenção agendada).
- **Camada de Visões (Views):** Consultas agregadas e complexas encapsuladas no banco para geração instantânea de relatórios no Dashboard.
- **Camada de Aplicação:** API RESTful utilizando **FastAPI** e o driver nativo **Psycopg 3** rodando com gerenciamento seguro de transações (`COMMIT`/`ROLLBACK`).

---

## 🗂️ Principais Funcionalidades Modeladas

1. **Autenticação e Perfil:** Cadastro de usuários validado pelo e-mail institucional da UPE, incluindo curso e período.
2. **Gerenciamento de Anúncios:** Criação de ofertas categorizadas (_Livros, Vestuário, Eletrônicos, etc._) com múltiplos estados de conservação, preços ou opção de doação.
3. **Sistema de Comunicação:** Chat interno integrado para que compradores e vendedores combinem a entrega dentro do próprio campus.
4. **Histórico e Métricas:** Painel para visualização de itens doados/vendidos e economia gerada para a comunidade acadêmica.

---

## 📐 Modelagem Gráfica (Diagramas)

_Mentalidade do projeto: Os diagramas serão adicionados nesta seção assim que forem modelados no brModelo/dbdiagram._

### 🔹 Modelo Conceitual (DER)

\_![alt text](<Conceptual model - TROCAupe.png>)

### 🔹 Modelo Lógico

![alt text](<Logic model - TROCAupe.png>)

---

## 📖 Dicionário de Dados (Exemplo Inicial)

_Abaixo está a estrutura de documentação das tabelas do banco de dados._

### 1. Tabela: `campus`

| Coluna     | Tipo         | Restrição / Regra | Descrição                        |
| :--------- | :----------- | :---------------- | :------------------------------- |
| **id**     | SERIAL       | PRIMARY KEY       | Identificador único do campus    |
| **nome**   | VARCHAR(100) | NOT NULL UNIQUE   | Nome do campus                   |
| **cidade** | VARCHAR(50)  | NOT NULL          | Cidade onde o campus se localiza |

### 2. Tabela: `cursos`

| Coluna        | Tipo         | Restrição / Regra | Descrição                    |
| :------------ | :----------- | :---------------- | :--------------------------- |
| **id**        | SERIAL       | PRIMARY KEY       | Identificador único do curso |
| **nome**      | VARCHAR(100) | NOT NULL          | Nome do curso                |
| **id_campus** | INTEGER      | NOT NULL          | Identificador do campus      |

### 3. Tabela: `usuarios`

| Coluna                  | Tipo                    | Restrição / Regra        | Descrição                        |
| :---------------------- | :---------------------- | :----------------------- | :------------------------------- |
| **id**                  | SERIAL                  | PRIMARY KEY              | Identificador único do usuário   |
| **nome**                | VARCHAR(100)            | NOT NULL                 | Nome completo do estudante       |
| **email_institucional** | VARCHAR(150)            | NOT NULL UNIQUE          | E-mail institucional obrigatório |
| **telefone**            | VARCHAR(50)             | NOT NULL UNIQUE          | Telefone do estudante            |
| **periodo_atual**       | INTEGER                 | NOT NULL                 | Período acadêmico atual          |
| **status_conta**        | tipo_status_conta(ENUM) | NOT NULL DEFAULT 'Ativo' | Situação da conta                |
| **id_curso**            | INTEGER                 | NOT NULL                 | Identificador do curso           |
| **id_campus**           | INTEGER                 | NOT NULL                 | Identificador do campus          |

### 4. Tabela: `produtos`

| Coluna               | Tipo                         | Restrição / Regra                  | Descrição                         |
| :------------------- | :--------------------------- | :--------------------------------- | :-------------------------------- |
| **id**               | SERIAL                       | PRIMARY KEY                        | Identificador único do produto    |
| **nome**             | VARCHAR(100)                 | NOT NULL                           | Nome do produto                   |
| **descricao**        | TEXT                         | NOT NULL                           | Descrição do produto cadastrado   |
| **preco**            | DECIMAL(10, 2)               | NOT NULL                           | Preço do produto                  |
| **categoria**        | tipo_categoria_produto(ENUM) | NOT NULL                           | Categoria do produto              |
| **condicao**         | tipo_condicao_produto(ENUM)  | NOT NULL                           | Estado do produto                 |
| **status**           | tipo_status_produto(ENUM)    | NOT NULL DEFAULT 'Disponivel'      | Situação do produto               |
| **data_criacao**     | TIMESTAMP                    | NOT NULL DEFAULT CURRENT_TIMESTAMP | Data exata do cadastro do produto |
| **data_atualizacao** | TIMESTAMP                    | DEFAULT CURRENT_TIMESTAMP          | Data exata da atualização         |
| **id_anunciante**    | INTEGER                      | NOT NULL                           | Identificador do usuário          |

### 5. Tabela: `chats`

| Coluna             | Tipo                      | Restrição / Regra                  | Descrição                      |
| :----------------- | :------------------------ | :--------------------------------- | :----------------------------- |
| **id**             | SERIAL                    | PRIMARY KEY                        | Identificador único do chat    |
| **data_abertura**  | TIMESTAMP                 | NOT NULL DEFAULT CURRENT_TIMESTAMP | Data exata da abertura do chat |
| **id_produto**     | INTEGER                   | NOT NULL                           | Identificador do produto       |
| **status**         | tipo_status_produto(ENUM) | NOT NULL DEFAULT 'Disponivel'      | Situação do chat               |
| **id_interessado** | INTEGER                   | NOT NULL                           | Identificador do usuário       |

### 📌 Regras de Negócio Adicionais (Tabela Chats)

- **Restrição Única (1 Chat por Produto):** A combinação de `id_produto` e `id_interessado` possui uma restrição `UNIQUE`. Isso garante que um usuário interessado só possa iniciar um único chat para um mesmo produto, evitando duplicações de conversas e desorganização.
- **Exclusão em Cascata (ON DELETE CASCADE):** \* Se um **produto** for excluído do sistema, todas as conversas/chats atrelados a ele serão automaticamente apagados.
  - Se um **usuário** (interessado) deletar sua conta, todos os chats iniciados por ele também serão removidos automaticamente do banco de dados.

### 6. Tabela: `mensagens`

| Coluna           | Tipo      | Restrição / Regra                  | Descrição                         |
| :--------------- | :-------- | :--------------------------------- | :-------------------------------- |
| **id**           | SERIAL    | PRIMARY KEY                        | Identificador único da mensagem   |
| **texto**        | TEXT      | NOT NULL                           | Conteudo da mensagem              |
| **enviado_em**   | TIMESTAMP | NOT NULL DEFAULT CURRENT_TIMESTAMP | Data exatada do envio da mensagem |
| **id_chat**      | INTEGER   | NOT NULL                           | Identificador do chat             |
| **id_remetente** | INTEGER   | NOT NULL                           | Identificador do usuário          |

---

## ⚙️ Regras de Negócio Automatizadas (Triggers & Procedures)

Seção dedicada para catalogar as automações desenvolvidas diretamente no PostgreSQL.

- **`Trigger 01` (Exemplo):** Validação automática de e-mail no cadastro ou atualização de status de reputação.
- **`Procedure 01` (Exemplo):** Procedimento armazenado para gerar relatório de economia circular acumulada por curso.

---

## 📊 Visões Banco de Dados (Views)

_Seção dedicada para listar as views criadas no arquivo `views.sql` para simplificar consultas complexas e relatórios._

- **`v_metricas_economia`:** Consolida o total de itens doados/vendidos e calcula o valor estimado de economia gerada para a comunidade da UPE Garanhuns.
- **`v_anuncios_ativos`:** Lista todos os anúncios que ainda estão disponíveis (filtrando por status, curso e período do anunciante), facilitando a busca no Python.
- **`v_reputacao_usuarios`:** Exibe a média de avaliações de cada estudante para gerar o ranking de confiabilidade do marketplace.

---

## ⚙️ Guia Passo a Passo para Execução do Projeto

Siga estritamente as instruções abaixo para configurar o ambiente do banco de dados relacional e inicializar o servidor da aplicação FastAPI.

### 📋 Pré-requisitos Básicos

Antes de rodar os comandos, certifique-se de possuir instalado em seu computador:

- [Docker & Docker Compose Desktop](https://www.docker.com/)
- [Python 3.12 ou superior](https://www.python.org/)
- Git configurado no seu sistema

---

### 🗺️ Fluxo de Inicialização (Linha de Comando)

#### Passo 1: Clonar o Repositório Oficial

Abra o terminal do seu sistema operacional (ou o terminal embutido do VS Code) e faça o clone do projeto:

```bash
git clone [https://github.com/cruz-jmc/Troca-UPE.git](https://github.com/cruz-jmc/Troca-UPE.git)
cd Troca-UPE
```

#### Passo 2: Levantar a Infraestrutura do Banco de Dados (Docker)

Na raiz do projeto (onde está localizado o arquivo compose.yml), execute o comando para construir e inicializar o container do PostgreSQL em segundo plano:

```bash
docker compose up -d --build
```

#### Passo 3: Entrar no Diretório do Servidor da Aplicação

Navegue para a pasta que contém o código-fonte em Python:

```bash
cd BackEnd
```

#### Passo 4: Criar e Ativar o Ambiente Virtual (venv)

Crie um ambiente isolado para instalar as dependências do ecossistema FastAPI sem gerar conflitos globais no seu computador.

No Linux / macOS:

```bash
python3 -m venv venv
source venv/bin/activate
```

No Windows (Prompt de Comando - CMD):

```DOS
python -m venv venv
call venv\Scripts\activate
```

No Windows (PowerShell):

```PowerShell
python -m venv venv
.\venv\Scripts\activate
```

Nota: Após a ativação, a flag (venv) deve aparecer no início da linha do seu terminal.

#### Passo 5: Instalar as Dependências do Python

Com a venv ativa, atualize o gerenciador de pacotes e instale os módulos listados no arquivo requirements.txt:

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

Passo 6: Inicializar o Servidor de Aplicação (Uvicorn)

Execute o servidor de desenvolvimento apontando diretamente para o arquivo core da aplicação (src/main.py) com a flag de auto-reload ativa:

```bash
uvicorn src.main:app --reload
```

Quando o servidor subir com sucesso, o terminal exibirá as seguintes mensagens em verde:

```Plaintext

INFO: Started server process [228862]
INFO: Waiting for application startup.
INFO: Application startup complete.
INFO: Uvicorn running on [http://127.0.0.1:8000](http://127.0.0.1:8000) (Press CTRL+C to quit)
```

🕹️ Interface de Testes Interativos (Swagger UI)

A API gera automaticamente uma interface gráfica para você testar todas as operações relacionais do banco de dados de maneira visual.

    Com o terminal do Uvicorn rodando, abra seu navegador e acesse: http://127.0.0.1:8000/docs

    A documentação está segmentada em blocos modulares totalmente integrados ao Banco de Dados:

        Usuários: Cadastro e busca de perfis de estudantes vinculados a cursos e campi específicos.

        Produtos: Cadastro de desapegos e controle de estados físicos e de precificação.

        Chats & Negociações: Abertura de canais diretos entre o anunciante e o aluno interessado.

        Mensagens do Chat: Envio e persistência de históricos de conversas em tempo real.

        Dashboard & Relatórios: Consumo imediato das Views estatísticas (vw_ranking_campi_ativos, vw_demanda_por_categoria, vw_metrica_economia_comunidade, etc.).

---

## 👥 Integrantes do Projeto

    Letícia Guardiola de Abreus

    João Marcelo Cruz Coelho

Projeto desenvolvido para a disciplina de Banco de Dados — Universidade de Pernambuco (UPE).
