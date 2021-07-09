mkdir -p ../crypto-config/ordererOrganizations/midominio.com/
mkdir -p fabric-ca/ordererOrg/
mkdir -p var/ca-orderer

docker stack deploy -c docker-compose.yaml ca_orderer
