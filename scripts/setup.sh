source config

oc new-project $NAMESPACE

echo "temporary artifacts are stored in: " ~/$WORKSPACE

rm -rf ~/$WORKSPACE
mkdir -pv ~/$WORKSPACE

bash setup-pipeline.sh
bash inventory/setup-inventory-ms.sh



