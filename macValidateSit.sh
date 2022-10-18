#validateSit
sfdx auth:list
. macCredentials.env
echo "Validating to SIT"  
echo $1
node ./helper/fixMeta.js $1
cd $1
sfdx force:source:deploy -x ./manifest/destinationPackage.xml -u $SIT_USERNAME -c > sfdxValidateLogs.txt
cd ..
cd ..