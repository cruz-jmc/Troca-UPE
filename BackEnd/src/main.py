from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.Rotas import usuarios
from src.Rotas import produtos
from src.Rotas import dashboard
from src.Rotas import chats
from src.Rotas import mensagens 

app = FastAPI(title="Troca-UPE API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],  
    allow_headers=["*"],  
)

app.include_router(usuarios.router)
app.include_router(produtos.router)
app.include_router(dashboard.router)
app.include_router(chats.router)
app.include_router(mensagens.router)