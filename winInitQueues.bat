call winCredentials.bat
echo ">>> Routing Queues"
call sfdx force:data:soql:query -u %SFDEV_USERNAME% -q "SELECT Id, DeveloperName FROM Group WHERE Type = 'Queue' AND QueueRoutingConfigId != null " --json > ./helper/queue-source.json
call sfdx force:data:soql:query -u %SIT_USERNAME% -q "SELECT Id, DeveloperName FROM Group WHERE Type = 'Queue' AND QueueRoutingConfigId != null " --json > ./helper/queue-target.json

