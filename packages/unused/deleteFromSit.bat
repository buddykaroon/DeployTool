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
set SUBFILENAME=%CUR_YYYY%%CUR_MM%%CUR_DD%-%CUR_HH%%CUR_NN%%CUR_SS%
echo on
call sfdx force:project:create -n Delete-%SUBFILENAME% 
cd Delete-%SUBFILENAME%
mkdir manifest
copy ..\deletePackage.xml .\manifest\deletePackage.xml

call sfdx force:source:retrieve -x .\manifest\deletePackage.xml -u ckaroonyavanich@salesforce.com.situat
echo "Deleting From SIT"  
call sfdx force:source:delete -p .\force-app\main\default -u ckaroonyavanich@salesforce.com.situat 



