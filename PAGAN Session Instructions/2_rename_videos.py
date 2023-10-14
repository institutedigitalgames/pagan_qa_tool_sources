# -*- coding: utf-8 -*-
"""
Created on Tue Feb 14 11:41:39 2023

@author: Manos

"""

import pandas as pd
import os
import shutil


SESSION_NAME = str(7)

video_folder = "./"

df_entries = pd.read_csv("0F1BB181-7DA3-1666-45CF-AB1940AABF9F_entries.csv")

path_to_current_session = video_folder +  SESSION_NAME + "/"

videos = os.listdir(path_to_current_session)

path_to_dst = video_folder + SESSION_NAME + "_DB/"


for i in range(0,len(df_entries)):
    
    src = path_to_current_session + df_entries['OriginalName'][i]
    
    dst = path_to_dst + df_entries['DatabaseName'][i]
    
    if not os.path.exists(path_to_dst):
        try:
            os.makedirs(path_to_dst)
        except OSError as e:
            print(f"An error has occurred: {e}")
            raise
    
    shutil.copyfile(src, dst)