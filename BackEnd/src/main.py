from fastapi import FastAPI
from src.Rotas import usuarios
from src.Rotas import produtos
from src.Rotas import dashboard
from src.Rotas import chats
from src.Rotas import mensagens # Importa o arquivo de rotas que acabamos de criar

app = FastAPI(title="Troca-UPE API")

# Conecta todas as rotas na nossa aplicação principal
app.include_router(usuarios.router)
app.include_router(produtos.router)
app.include_router(dashboard.router)
app.include_router(chats.router)
app.include_router(mensagens.router)