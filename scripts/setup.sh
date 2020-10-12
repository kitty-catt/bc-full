NAMESPACE=full-bc
WORKZ=full-bc-tmp

oc new-project $NAMESPACE

echo "temporary artifacts are stored in: " ~/$WORKZ

rm -rf ~/$WORKZ
mkdir -pv ~/$WORKZ

cd ~/$WORKZ

# return
cd -
