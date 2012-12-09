#!/usr/bin/env python
# -*- coding: utf-8 -*-
#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import socket
 
host = "localhost"
port = 44444
 
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((host, port))
while True:
    buf = raw_input(">>")
    s.send(buf)
    result = s.recv(1024)
    print result
    if buf == "exit":
        break
s.close()