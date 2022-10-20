#compareDevSit
. macCredentials.env
echo on

# sopon.s - to fix RouteWork QueueId
echo ">>> Routing Queues"
sfdx force:data:soql:query -u $SFDEV_USERNAME -q "SELECT Id, DeveloperName FROM Group WHERE Type = 'Queue' AND QueueRoutingConfigId != null " --json > ./helper/queue-source.json
sfdx force:data:soql:query -u $SIT_USERNAME -q "SELECT Id, DeveloperName FROM Group WHERE Type = 'Queue' AND QueueRoutingConfigId != null " --json > ./helper/queue-target.json
# ==================================
