# Copyright All Rights Reserved.
# Autor: Jorge Rodriguez, jorgeedison1@gmail.com
# Date: 25-09-2020
# SPDX-License-Identifier: Apache-2.0

createcertificatesForOrg2() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/org2.midominio.com/msp/
  #export FABRIC_CA_CLIENT_HOME=/etc/hyperledger/fabric-ca-server-config/
  CONTAINER="docker exec -ti ca_org2_ca_org2.1.$(docker service ps -f 'name=ca_org2_ca_org2.1' ca_org2_ca_org2 -q --no-trunc | head -n1)"

  $CONTAINER fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.org2.midominio.com --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-midominio-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-midominio-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-midominio-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-midominio-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/org2.midominio.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
  $CONTAINER fabric-ca-client register --caname ca.org2.midominio.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  echo
  echo "Register peer1"
  echo
  $CONTAINER fabric-ca-client register --caname ca.org2.midominio.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  echo
  echo "Register user"
  echo
  $CONTAINER fabric-ca-client register --caname ca.org2.midominio.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  echo
  echo "Register the org admin"
  echo
  $CONTAINER fabric-ca-client register --caname ca.org2.midominio.com --id.name org2admin --id.secret org2adminpw --id.type admin --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/org2.midominio.com/peers

  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p ../crypto-config/peerOrganizations/org2.midominio.com/peers/peer0.org2.midominio.com

  echo
  echo "## Generate the peer0 msp"
  echo
  $CONTAINER fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.midominio.com -M /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/msp --csr.hosts peer0.org2.midominio.com --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/msp/config.yaml /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/msp/config.yaml
'
  echo
  echo "## Generate the peer0-tls certificates"
  echo
  $CONTAINER fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.midominio.com -M /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/tls --enrollment.profile tls --csr.hosts peer0.org2.midominio.com --csr.hosts localhost --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/tls/ca.crt'
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/tls/signcerts/* /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/tls/server.crt'
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/tls/keystore/* /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/tls/server.key'

  $CONTAINER mkdir /etc/hyperledger/fabric-ca-server-config/msp/tlscacerts
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/msp/tlscacerts/ca.crt
'
  $CONTAINER mkdir /etc/hyperledger/fabric-ca-server-config/tlsca
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/tlsca/tlsca.org2.midominio.com-cert.pem'

  $CONTAINER mkdir /etc/hyperledger/fabric-ca-server-config/ca
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/peers/peer0.org2.midominio.com/msp/cacerts/* /etc/hyperledger/fabric-ca-server-config/ca/ca.org2.midominio.com-cert.pem
'
  # ------------------------------------------------------------------------------------------------

  # Peer1

  mkdir -p ../crypto-config/peerOrganizations/org2.midominio.com/peers/peer1.org2.midominio.com

  echo
  echo "## Generate the peer1 msp"
  echo
  $CONTAINER fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.midominio.com -M /etc/hyperledger/fabric-ca-server-config/peers/peer1.org2.midominio.com/msp --csr.hosts peer1.org2.midominio.com --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/msp/config.yaml /etc/hyperledger/fabric-ca-server-config/peers/peer1.org2.midominio.com/msp/config.yaml
'
  echo
  echo "## Generate the peer1-tls certificates"
  echo
  $CONTAINER fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.midominio.com -M /etc/hyperledger/fabric-ca-server-config/peers/peer1.org2.midominio.com/tls --enrollment.profile tls --csr.hosts peer1.org2.midominio.com --csr.hosts localhost --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/peers/peer1.org2.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/peers/peer1.org2.midominio.com/tls/ca.crt'
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/peers/peer1.org2.midominio.com/tls/signcerts/* /etc/hyperledger/fabric-ca-server-config/peers/peer1.org2.midominio.com/tls/server.crt'
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/peers/peer1.org2.midominio.com/tls/keystore/* /etc/hyperledger/fabric-ca-server-config/peers/peer1.org2.midominio.com/tls/server.key'

  # --------------------------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/org2.midominio.com/users
  mkdir -p ../crypto-config/peerOrganizations/org2.midominio.com/users/User1@org2.midominio.com

  echo
  echo "## Generate the user msp"
  echo
  $CONTAINER fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.org2.midominio.com -M /etc/hyperledger/fabric-ca-server-config/users/User1@org2.midominio.com/msp --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/org2.midominio.com/users/Admin@org2.midominio.com

  echo
  echo "## Generate the org admin msp"
  echo
  $CONTAINER fabric-ca-client enroll -u https://org2admin:org2adminpw@localhost:8054 --caname ca.org2.midominio.com -M /etc/hyperledger/fabric-ca-server-config/users/Admin@org2.midominio.com/msp --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/msp/config.yaml /etc/hyperledger/fabric-ca-server-config/users/Admin@org2.midominio.com/msp/config.yaml
'
}

createcertificatesForOrg2
