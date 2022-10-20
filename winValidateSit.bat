
echo "Validating to SIT"  
call winCredentials.bat
echo %~1
call  node .\helper\fixMeta.js   %~1
call winInitQueues.bat
call node .\helper\fixRouteWork.js %~1 "TCB_Email_to_Case_CR_18" "TCB_Case_Assignment" "TCB_Lead_Auto_Assignment"

cd %~1
call sfdx force:source:deploy -x .\manifest\destinationPackage.xml -u %SIT_USERNAME% -c > sfdxValidateLogs.txt
cd ..
cd ..

