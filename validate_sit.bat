
echo "Validating to SIT"  
echo %~1
call  node  .\helper\fixMeta.js   %~1
cd %~1
call sfdx force:source:deploy -x .\manifest\destinationPackage.xml -u ckaroonyavanich@salesforce.com.situat -c > sfdxValidateLogs.txt
cd ..
cd ..

