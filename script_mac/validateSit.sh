#validateSit
sfdx auth:list
cd ..
. constants.env
echo "Validating to SIT"  
echo $1
node  ./helper/fixMeta.js   $1
cd $1
sfdx force:source:deploy -x ./manifest/destinationPackage.xml -u $SITUSERNAME -c > sfdxValidateLogs.txt
cd ..
cd ..