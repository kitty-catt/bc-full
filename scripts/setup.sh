NAMESPACE=full-bc
WORKZ=full-bc-tmp

oc new-project $NAMESPACE

echo "temporary artifacts are stored in: " ~/$WORKZ

rm -rf ~/$WORKZ
mkdir -pv ~/$WORKZ

cd ~/$WORKZ

# Use OCP's capability to deploy the MySQL database
oc new-app \
  --name inventorymysql \
  --as-deployment-config \
  --template openshift/mysql-persistent \
-p DATABASE_SERVICE_NAME=inventorymysql \
-p MYSQL_ROOT_PASSWORD=admin123 \
-p MYSQL_USER=dbuser \
-p MYSQL_PASSWORD=password \
-p MYSQL_DATABASE=inventorydb \
-p MYSQL_VERSION=8.0 

# populate the DB
curl https://raw.githubusercontent.com/ibm-garage-ref-storefront/inventory-ms-spring/master/scripts/mysql_data.sql  -o mysql_data.sql

opt=nope
while [  "$opt" != "happy" ] ; do

    POD=$(oc get po | grep -v deploy| grep inventorymysql | awk '{print $1}')
    echo "found pod: $POD"
    oc rsh $POD mysql -udbuser -ppassword inventorydb < mysql_data.sql
    if [ 0 -eq $? ]; then
        echo "database initialized succesfully"
        opt="happy"
    else
        echo "database not initialized yet, retry"
        sleep 1
    fi

done


# return
cd -
