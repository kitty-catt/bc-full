source config

oc new-project $NAMESPACE

echo "temporary artifacts are stored in: " ~/$WORKSPACE

rm -rf ~/$WORKSPACE
mkdir -pv ~/$WORKSPACE

cd ~/$WORKSPACE

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
curl https://raw.githubusercontent.com/kitty-catt/inventory-ms-spring/master/scripts/mysql_data.sql  -o mysql_data.sql

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

# Deploy the inventory service
oc new-app \
 --name=inventory \
 --as-deployment-config \
 --code=https://github.com/kitty-catt/inventory-ms-spring \
 --image-stream=redhat-openjdk18-openshift:1.5 \
 -e MYSQL_HOST=inventorymysql \
 -e MYSQL_PORT=3306 \
 -e MYSQL_DATABASE=inventorydb \
 -e MYSQL_USER=dbuser \
 -e MYSQL_PASSWORD=password

# return
cd -
