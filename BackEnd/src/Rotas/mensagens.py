from fastapi import APIRouter, HTTPException
from src.connection import obter_conexao
from psycopg.rows import dict_row

router = APIRouter(prefix="/mensagens", tags=["Mensagens do Chat"])

# Rota para enviar uma mensagem dentro de um chat ativo
@router.post("/")
def enviar_mensagem(id_chat: int, id_autor: int, conteudo: str):
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
    try:
        with conexao.cursor(row_factory=dict_row) as cursor:
            # Insere a mensagem atrelando ao chat e ao autor dela
            cursor.execute(
                "INSERT INTO mensagens (id_chat, id_autor, conteudo) VALUES (%s, %s, %s) RETURNING *;",
                (id_chat, id_autor, conteudo)
            )
            nova_mensagem = cursor.fetchone()
            conexao.commit()
            return {"status": "sucesso", "mensagem": "Mensagem enviada!", "dados": nova_mensagem}
    except Exception as e:
        conexao.rollback()
        raise HTTPException(status_code=500, detail=f"Erro ao enviar mensagem: {str(e)}")
    finally:
        conexao.close()