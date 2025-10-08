# %%
import pandas as pd
import sqlalchemy
# Conexão com o banco
engine = sqlalchemy.create_engine("sqlite:///database.db")
# Lenco a query do arquivo de texto
with open ("./Projeto/etl_projeto.sql") as open_file:
    query = open_file.read()

print(query)
# %%
dates = [
    '2025-01-01',
    '2025-02-01',
    '2025-03-01',
    '2025-04-01',
    '2025-05-01',
    '2025-06-01',
    '2025-07-01',
    ]

for i in dates :
    #Executa a query e tra os dados para o Python
    df = pd.read_sql(query.format(date=i), engine)
    # Pega os dados do Python e manda para o banco na tabela feature_store_cliente
    df.to_sql("feature_store_cliente",engine,index=False,if_exists="append")
# %%
