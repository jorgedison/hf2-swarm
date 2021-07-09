export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../orderer/crypto-config/ordererOrganizations/midominio.com/orderers/orderer.midominio.com/msp/tlscacerts/tlsca.midominio.com-cert.pem
export PEER0_ORG1_CA=${PWD}/crypto-config/peerOrganizations/org1.midominio.com/peers/peer0.org1.midominio.com/tls/ca.crt
export PEER0_ORG2_CA=${PWD}/../org2/crypto-config/peerOrganizations/org2.midominio.com/peers/peer0.org2.midominio.com/tls/ca.crt
export PEER0_ORG3_CA=${PWD}/../org3/crypto-config/peerOrganizations/org3.midominio.com/peers/peer0.org3.midominio.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/

export CHANNEL_NAME=mychannel

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/org1.midominio.com/users/Admin@org1.midominio.com/msp
export CORE_PEER_ADDRESS=localhost:7051

CHANNEL_NAME="mychannel"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1"
CC_SRC_PATH="./../../artifacts/src/github.com/fabcar/go"
CC_NAME="fabcar"

peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.midominio.com \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME} \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA \
         --peerAddresses localhost:11051 --tlsRootCertFiles $PEER0_ORG3_CA \
        --isInit -c '{"Args":[]}'