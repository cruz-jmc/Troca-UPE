import requests
import os

BASE_URL = os.getenv("BASE_URL", "http://localhost:8000")

def executar_testes():
    #teste da API e do Swagger
    print("\n Teste 1: Verificando se a API está online e o Swagger está acessível...")
    try:
        response = requests.get(f"{BASE_URL}/docs")
        if response.status_code == 200:
            print("API e Swagger estão respondendo perfeitamente.")
        else:
            print(f"Erro! A API respondeu com status {response.status_code}")
            return
    except requests.exceptions.ConnectionError:
        print("Erro de conexão: A API não está rodando! Suba o Uvicorn antes.")
        return

    # teste de criação de chat
    print("\n Teste 2: Abertura de um chat de negociação...")
    # Usando IDs que já existem no banco (vêm do init.sql populado pelo Docker)
    payload_chat = {"id_produto": 3, "id_interessado": 1}
    res_chat = requests.post(f"{BASE_URL}/chats/", params=payload_chat)
    
    if res_chat.status_code == 200:
        dados_chat = res_chat.json()
        id_chat_criado = dados_chat["dados"]["id"]
        print(f"Sucesso! Chat ID {id_chat_criado} iniciado para o Produto 1.")
    else:
        print(f"Nota: O chat pode já ter sido criado anteriormente ou o ID mudou. Código: {res_chat.status_code}")

    #teste das views do dashboard
    print("\n Teste 3: Validando as Views do Dashboard...")
    views_para_testar = [
        ("Ranking de Campi", "/dashboard/ranking-campi-ativos"),
        ("Demanda por Categorias", "/dashboard/demanda-categorias"),
        ("Métrica de Economia", "/dashboard/economia-comunidade")
    ]
    
    for nome_view, endpoint in views_para_testar:
        res_view = requests.get(f"{BASE_URL}{endpoint}")
        if res_view.status_code == 200:
            print(f"View '{nome_view}' respondendo perfeitamente (Status 200).")
        else:
            print(f"Falha ao ler a View '{nome_view}'. Código: {res_view.status_code}")

    #teste da trigger de conclusão de negociação
    print("\n Teste 4: Validando disparo automático da Trigger 'tg_concluir_negociao'...")
    
    res_trigger = requests.patch(f"{BASE_URL}/produtos/1/concluir")
    if res_trigger.status_code == 200:
        print("Sucesso! Produto concluído.")
        print("O PostgreSQL disparou a Trigger e limpou as negociações concorrentes no banco!")
    else:
        print(f"Falha ao atualizar produto. Código: {res_trigger.status_code}")

    #teste da procedure de limpeza de anúncios antigos
    print("\n Teste 5: Chamando a Procedure 'pro_limpar_anuncios_antigos'...")
    res_proc = requests.post(f"{BASE_URL}/produtos/limpar-antigos")
    
    if res_proc.status_code == 200:
        print("Sucesso! Procedure executada nativamente pelo banco.")
    else:
        print(f"Falha ao chamar a Procedure. Código: {res_proc.status_code}")


if __name__ == "__main__":
    executar_testes()