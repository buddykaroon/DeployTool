call sfdx auth:list
echo "Creating Project"  
set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)
set CUR_NN=%time:~3,2%
set CUR_SS=%time:~6,2%
set CUR_MS=%time:~9,2%
set SUBFILENAME=ProfileRetrieve-%CUR_YYYY%%CUR_MM%%CUR_DD%-%CUR_HH%%CUR_NN%%CUR_SS%
echo on
cd .\retrieves
call sfdx force:project:create -n %SUBFILENAME% 
cd %SUBFILENAME%
mkdir manifest
copy ..\..\packages\profileSourcePackage.xml .\manifest\sourcePackage.xml
copy ..\..\packages\profileDestinationPackage.xml .\manifest\destinationPackage.xml
call node ..\..\helper\fixProfile.js .\manifest\sourcePackage.xml
call sfdx force:source:retrieve -x .\manifest\sourcePackage.xml -u ckaroonyavanich@salesforce.com.tcb.sfdev > sfdxDevRetrieveLogs.txt

cd ..
cd ..
call node ./helper/removeCustomFieldsNotInSit.js .\retrieves\%SUBFILENAME% 
if "%~1"=="-validate" (call validate_sit.bat .\retrieves\%SUBFILENAME%)
