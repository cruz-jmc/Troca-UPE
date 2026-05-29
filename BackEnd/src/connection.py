import psycopg2
# Aqui vamos fazer a conexão com o bando de dados PostgreSQL usando a biblioteca psycopg2.
def obter_conexao():
    try:
        conexao = psycopg2.connect(
            host="localhost", #para dar certo todas essas informações tem que ser iguais as do compose.yml
            port="5432",
            database="postgres",
            user="user",
            password="password"
        )
        return conexao
    except Exception as error:
        print(f"Erro ao conectar no PostgreSQL: {error}")
        return None