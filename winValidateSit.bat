
echo "Validating to SIT"  
call winCredentials.bat
echo %~1
call  node .\helper\fixMeta.js   %~1
cd %~1
call sfdx force:source:deploy -x .\manifest\destinationPackage.xml -u %SIT_USERNAME% -c > sfdxValidateLogs.txt
cd ..
cd ..

