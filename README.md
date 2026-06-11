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

![alt text](<Conceptual model - TROCAupe.png>)

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
- **Exclusão em Cascata (ON DELETE CASCADE):**
  - Se um **produto** for excluído do sistema, todas as conversas/chats atrelados a ele serão automaticamente apagados.
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

Abaixo estão listadas as automações nativas em PL/pgSQL desenvolvidas diretamente no PostgreSQL para garantir a integridade dos dados e a consistência das operações comerciais:

### 🔹 Triggers (Gatilhos de Automação)

- **`tg_atualiza_data_produto`:** Executada antes de qualquer inserção ou atualização na tabela de produtos, preenchendo automaticamente o campo `data_atualizacao` com o carimbo de data/hora atual (`CURRENT_TIMESTAMP`).
- **`tg_bloqueia_mensagem_produto_vendido`:** Intercepta a inserção de novas mensagens, criando um bloqueio seguro e lançando uma exceção caso o chat pertença a um produto cujo status já esteja marcado como 'Trocado/Vendido'.
- **`tg_valida_email_institucional`:** Valida regras de negócio de acesso, disparando uma exceção se um usuário tentar se cadastrar ou atualizar seu perfil utilizando um e-mail que não pertença ao domínio oficial `@upe.br`.
- **`tg_fecha_chats_automatico`:** Monitora o status dos produtos. Assim que um item muda para 'Trocado/Vendido', este gatilho atualiza automaticamente o status de todos os chats abertos vinculados àquele anúncio para 'Fechado'.
- **`tg_impede_auto_chat`:** Garante a lógica de negócio básica impedindo que o anunciante/proprietário do produto abra um chat de interesse com ele mesmo.
- **`tg_valida_periodo_upe`:** Restringe a inserção de dados numéricos inválidos, garantindo que o período letivo atual cadastrado para o estudante esteja estritamente no intervalo entre 1 e 12.

### 🔹 Procedures (Procedimentos Armazenados)

- **`proc_concluir_negociacao`:** Gerencia de forma segura o encerramento de um ciclo de venda. Altera o status do produto alvo para 'Trocado/Vendido' e executa o `COMMIT` explícito para efetivar as alterações na transação do banco.
- **`proc_limpar_anuncios_antigos`:** Rotina programada para manutenção de catálogo. Varre a tabela de produtos e altera o status para 'inativo' de todas as ofertas que estejam disponíveis há mais de 180 dias sem movimentação.

---

## 📊 Visões Banco de Dados (Views)

As seguintes visões foram criadas para otimizar o desempenho do sistema, encapsulando consultas complexas e junções relacionais para consumo direto no ecossistema Python/FastAPI:

- **`vw_produtos_disponiveis`:** Facilita a listagem na tela inicial (Vitrine), trazendo em uma única consulta os dados do produto, as informações do anunciante, seu curso e o campus correspondente.
- **`vw_usuarios_por_periodo`:** Agrupa os estudantes e seus dados de contato relacionando-os por curso, campus e período letivo numérico ativo.
- **`vw_ranking_campi_ativos`:** Gera métricas estatísticas gerenciais, contabilizando e ordenando de forma decrescente os campi com maior volume de ofertas disponíveis.
- **`vw_ultimos_anuncios`:** Filtra de forma rápida e dinâmica apenas os itens cadastrados ou atualizados nas últimas 24 horas que ainda estão com status ativo.
- **`vw_demanda_por_categoria`:** Consolida dados de mercado do ecossistema, quantificando o volume de produtos por segmento e calculando o preço médio praticado em cada categoria.
- **`vw_historico_conversa`:** Mapeia a correlação dos chats ativos no banco de dados, vinculando o produto em negociação e os nomes reais tanto do vendedor quanto do comprador.
- **`vw_usuarios_bloqueados`:** Centraliza a consulta a perfis restritos no sistema pelo status de conta, facilitando o gerenciamento e a segurança da comunidade.
- **`vw_metrica_economia_comunidade`:** Calcula o impacto real da plataforma na comunidade acadêmica, somando o montante financeiro economizado através de negociações finalizadas.

---

## ⚙️ Guia Passo a Passo para Execução do Projeto

Siga estritamente as instruções abaixo para configurar o ambiente do banco de dados relacional e inicializar o servidor da aplicação FastAPI.

### 📋 Pré-requisitos Básicos

Antes de rodar os comandos, certifique-se de possuir instalado em seu computador:

- [Docker & Docker Compose Desktop](https://www.docker.com/)
- [Python 3.12 ou superior](https://www.python.org/)
- Extensão **Live Server** instalada no VS Code
- Git configurado no seu sistema

---

### 🗺️ Fluxo de Inicialização (Linha de Comando)

#### Passo 1: Clonar o Repositório Oficial

Abra o terminal do seu sistema operacional (ou o terminal embutido do VS Code) e faça o clone do projeto:

````bash
git clone https://github.com/cruz-jmc/Troca-UPE.git
cd Troca-UPE

### 🗺️ Fluxo de Inicialização (Linha de Comando)

#### Passo 1: Clonar o Repositório Oficial

Abra o terminal do seu sistema operacional (ou o terminal embutido do VS Code) e faça o clone do projeto:

```bash
git clone [https://github.com/cruz-jmc/Troca-UPE.git](https://github.com/cruz-jmc/Troca-UPE.git)
cd Troca-UPE
````

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

### 🕹️ Interface de Testes Interativos (Swagger UI)

A API gera automaticamente uma interface gráfica para você testar todas as operações relacionais do banco de dados de maneira visual.

    Com o terminal do Uvicorn rodando, abra seu navegador e acesse: http://127.0.0.1:8000/docs

    A documentação está segmentada em blocos modulares totalmente integrados ao Banco de Dados:

        Usuários: Cadastro e busca de perfis de estudantes vinculados a cursos e campi específicos.

        Produtos: Cadastro de desapegos e controle de estados físicos e de precificação.

        Chats & Negociações: Abertura de canais diretos entre o anunciante e o aluno interessado.

        Mensagens do Chat: Envio e persistência de históricos de conversas em tempo real.

        Dashboard & Relatórios: Consumo imediato das Views estatísticas (vw_ranking_campi_ativos, vw_demanda_por_categoria, vw_metrica_economia_comunidade, etc.).

---

### 💻 Executando e Testando o Frontend

A interface gráfica consome as rotas da API local em tempo real. Para rodar e testar o site de forma simples:

1. **Abrir o site:** Abra a pasta do projeto no **VS Code**, clique com o botão direito no arquivo `index.html` e selecione **"Open with Live Server"**. O site abrirá no navegador.
2. **Cadastrar um Produto:** Na Vitrine, defina o seu **ID de Vendedor** no topo e cadastre um item. O card surgirá na tela mostrando o **Anúncio ID** em ordem sequencial (1, 2, 3...).
3. **Iniciar o Chat:** Clique no botão **`🤝 Interesse`** em qualquer produto da vitrine.
4. **Conectar os IDs:** Uma caixinha na tela perguntará o seu **ID de Comprador**. Digite um número e confirme. Você será levado direto para a sala de chat (`chat.html`) com todos os IDs conectados automaticamente.

---

## Autores

- **João Marcelo Cruz Coelho** - [Seu GitHub](https://github.com/cruz-jmc)
- **Letícia Guardiola de Abreus** - [GitHub do Coautor](https://github.com/leticiaguardiolaabreus-gif)

## Licença

Este projeto está sob a licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

Projeto desenvolvido para a disciplina de Banco de Dados — Universidade de Pernambuco (UPE).
