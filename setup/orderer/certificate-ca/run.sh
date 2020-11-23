mkdir -p ../crypto-config/ordererOrganizations/midominio.com/
mkdir -p fabric-ca/ordererOrg/

docker stack deploy -c docker-compose.yaml ca_orderer