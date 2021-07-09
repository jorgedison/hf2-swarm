export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../orderer/crypto-config/ordererOrganizations/midominio.com/orderers/orderer.midominio.com/msp/tlscacerts/tlsca.midominio.com-cert.pem
export PEER0_ORG3_CA=${PWD}/crypto-config/peerOrganizations/org3.midominio.com/peers/peer0.org3.midominio.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/

export CHANNEL_NAME=mychannel

setGlobalsForPeer0Org3() {
    export CORE_PEER_LOCALMSPID="Org3MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/org3.midominio.com/users/Admin@org3.midominio.com/msp
    export CORE_PEER_ADDRESS=localhost:11051

}

setGlobalsForPeer1Org3() {
    export CORE_PEER_LOCALMSPID="Org3MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/org3.midominio.com/users/Admin@org3.midominio.com/msp
    export CORE_PEER_ADDRESS=localhost:12051

}

fetchChannelBlock() {
    rm -rf ./channel-artifacts/*
    setGlobalsForPeer0Org3

    # Replace localhost with your orderer's vm IP address
    peer channel fetch 0 ./channel-artifacts/$CHANNEL_NAME.block -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.midominio.com \
        -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
    echo "############ fetchChannelBlock ###########"
}

# fetchChannelBlock

joinChannel() {
    setGlobalsForPeer0Org3
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo "############ joinChannel Peer0Org3 ###########"

    setGlobalsForPeer1Org3
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo "############ joinChannel Peer1Org3 ###########"

}

# joinChannel

updateAnchorPeers() {
    setGlobalsForPeer0Org3

    # Replace localhost with your orderer's vm IP address
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.midominio.com \
        -c $CHANNEL_NAME -f ./../../artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo "############ updateAnchorPeers ###########"

}

# updateAnchorPeers

fetchChannelBlock
joinChannel
updateAnchorPeers
