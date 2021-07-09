mkdir -p ../crypto-config/peerOrganizations/org3.midominio.com/
mkdir -p fabric-ca/org3/
mkdir -p var/ca-org3

docker stack deploy -c docker-compose.yaml ca_org3
