using curl to make a request to change something

#My isp
curl -k -u "admin:ibUqz6B9" https://192.168.1.1:8000/avanzada.asp | grep -oP '[a-zA-Z0-9_-]+\.asp' | sort -u
curl -k -u "admin:ibUqz6B9" https://192.168.1.1:8000/monu.asp | grep -oP '[a-zA-Z0-9_-]+\.asp'
