from fastapi import APIRouter, HTTPException, Query
from pydantic import BaseModel
from typing import Literal, Optional
from src.connection import obter_conexao
from psycopg.rows import dict_row

router = APIRouter(prefix="/produtos", tags=["Produtos"])

class ProdutoCadastro(BaseModel):
    nome: str
    descricao: str
    preco: float
    
    categoria: Literal['Livros', 'Eletrodomesticos', 'Moveis', 'Material Escolar', 'Outros']
    
    condicao: Literal['Novo', 'Semi-novo', 'Usado (Otimo Estado)', 'Usado (Marcas de Uso)', 'Inativo']
    
    id_anunciante: int  # FK para o usuário que está anunciando o produto

@router.post("/")
def cadastrar_produto(produto: ProdutoCadastro):
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
        
    try:
        with conexao.cursor(row_factory=dict_row) as cursor:
            # Deixamos o 'status' de fora porque ele assume o default 'Disponivel' automaticamente
            comando_sql = """
                INSERT INTO produtos (nome, descricao, preco, categoria, condicao, id_anunciante)
                VALUES (%s, %s, %s, %s, %s, %s)
                RETURNING id;
            """
            
            cursor.execute(comando_sql, (
                produto.nome,
                produto.descricao,
                produto.preco,
                produto.categoria,
                produto.condicao,
                produto.id_anunciante
            ))
            
            conexao.commit()
            
            id_gerado = cursor.fetchone()
            
            return {
                "status": "sucesso",
                "mensagem": "Produto anunciado com sucesso!",
                "id_produto": id_gerado["id"]
            }
            
    except Exception as e:
        conexao.rollback()
        # Caso tente usar um id_anunciante que não existe, o banco vai barrar aqui na FK
        raise HTTPException(status_code=500, detail=f"Erro ao salvar produto no banco: {str(e)}")
    finally:
        conexao.close()

# ROTA DO FEED PRINCIPAL (GET /produtos) - Usa vw_produtos_disponiveis
@router.get("/")
def listar_produtos_disponiveis(
    categoria: Optional[Literal['Livros', 'Eletrodomesticos', 'Moveis', 'Material Escolar', 'Outros']] = Query(None, description="Filtre o feed por uma categoria específica")
):
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        with conexao.cursor(row_factory=dict_row) as cursor:
            comando_sql = """
                SELECT 
                    produto_id, produto_nome, produto_descricao, produto_preco, 
                    produto_categoria, produto_condicao, produto_data_criacao, 
                    anunciante_nome, campus_nome, curso_nome
                FROM vw_produtos_disponiveis
            """
            parametros = []
            
            if categoria:
                comando_sql += " WHERE produto_categoria = %s"
                parametros.append(categoria)
                
            comando_sql += ";"
            
            cursor.execute(comando_sql, parametros)
            produtos = cursor.fetchall()
            return produtos
            
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao consultar os produtos disponíveis: {str(e)}")
    finally:
        conexao.close()


# ROTA DE NOVIDADES (GET /produtos/recentes) - Usa vw_ultimos_anuncios
@router.get("/recentes")
def listar_ultimos_anuncios_24h():
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        with conexao.cursor(row_factory=dict_row) as cursor:
            comando_sql = """
                SELECT id, nome, descricao, preco, categoria, condicao, status, data_criacao
                FROM vw_ultimos_anuncios;
            """
            cursor.execute(comando_sql)
            anuncios_recentes = cursor.fetchall()
            return anuncios_recentes if anuncios_recentes else []
            
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao consultar os anúncios recentes: {str(e)}")
    finally:
        conexao.close()

# Aqui está a rota PATCH para concluir a negociação, que chama a 01_proc_concluir_negociacao.sql
@router.patch("/{id_produto}/concluir")
def concluir_negociacao(id_produto: int):
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        conexao.autocommit = True
        
        with conexao.cursor() as cursor:
            cursor.execute("CALL proc_concluir_negociacao(%s);", (id_produto,))
            return {
                "status": "sucesso",
                "mensagem": f"Negociação do produto {id_produto} concluída e retirada do catálogo!"
            }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao executar concluir negociação: {str(e)}")
    finally:
        conexao.close()

# ROTA PARA LIMPAR ANÚNCIOS ANTIGOS (POST /produtos/limpar-antigos) - Chama a 02_proc_limpar_anuncios_antigos.sql
@router.post("/limpar-antigos")
def limpar_anuncios_antigos():
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        conexao.autocommit = True
        
        with conexao.cursor() as cursor:
            cursor.execute("CALL proc_limpar_anuncios_antigos();")
            return {
                "status": "sucesso",
                "mensagem": "Limpeza de anúncios com mais de 180 dias executada com sucesso!"
            }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao executar a limpeza: {str(e)}")
    finally:
        conexao.close()