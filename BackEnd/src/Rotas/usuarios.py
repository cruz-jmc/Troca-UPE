from enum import Enum
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from src.connection import obter_conexao
from psycopg.rows import dict_row

router = APIRouter(prefix="/usuarios", tags=["Usuários"])

# Espelhando o ENUM do PostgreSQL no Python.
# Isso ajuda a documentar no Swagger quais são os únicos status válidos no sistema.
class StatusContaEnum(str, Enum):
    ATIVO = "Ativo"
    INATIVO = "Inativo"
    BLOQUEADO = "Bloqueado"

# O modelo do Pydantic para o Cadastro
class UsuarioCadastro(BaseModel):
    nome: str
    email_institucional: str
    telefone: str
    periodo_atual: int
    id_curso: int
    id_campus: int

# Rota de cadastro de usuário
@router.post("")
def cadastrar_usuario(usuario: UsuarioCadastro):
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
        
    try:
        with conexao.cursor() as cursor:
            # Verificação de e-mail institucional duplicado
            cursor.execute(
                "SELECT id FROM usuarios WHERE email_institucional = %s;", 
                (usuario.email_institucional,)
            )
            if cursor.fetchone():
                raise HTTPException(status_code=400, detail="Este e-mail institucional já está cadastrado.")
            
            # Verificação de telefone duplicado
            cursor.execute(
                "SELECT id FROM usuarios WHERE telefone = %s;", 
                (usuario.telefone,)
            )
            if cursor.fetchone():
                raise HTTPException(status_code=400, detail="Este telefone já está cadastrado.")
            
            # Comando SQL - O status_conta não entra aqui pois o banco assume 'Ativo' automaticamente
            comando_sql = """
                INSERT INTO usuarios (nome, email_institucional, telefone, periodo_atual, id_curso, id_campus) 
                VALUES (%s, %s, %s, %s, %s, %s);
            """
            
            cursor.execute(comando_sql, (
                usuario.nome, 
                usuario.email_institucional, 
                usuario.telefone, 
                usuario.periodo_atual, 
                usuario.id_curso, 
                usuario.id_campus
            ))
            
            conexao.commit()
            return {"status": "sucesso", "mensagem": "Usuário cadastrado com sucesso!"}
            
    except HTTPException as http_err:
        raise http_err
    except Exception as e:
        raise HTTPException(
            status_code=500, 
            detail=f"Erro de integridade ao salvar no banco (verifique os IDs de curso/campus): {str(e)}"
        )
    finally:
        conexao.close()

# Rota de Consulta: Puxa os dados direto da nossa view criada no PostgreSQL, garantindo que o frontend receba exatamente o que precisa sem lógica extra.
@router.get("/{id_usuario}")
def obter_perfil_usuario(id_usuario: int):
    conexao = obter_conexao()
    if not conexao:
        raise HTTPException(status_code=500, detail="Erro de conexão com o banco.")
        
    try:
        with conexao.cursor(row_factory=dict_row) as cursor:
            
            comando_sql = """
                SELECT 
                    usuario_id, 
                    usuario_nome, 
                    usuario_email_institucional, 
                    usuario_periodo_atual, 
                    curso_nome, 
                    campus_nome
                FROM vw_usuarios_por_periodo
                WHERE usuario_id = %s;
            """
            
            cursor.execute(comando_sql, (id_usuario,))
            resultado = cursor.fetchone()
            
            if not resultado:
                raise HTTPException(status_code=404, detail="Usuário não encontrado nesta visão.")
                
            dados_usuario = {
                "id": resultado["usuario_id"],
                "nome": resultado["usuario_nome"],
                "email_institucional": resultado["usuario_email_institucional"],
                "periodo_atual": resultado["usuario_periodo_atual"],
                "curso": resultado["curso_nome"],
                "campus": resultado["campus_nome"]
            }
            
            return dados_usuario
            
    except HTTPException as http_err:
        raise http_err
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao consultar a View: {str(e)}")
    finally:
        conexao.close()