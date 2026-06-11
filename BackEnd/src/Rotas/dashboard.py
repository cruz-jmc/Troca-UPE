from fastapi import APIRouter, HTTPException
from src.connection import obter_conexao
from psycopg.rows import dict_row

router = APIRouter(prefix="/dashboard", tags=["Dashboard & Relatórios"])

# 03_vw_ranking_campi_ativos.sql:
@router.get("/ranking-campi-ativos")
def obter_ranking_campi():
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        # Configura o cursor para retornar os dados como dicionários (JSON)
        with conexao.cursor(row_factory=dict_row) as cursor:
            cursor.execute("SELECT * FROM vw_ranking_campi_ativos;")
            ranking = cursor.fetchall()
            return ranking
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao consultar o ranking de campi ativos: {str(e)}")
    finally:
        conexao.close()

# 05_demanda_categorias.sql:
@router.get("/demanda-categorias")
def obter_demanda_categorias():
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        with conexao.cursor(row_factory=dict_row) as cursor:
            cursor.execute("SELECT * FROM vw_demanda_por_categoria;")
            demanda = cursor.fetchall()
            return demanda
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao consultar as demandas por categoria: {str(e)}")
    finally:
        conexao.close()

# 06_historico_compra.sql:
@router.get("/historico-conversas")
def obter_historico_conversas():
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        with conexao.cursor(row_factory=dict_row) as cursor:
            cursor.execute("SELECT * FROM vw_historico_conversa;")
            historico = cursor.fetchall()
            return historico
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao consultar o histórico de conversas: {str(e)}")
    finally:
        conexao.close()

# 07_usuarios_bloqueados.sql:
@router.get("/usuarios-bloqueados")
def obter_usuarios_bloqueados():
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        with conexao.cursor(row_factory=dict_row) as cursor:
            cursor.execute("SELECT * FROM vw_usuarios_bloqueados;")
            bloqueados = cursor.fetchall()
            return bloqueados
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao consultar os usuários bloqueados: {str(e)}")
    finally:
        conexao.close()

# vw_metrica_economia_comunidade.sql:
@router.get("/economia-comunidade")
def obter_economia_comunidade():
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        with conexao.cursor(row_factory=dict_row) as cursor:
            cursor.execute("SELECT * FROM vw_metrica_economia_comunidade;")
            # Como essa view sempre retorna apenas uma linha com os totais,
            # usamos o fetchone() para entregar um objeto direto em vez de uma lista
            economia = cursor.fetchone()
            return economia
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao consultar a métrica de economia da comunidade: {str(e)}")
    finally:
        conexao.close()