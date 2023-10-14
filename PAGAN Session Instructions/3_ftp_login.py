from ftplib import FTP, FTP_TLS
#import pandas as pd
import os

host = "ftp.davidmelhart.com"
port = "21"

username = "manolis@davidmelhart.com"
password = "6fh]n$*11p;w"

SESSIONS = [7]

for SESSION in SESSIONS:
    
    print(SESSION)

    SESSION_NAME = str(SESSION)
    
    video_folder = "./"
    
    path_to_dst = video_folder + SESSION_NAME + "_DB/" 
    
    videos = os.listdir(path_to_dst)
    
    # Connect FTP Server
    ftp_server = FTP_TLS(host, username, password)
    
    # force UTF-8 encoding
    ftp_server.encoding = "utf-8"
    
    #ftp.login(user=username,passwd=password)
    print(ftp_server.getwelcome())
    
    
    for i in range(0,len(videos)): 
        
        filepath = path_to_dst + videos[i]
        filename = videos[i]
    
     
        # Read file in binary mode
        with open(filepath, "rb") as file:
            # Command for Uploading the file "STOR filename"
            ftp_server.storbinary(f'STOR {filename}' , file)


ftp_server.quit()

