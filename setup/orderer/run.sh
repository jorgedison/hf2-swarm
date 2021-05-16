mkdir -p var/orderer
mkdir -p var/orderer2
mkdir -p var/orderer3
docker stack deploy -c docker-compose.yaml orderer
