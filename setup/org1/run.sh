mkdir -p couchdb/couchdb0/
mkdir -p couchdb/couchdb1/

docker stack deploy -c docker-compose.yaml peer_org1