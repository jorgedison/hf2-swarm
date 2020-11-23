mkdir -p ../crypto-config/peerOrganizations/org1.midominio.com/
mkdir -p fabric-ca/org1/

docker stack deploy -c docker-compose.yaml ca_org1