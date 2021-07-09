# Copyright All Rights Reserved.
# Autor: Jorge Rodriguez, jorgeedison1@gmail.com
# Date: 25-09-2020
# SPDX-License-Identifier: Apache-2.0

createCretificateForOrderer() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/ordererOrganizations/midominio.com/msp/

  CONTAINER="docker exec -ti ca_orderer_ca_orderer.1.$(docker service ps -f 'name=ca_orderer_ca_orderer.1' ca_orderer_ca_orderer -q --no-trunc | head -n1)"
  #$CONTAINER export FABRIC_CA_CLIENT_HOME=/etc/hyperledger/fabric-ca-server/  
  $CONTAINER fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.orderer --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/ordererOrganizations/midominio.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo

  $CONTAINER fabric-ca-client register --caname ca.orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  echo
  echo "Register orderer2"
  echo

  $CONTAINER fabric-ca-client register --caname ca.orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  echo
  echo "Register orderer3"
  echo

  $CONTAINER fabric-ca-client register --caname ca.orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  echo
  echo "Register the orderer admin"
  echo

  $CONTAINER fabric-ca-client register --caname ca.orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  mkdir -p ../crypto-config/ordererOrganizations/midominio.com/orderers
  # mkdir -p ../crypto-config/ordererOrganizations/midominio.com/orderers/midominio.com

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p ../crypto-config/ordererOrganizations/midominio.com/orderers/orderer.midominio.com

  echo
  echo "## Generate the orderer msp"
  echo

  $CONTAINER fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca.orderer -M /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/msp --csr.hosts orderer.midominio.com --csr.hosts localhost --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/msp/config.yaml /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/msp/config.yaml'

  echo
  echo "## Generate the orderer-tls certificates"
  echo

  $CONTAINER fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca.orderer -M /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/tls --enrollment.profile tls --csr.hosts orderer.midominio.com --csr.hosts localhost --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/tls/ca.crt'
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/tls/signcerts/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/tls/server.crt'
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/tls/keystore/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/tls/server.key'

  $CONTAINER mkdir /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/msp/tlscacerts
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/msp/tlscacerts/tlsca.midominio.com-cert.pem'

  $CONTAINER mkdir /etc/hyperledger/fabric-ca-server-config/msp/tlscacerts
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/msp/tlscacerts/tlsca.midominio.com-cert.pem'

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p ../crypto-config/ordererOrganizations/midominio.com/orderers/orderer2.midominio.com

  echo
  echo "## Generate the orderer2 msp"
  echo

  $CONTAINER fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca.orderer -M /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/msp --csr.hosts orderer2.midominio.com --csr.hosts localhost --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/msp/config.yaml /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/msp/config.yaml'

  echo
  echo "## Generate the orderer2-tls certificates"
  echo

  $CONTAINER fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca.orderer -M /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/tls --enrollment.profile tls --csr.hosts orderer2.midominio.com --csr.hosts localhost --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/tls/ca.crt'
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/tls/signcerts/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/tls/server.crt'
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/tls/keystore/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/tls/server.key'

  $CONTAINER mkdir /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/msp/tlscacerts
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer2.midominio.com/msp/tlscacerts/tlsca.midominio.com-cert.pem'

  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p ../crypto-config/ordererOrganizations/midominio.com/orderers/orderer3.midominio.com

  echo
  echo "## Generate the orderer3 msp"
  echo

  $CONTAINER fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:9054 --caname ca.orderer -M /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/msp --csr.hosts orderer3.midominio.com --csr.hosts localhost --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/msp/config.yaml /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/msp/config.yaml'

  echo
  echo "## Generate the orderer3-tls certificates"
  echo

  $CONTAINER fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:9054 --caname ca.orderer -M /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/tls --enrollment.profile tls --csr.hosts orderer3.midominio.com --csr.hosts localhost --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/tls/ca.crt'
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/tls/signcerts/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/tls/server.crt'
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/tls/keystore/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/tls/server.key'

  $CONTAINER mkdir /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/msp/tlscacerts
  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/tls/tlscacerts/* /etc/hyperledger/fabric-ca-server-config/orderers/orderer3.midominio.com/msp/tlscacerts/tlsca.midominio.com-cert.pem'
  # ---------------------------------------------------------------------------

  mkdir -p ../crypto-config/ordererOrganizations/midominio.com/users
  mkdir -p ../crypto-config/ordererOrganizations/midominio.com/users/Admin@midominio.com

  echo
  echo "## Generate the admin msp"
  echo

  $CONTAINER fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca.orderer -M /etc/hyperledger/fabric-ca-server-config/users/Admin@midominio.com/msp --tls.certfiles /etc/hyperledger/fabric-ca-server/tls-cert.pem

  $CONTAINER sh -c 'cp /etc/hyperledger/fabric-ca-server-config/msp/config.yaml /etc/hyperledger/fabric-ca-server-config/users/Admin@midominio.com/msp/config.yaml'

}

createCretificateForOrderer