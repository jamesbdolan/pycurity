# pycurity

Geeks for Geeks [says](https://www.geeksforgeeks.org/top-10-python-libraries-for-cybersecurity/) these are the top 10 python libraries for cybersecurity, I have ranked them in my order of interest.

1. Scapy
2. Paramiko
3. Nmap
4. REQUESTS with [SQLmap](https://github.com/sqlmapproject/sqlmap)
5. Tornado
   - will also need to understand [sockets](https://realpython.com/python-sockets/)
   - to run the script:
     - run the file with `python src/tornado.py`
     - visit `http://localhost:8888/portscan?hostname=example.com&start port=1&end port=1000`
     - should see a result of `Open ports: [80, 443]`
6. PyCrypto
7. BeautifulSoup
8. PyAutoGUI
9. Scikit-learn
10. TensorFlow

## Major sidequest

I found myself getting a bit lost once again amoung all the python tooling - details [here](tooling.md)

## To do

- [ ] Put requirements files into requirements directory
