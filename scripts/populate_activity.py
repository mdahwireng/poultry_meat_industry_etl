import os
import os
import pandas as pd
import sys
import pickle

sys.path.append(os.path.abspath(os.path.join("./")))
from modules.db_utils import db_con, execute_many

db = "meat_poultry_wh"

con = db_con(dbname=db)

with open('data/activity_dict.pkl', 'rb') as f:
    act_dict = pickle.load(f)

act_df = pd.DataFrame(act_dict)


execute_many(conn=con, table='activity', df=act_df, n_cols=1)
