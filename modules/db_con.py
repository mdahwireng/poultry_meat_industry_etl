import psycopg2
import os
import json

# change directory to home directory (one level up)
os.chdir('../')

if os.path.exists(".env/db_config.json"):
    with open(".env/aws_config.json") as e:
        env = json.load(e)

dbname = env["dbname"]
user = env["user"]
password = env["password"]
host = env["host"]

def db_con(dbname=dbname, user=user, host=host, password=password):
    try:
        con = psycopg2.connect(dbname=dbname, user=user, host=host, password=password)
        print('Connection created!')
        return con
    except Exception as e:
        print('Connection not created...\nError: {e}\n')
