mkdir -p ../crypto-config/peerOrganizations/org2.midominio.com/
mkdir -p fabric-ca/org2/

docker stack deploy -c docker-compose.yaml ca_org2