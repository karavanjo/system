SERVER_IP = $1

iptables -A INPUT -p tcp -s 0/0 --sport 1024:65535 -d $SERVER_IP --dport 5432 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s $SERVER_IP --sport 5432 -d 0/0 --dport 1024:65535 -m state --state ESTABLISHED -j ACCEPT
