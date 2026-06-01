# 🚀 Troca-UPE

> **Marketplace Acadêmico e Sustentável para a UPE Garanhuns**

O **UPE-Troca** é uma plataforma de marketplace exclusiva para a comunidade acadêmica da Universidade de Pernambuco (UPE) - Campus Garanhuns. O objetivo principal é incentivar a economia circular e facilitar o acesso a materiais de estudo, permitindo que alunos (especialmente veteranos e calouros) possam anunciar, vender, trocar ou doar livros, jalecos, calculadoras científicas, materiais de desenho técnico e outros insumos acadêmicos.

---

## 🛠️ Escopo Técnico & Arquitetura do Banco de Dados

Para atender aos critérios da disciplina, o sistema contará com um banco de dados relacional robusto (PostgreSQL via Docker) e totalmente normalizado, além de implementar regras de negócio automatizadas diretamente no banco.

- **Modelagem Completa:** Desenvolvimento dos modelos Conceitual (Diagrama ER), Lógico e Físico.
- **Camada de Banco de Dados:** Mínimo de 20 tabelas e/ou views.
- **Automação:** Uso estratégico de _Triggers_ (Gatilhos para automação e validação) e _Stored Procedures_ (Procedimentos armazenados para consultas complexas e relatórios).
- **População de Dados:** _Seeders_ dedicados para popular o banco com dados de teste realistas.
- **Camada de Aplicação:** Integração do banco de dados com testes funcionais utilizando **Python** para comunicação direta com o banco.

---

## 🗂️ Principais Funcionalidades Modeladas

1. **Autenticação e Perfil:** Cadastro de usuários validado pelo e-mail institucional da UPE, incluindo curso e período.
2. **Gerenciamento de Anúncios:** Criação de ofertas categorizadas (_Livros, Vestuário, Eletrônicos, etc._) com múltiplos estados de conservação, preços ou opção de doação.
3. **Sistema de Comunicação:** Chat interno integrado para que compradores e vendedores combinem a entrega dentro do próprio campus.
4. **Sistema de Avaliações:** Sistema de reputação para garantir a segurança e confiabilidade nas transações entre os estudantes.
5. **Histórico e Métricas:** Painel para visualização de itens doados/vendidos e economia gerada para a comunidade acadêmica.

---

## 📐 Modelagem Gráfica (Diagramas)

_Mentalidade do projeto: Os diagramas serão adicionados nesta seção assim que forem modelados no brModelo/dbdiagram._

### 🔹 Modelo Conceitual (DER)

_![alt text](<Conceptual model - TROCAupe.png>)

### 🔹 Modelo Lógico

![alt text](<Logic model - TROCAupe.png>)

---

## 📖 Dicionário de Dados (Exemplo Inicial)

_Abaixo está a estrutura de documentação das tabelas do banco de dados._

### 1. Tabela: `campus`

| Coluna      | Tipo         | Restrição / Regra                       | Descrição                        |
| :---------- | :----------- | :-------------------------------------  | :------------------------------- |
| **id**      | SERIAL       | PRIMARY KEY                             | Identificador único do campus    |
| **nome**    | VARCHAR(100) | NOT NULL UNIQUE                         | Nome do campus                   |
| **cidade**  | VARCHAR(50)  | NOT NULL                                | Cidade onde o campus se localiza |

### 2. Tabela: `cursos`

| Coluna        | Tipo         | Restrição / Regra                      | Descrição                        |
| :----------   | :----------- | :------------------------------------- | :--------------------------------|
| **id**        | SERIAL       | PRIMARY KEY                            | Identificador único do curso     |
| **nome**      | VARCHAR(100) | NOT NULL                               | Nome do curso                    |
| **id_campus** | INTEGER      | NOT NULL                               | Identificador do campus          |

### 3. Tabela: `usuarios`

| Coluna                 | Tipo                   | Restrição / Regra                      | Descrição                        |
| :----------------------| :----------------------| :------------------------------------- | :--------------------------------|
| **id**                 | SERIAL                 | PRIMARY KEY                            | Identificador único do usuário   |
| **nome**               | VARCHAR(100)           | NOT NULL                               | Nome completo do estudante       |
| **email_institucional**| VARCHAR(150)           | NOT NULL UNIQUE                        | E-mail institucional obrigatório |
| **telefone**           | VARCHAR(50)            | NOT NULL UNIQUE                        | telefone do estudante            |
| **periodo_atual**      | INTEGER                | NOT NULL                               | Período acadêmico atual          |
| **status_conta**       | tipo_status_conta(ENUM)| NOT NULL DEFAULT 'Ativo'               | Situação da conta                |
| **id_curso**           | INTEGER                | NOT NULL                               | Identificador do curso           |
| **id_campus**          | INTEGER                | NOT NULL                               | Identificador  do campus         |

### 4. Tabela: `produtos`

| Coluna              | Tipo                        | Restrição / Regra                      | Descrição                        |
| :-------------------| :---------------------------| :------------------------------------- | :------------------------------- |
| **id**              | SERIAL                      | PRIMARY KEY                            | Identificador único do produto   |
| **nome**            | VARCHAR(100)                | NOT NULL                               | Nome do produto                  |
| **descricao**       | TEXT                        | NOT NULL                               | Descrição do produto cadastrado  |
| **preco**           | DECIMAL(10, 2)              | NOT NULL                               | Preço do produto                 |
| **categoria**       | tipo_categoria_produto(ENUM)| NOT NULL                               | Categoria do produto             |
| **condicao**        | tipo_condicao_produto(ENUM) | NOT NULL                               | Estado do produto                |
| **status**          | tipo_status_produto(ENUM)   | NOT NULL DEFAULT 'Disponivel'          | Situação do produto              |
| **data_criacao**    | TIMESTAMP                   | NOT NULL DEFAULT CURRENT_TIMESTAMP     | Data exata do cadastro do produto|
| **data_atualizacao**| TIMESTAMP                   | DEFAULT CURRENT_TIMESTAMP              | Data exsta da atualização        |
| **id_anunciante**   | INTEGER                     | NOT NULL                               | Identificador do usuário         |


### 5. Tabela: `chats`

| Coluna            | Tipo         | Restrição / Regra                      | Descrição                        |
| :-----------------| :----------- | :------------------------------------- | :------------------------------- |
| **id**            | SERIAL       | PRIMARY KEY                            | Identificador único do chat      |
| **data_abertura** | TIMESTAMP    | NOT NULL DEFAULT CURRENT_TIMESTAMP     | Data exata da abertura do chat   |
| **id_produto**    | INTEGER      | NOT NULL                               | Identificador do produto         |
| **id_interessado**| INTEGER      | NOT NULL                               | Identificador do usuário         |

### 📌 Regras de Negócio Adicionais (Tabela Chats)

* **Restrição Única (1 Chat por Produto):** A combinação de `id_produto` e `id_interessado` possui uma restrição `UNIQUE`. Isso garante que um usuário interessado só possa iniciar um único chat para um mesmo produto, evitando duplicações de conversas e desorganização.
* **Exclusão em Cascata (ON DELETE CASCADE):** * Se um **produto** for excluído do sistema, todas as conversas/chats atrelados a ele serão automaticamente apagados.
  * Se um **usuário** (interessado) deletar sua conta, todos os chats iniciados por ele também serão removidos automaticamente do banco de dados.

### 6. Tabela: `mensagens`

| Coluna          | Tipo         | Restrição / Regra                      | Descrição                        |
| :---------------| :----------- | :------------------------------------- | :------------------------------- |
| **id**          | SERIAL       | PRIMARY KEY                            | Identificador único da mensagem  |
| **texto**       | TEXT         | NOT NULL                               | Conteudo da mensagem             |
| **enviado_em**  | TIMESTAMP    | NOT NULL DEFAULT CURRENT_TIMESTAMP     | Data exatada do envio da mensagem|
| **id_chat**     | INTEGER      | NOT NULL                               | Identificador do chat            |
| **id_remetente**| INTEGER      | NOT NULL                               | Identificador do usuário         |

---

## ⚙️ Regras de Negócio Automatizadas (Triggers & Procedures)

Seção dedicada para catalogar as automações desenvolvidas diretamente no PostgreSQL.

- **`Trigger 01` (Exemplo):** Validação automática de e-mail no cadastro ou atualização de status de reputação.
- **`Procedure 01` (Exemplo):** Procedimento armazenado para gerar relatório de economia circular acumulada por curso.

---

## 📊 Visões Banco de Dados (Views)

_Seção dedicada para listar as views criadas no arquivo `Views.sql` para simplificar consultas complexas e relatórios._

- **`v_metricas_economia`:** Consolida o total de itens doados/vendidos e calcula o valor estimado de economia gerada para a comunidade da UPE Garanhuns.
- **`v_anuncios_ativos`:** Lista todos os anúncios que ainda estão disponíveis (filtrando por status, curso e período do anunciante), facilitando a busca no Python.
- **`v_reputacao_usuarios`:** Exibe a média de avaliações de cada estudante para gerar o ranking de confiabilidade do marketplace.

---

## 🚀 Como Executar o Projeto

Esta seção orienta como configurar e rodar o ambiente de desenvolvimento local (Banco de Dados + Aplicação).

### 📋 Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina:

- [Docker & Docker Compose](https://www.docker.com/)
- [Python 3.x](https://www.python.org/)

### 🛠️ Passo a Passo

1. **Clonar o repositório:**
   ```bash
   git clone [https://github.com/cruz-jmc/ProjetoDB_JM_Leh.git](https://github.com/cruz-jmc/ProjetoDB_JM_Leh.git)
   cd ProjetoDB_JM_Leh
   ```

---

## 👥 Integrantes do Projeto

- **Letícia Guardiola de Abreus**
- **João Marcelo Cruz Coelho**

---

_Projeto desenvolvido para a disciplina de Banco de Dados - UPE Garanhuns._