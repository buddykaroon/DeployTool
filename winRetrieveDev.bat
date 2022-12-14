call sfdx auth:list
echo "Creating Project" 
call winCredentials.bat
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
echo ..\%~1
call sfdx force:source:retrieve -x .\manifest\sourcePackage.xml -u %SFDEV_USERNAME% > sfdxDevRetrieveLogs.txt
cd ..
cd ..
if "%~1"=="-validate" (call winValidateSit.bat .\retrieves\%SUBFILENAME%)
