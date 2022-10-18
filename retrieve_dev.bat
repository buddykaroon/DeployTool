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
set SUBFILENAME=StandardRetrieve-%CUR_YYYY%%CUR_MM%%CUR_DD%-%CUR_HH%%CUR_NN%%CUR_SS%
echo on
cd .\retrieves
call sfdx force:project:create -n %SUBFILENAME% 
cd %SUBFILENAME%
mkdir manifest
copy ..\..\packages\sourcePackage.xml .\manifest\sourcePackage.xml
copy ..\..\packages\sourcePackage.xml .\manifest\destinationPackage.xml
rem call node ..\..\helper\fixProfile.js .\manifest\sourcePackage.xml
echo ..\%~1
rem if "%~1"=="" (copy ..\..\packages\sourcePackage.xml .\manifest\destinationPackage.xml) else (copy ..\%~1 .\manifest\destinationPackage.xml)
call sfdx force:source:retrieve -x .\manifest\sourcePackage.xml -u ckaroonyavanich@salesforce.com.tcb.sfdev > sfdxDevRetrieveLogs.txt

cd ..
cd ..
if "%~1"=="-validate" (call validate_sit.bat .\retrieves\%SUBFILENAME%)
rem xcopy %SUBFILENAME%  %SUBFILENAME%-raw  /h /i /c /k /e /r /y