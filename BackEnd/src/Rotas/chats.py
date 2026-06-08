from fastapi import APIRouter, HTTPException
from src.connection import obter_conexao
from psycopg.rows import dict_row

router = APIRouter(prefix="/chats", tags=["Chats & Negociações"])

# Rota para iniciar uma conversa sobre um produto
@router.post("/")
def criar_chat(id_produto: int, id_interessado: int):
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        with conexao.cursor(row_factory=dict_row) as cursor:
            # Insere um novo chat ligando o produto ao comprador interessado
            cursor.execute(
                "INSERT INTO chats (id_produto, id_interessado) VALUES (%s, %s) RETURNING *;",
                (id_produto, id_interessado)
            )
            novo_chat = cursor.fetchone()
            conexao.commit()
            return {"status": "sucesso", "mensagem": "Chat iniciado com sucesso!", "dados": novo_chat}
    except Exception as e:
        conexao.rollback()
        raise HTTPException(status_code=500, detail=f"Erro ao iniciar chat: {str(e)}")
    finally:
        conexao.close()