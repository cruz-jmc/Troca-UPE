import psycopg2

def obter_conexao():
    try:
        conexao = psycopg2.connect(
            host="localhost",
            port="5432",
            database="postgres",
            user="user",
            password="password"
        )
        return conexao
    except Exception as error:
        print(f"Erro ao conectar no PostgreSQL: {error}")
        return None