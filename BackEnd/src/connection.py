import psycopg
from psycopg.rows import dict_row
# Aqui vamos fazer a conexão com o bando de dados PostgreSQL usando a biblioteca psycopg2.
def obter_conexao():
    try:
        conexao = psycopg.connect(
            host="localhost", #para dar certo todas essas informações tem que ser iguais as do compose.yml
            port="5432",
            dbname="db_troca_upe",
            user="user",
            password="password",
            row_factory=dict_row # Isso faz com que os resultados sejam retornados como dicionários, facilitando o acesso aos dados por nome de coluna.
        )
        return conexao
    except Exception as error:
        print(f"Erro ao conectar no PostgreSQL: {error}")
        return None