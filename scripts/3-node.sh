#NODE
echo "        ####################################################### "
echo "        #                   INSTALLING NODE                  # "
echo "        ####################################################### "

#  Node.js 8.x LTS Carbon is no longer actively supported!
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt install nodejs -y
echo "NODE version ..."
node --version
echo "NPM version ..."
npm --version