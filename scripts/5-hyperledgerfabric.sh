#FABRIC
# Ejecuta el setup inicial de las maquinas , creación de directorios y descarga de imagenes de Hyperledger Fabric
echo "        ####################################################### "
echo "        #                   INSTALLING HYPERLEDGER FABRIC     # "
echo "        ####################################################### "
cd $tmppwd
FABRICSamplesDir="$HOME/hyperledger/fabric"
mkdir -p $FABRICSamplesDir

sudo chmod -R 777 $FABRICSamplesDir
cd $FABRICSamplesDir
sudo curl -sSL http://bit.ly/2ysbOFE | bash -s 2.2.0

echo 'export PATH=$PATH:$HOME/hyperledger/fabric/fabric-samples/bin' >> ~/.profile
source ~/.profile