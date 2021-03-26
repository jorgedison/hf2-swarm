## Hyperledger Fabric v2.2.0
#### Implementación de red blockchain utilizando Hyperledger Fabric 2.2.0
##### Pre-Requisitos
```
cd script
./pre-requisitos.sh
```
##### Despliegue
###### Host Org1
```
cd setup/org1/create-certificate-with-ca/
docker-compose up -d
./create-certificate-with-ca.sh

cd setup/org2/create-certificate-with-ca/
docker-compose up -d
./create-certificate-with-ca.sh

cd setup/org3/create-certificate-with-ca/
docker-compose up -d
./create-certificate-with-ca.sh

cd setup/orderer/create-certificate-with-ca/
docker-compose up -d
./create-certificate-with-ca.sh

cd artifacts/channel/
./create-artifacts.sh

scp -r artifacts/channel/mychannel.tx setup/org1/channel-artifacts/
scp -r artifacts/channel/mychannel.tx setup/org2/channel-artifacts/
scp -r artifacts/channel/mychannel.tx setup/org3/channel-artifacts/
```
###### Host Org1
```
cd setup/org1/
docker-compose up -d
```
###### Host Org2
```
cd setup/org2/
docker-compose up -d
```
###### Host Org3
```
cd setup/org3/
docker-compose up -d
```
###### Host Orderer
```
cd setup/orderer/
docker-compose up -d
```
###### Host Org1
```
cd setup/org1/
./createChannel.sh
```
###### Host Org2
```
cd setup/org2/
./joinChannel.sh
```
###### Host Org3
```
cd setup/org3/
./joinChannel.sh

```
