#validateSit
sfdx auth:list
. macCredentials.env
echo "Validating to SIT"  
echo $1
node ./helper/fixMeta.js $1
# sopon.s - to fix RouteWork QueueId
./macInitQueues.sh
node ./helper/fixRouteWork.js $1 "TCB_Email_to_Case_CR_18" "TCB_Case_Assignment" "TCB_Lead_Auto_Assignment"
# ==================================
cd $1
sfdx force:source:deploy -x ./manifest/destinationPackage.xml -u $SIT_USERNAME -c > sfdxValidateLogs.txt
cd ..
cd ..