# Precisamos criar uma interface para rodar o banco de dados.
import psycopg2 # Biblioteca para conectar ao banco de dados PostgreSQL.

try:
    conexao = psycopg2.connect(
        host="localhost",
        port="5432",
        database="postgres",
        user="user",
        password="password"
    )
    print("Conectado ao banco de dados com sucesso!")
    
except Exception as error:
    print(f"Erro ao conectar: {error}")