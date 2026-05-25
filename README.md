# 🚀 UPE-Troca

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

_Espaço reservado para o Diagrama Entidade-Relacionamento._

### 🔹 Modelo Lógico / Físico

_Espaço reservado para o diagrama das tabelas e chaves (PK/FK)._

---

## 📖 Dicionário de Dados (Exemplo Inicial)

_Abaixo está a estrutura de documentação das tabelas do banco de dados (mínimo de 20 tabelas)._

### 1. Tabela: `usuario`

| Coluna      | Tipo         | Restrição / Regra                      | Descrição                        |
| :---------- | :----------- | :------------------------------------- | :------------------------------- |
| **id**      | SERIAL       | PRIMARY KEY                            | Identificador único do usuário   |
| **nome**    | VARCHAR(100) | NOT NULL                               | Nome completo do estudante       |
| **email**   | VARCHAR(100) | UNIQUE / CHECK (email LIKE '%@upe.br') | E-mail institucional obrigatório |
| **curso**   | VARCHAR(50)  | NOT NULL                               | Curso atual do estudante         |
| **periodo** | INT          | CHECK (periodo BETWEEN 1 AND 12)       | Período acadêmico atual          |

_(Demais tabelas serão documentadas aqui conforme o desenvolvimento do script `Tabelas.sql`)_

---

## ⚙️ Regras de Negócio Automatizadas (Triggers & Procedures)

Seção dedicada para catalogar as automações desenvolvidas diretamente no PostgreSQL.

- \*\*`Trigger 01
