#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import socket
 
host = "localhost"
port = 44444
 
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((host, port))
s.listen(5)
sock, addr = s.accept()
while True:
    buf = sock.recv(1024)
    if buf == "exit":
        self.sock.send("bye")
        break
    elif buf:
        sock.send(buf)
sock.close()