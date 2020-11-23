export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../orderer/crypto-config/ordererOrganizations/midominio.com/orderers/orderer.midominio.com/msp/tlscacerts/tlsca.midominio.com-cert.pem
export PEER0_ORG3_CA=${PWD}/crypto-config/peerOrganizations/org3.midominio.com/peers/peer0.org3.midominio.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/

export CHANNEL_NAME=mychannel

export CORE_PEER_LOCALMSPID="Org3MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/org3.midominio.com/users/Admin@org3.midominio.com/msp
export CORE_PEER_ADDRESS=localhost:11051

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1"
CC_SRC_PATH="./../../artifacts/src/github.com/fabcar/go"
CC_NAME="fabcar"

peer lifecycle chaincode approveformyorg -o localhost:7050 \
--ordererTLSHostnameOverride orderer.midominio.com --tls $CORE_PEER_TLS_ENABLED \
--cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} \
--version ${VERSION} --init-required --package-id ${PACKAGE_ID} \
--sequence ${VERSION}

echo "===================== chaincode approved from org 3 ===================== "