cd org1
sh run.sh
cd ../org2
sh run.sh
cd ../org3
sh run.sh
cd ../orderer
sh run.sh



# docker swarm init --advertise-addr 192.168.1.6
# docker network create --driver overlay --subnet=10.200.1.0/24 --attachable my-net

# docker swarm join-token manager

# docker swarm join --token SWMTKN-1-0nlv0an7vi9e6wnggiiip5bcd1xlg0kahxaj9ukrw1ad2btjpn-4d4eiek1hugwmib3xjffpc7s5 192.168.1.6:2377 --advertise-addr 192.168.1.200

# docker swarm join --token SWMTKN-1-0nlv0an7vi9e6wnggiiip5bcd1xlg0kahxaj9ukrw1ad2btjpn-4d4eiek1hugwmib3xjffpc7s5 192.168.1.6:2377 --advertise-addr 192.168.1.201

# docker swarm join --token SWMTKN-1-0nlv0an7vi9e6wnggiiip5bcd1xlg0kahxaj9ukrw1ad2btjpn-4d4eiek1hugwmib3xjffpc7s5 192.168.1.6:2377 --advertise-addr 192.168.1.202

