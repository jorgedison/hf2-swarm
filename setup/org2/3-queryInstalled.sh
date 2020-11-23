export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../orderer/crypto-config/ordererOrganizations/midominio.com/orderers/orderer.midominio.com/msp/tlscacerts/tlsca.midominio.com-cert.pem
export PEER0_ORG2_CA=${PWD}/crypto-config/peerOrganizations/org2.midominio.com/peers/peer0.org2.midominio.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/

export CHANNEL_NAME=mychannel

export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/org2.midominio.com/users/Admin@org2.midominio.com/msp
export CORE_PEER_ADDRESS=localhost:9051

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1"
CC_SRC_PATH="./../../artifacts/src/github.com/fabcar/go"
CC_NAME="fabcar"

peer lifecycle chaincode queryinstalled >&log.txt
cat log.txt
PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
echo PackageID is ${PACKAGE_ID}
echo "===================== Query installed successful on peer0.org2 on channel ===================== "