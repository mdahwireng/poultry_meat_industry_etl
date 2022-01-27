import psycopg2
import sys
import os
import json

# change directory to home directory (one level up)
#os.chdir('../')

sys.path.append(os.path.abspath(os.path.join("./")))

if os.path.exists(".env/db_config.json"):
    with open(".env/db_config.json") as e:
        env = json.load(e)

    dbname = env["dbname"]
    user = env["user"]
    password = env["password"]
    host = env["host"]
    

def db_con(dbname=dbname, user=user, host=host, password=password):
    try:
        con = psycopg2.connect(dbname=dbname, user=user, host=host, password=password)
        con.set_session(autocommit=True)
        print('Connection created!\n')
        return con
    except Exception as e:
        print('Connection not created...\nError: {}\n'.format(e))


def exc_query(con, query):
  if con:
      cur = con.cursor()
      try:
          cur.execute(query)
          cur.close()
          print('Query executed successfuly!\n')
      except Exception as e:
          print('Query not executed...\nError: {}\n'.format(e))
          con.rollback()
          cur.close()


# from https://naysan.ca/2020/05/09/pandas-to-postgresql-using-psycopg2-bulk-insert-performance-benchmark/

def execute_many(conn, df, table, n_cols):
    """
    Using cursor.executemany() to insert the dataframe
    """
    # Create a list of tupples from the dataframe values
    tuples = [tuple(x) for x in df.to_numpy()]
    # Comma-separated dataframe columns
    cols = ','.join(list(df.columns))
    text = "INSERT INTO %s(%s) VALUES({})".format(','.join(['%%s' for i in range(n_cols)]))
    # SQL quert to execute
    query  = text % (table, cols)
    cursor = conn.cursor()
    try:
        cursor.executemany(query, tuples)
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error: %s" % error)
        conn.rollback()
        cursor.close()
        return 1
    print("execute_many() done")
    cursor.close()
