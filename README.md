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

## 👥 Integrantes do Projeto

- **Letícia Guardiola de Abreus**
- **João Marcelo Cruz Coelho**

---

_Projeto desenvolvido para a disciplina de Banco de Dados - UPE Garanhuns._
