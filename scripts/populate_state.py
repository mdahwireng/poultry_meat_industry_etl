import os
import os
import pandas as pd
import sys

sys.path.append(os.path.abspath(os.path.join("./")))
from modules.db_utils import db_con, execute_many


db = "meat_poultry_wh"

con = db_con(dbname=db)

state_df = pd.read_csv('data/states.csv')

execute_many(conn=con, df=state_df, table='state')