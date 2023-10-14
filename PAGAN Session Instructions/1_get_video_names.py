# -*- coding: utf-8 -*-
"""
Created on Tue Feb 14 10:45:58 2023

@author: Manos
"""

import os 


folder = "./"

sessions = os.listdir(folder)

CURRENT_SESSION = str(7) 

path_to_current_session = folder +  CURRENT_SESSION + "/"

videos = os.listdir(path_to_current_session) 