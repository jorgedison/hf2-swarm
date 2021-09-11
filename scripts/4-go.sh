#GO
echo "        ####################################################### "
echo "        #                   INSTALLING GOLANG                  # "
echo "        ####################################################### "
sudo apt update -y
cd /tmp
sudo curl -O https://dl.google.com/go/go1.15.linux-amd64.tar.gz

sudo tar -xvf go1.15.linux-amd64.tar.gz
sudo mv go /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
source ~/.profile
echo "GOLANG version ..."
go version

#GOPATH Directory
cd $HOME
mkdir go
echo 'export GOPATH=$HOME/go' >> ~/.profile
source ~/.profile

echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.profile
source ~/.profile

go get -u github.com/hyperledger/fabric/cmd/configtxgen 
go get -u github.com/hyperledger/fabric/cmd/configtxlator 
go get -u github.com/hyperledger/fabric/cmd/peer 
go get -u github.com/hyperledger/fabric-ca/cmd/fabric-ca-client