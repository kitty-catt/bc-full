oc new-project tools

# Setup Openshift pipelines
echo "###################################################################"
cd pipelines
./install_pipelines.sh
cd ..
echo ""

# Setup sonarqube
echo "###################################################################"
cd sonarqube
./install_sonarqube.sh
cd ..
echo ""

# TODO: setup Openshift service mesh
