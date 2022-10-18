set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)
set CUR_NN=%time:~3,2%
set CUR_SS=%time:~6,2%
set CUR_MS=%time:~9,2%
set SUBFILENAME=Compare-%CUR_YYYY%%CUR_MM%%CUR_DD%-%CUR_HH%%CUR_NN%%CUR_SS%
echo on
cd .\compare
mkdir %SUBFILENAME%
cd %SUBFILENAME%
mkdir objectCompare
mkdir permissionCompare
mkdir profileCompare

echo "Retrieving Object"
call sfdx force:data:soql:query -f ../../helper/objectQuery.txt -u ckaroonyavanich@salesforce.com.situat -r csv > objectCompare/object_sitRetrieve.csv
call sfdx force:data:soql:query -f ../../helper/objectQuery.txt -u ckaroonyavanich@salesforce.com.tcb.sfdev -r csv > objectCompare/object_devRetrieve.csv

echo "Retrieving Permissionsets"
call sfdx force:data:soql:query -f ../../helper/permissionQuery.txt -u ckaroonyavanich@salesforce.com.situat -r csv > permissionCompare/permission_sitRetrieve.csv
call sfdx force:data:soql:query -f ../../helper/permissionQuery.txt -u ckaroonyavanich@salesforce.com.tcb.sfdev -r csv > permissionCompare/permission_devRetrieve.csv

echo "Retrieving Profiles"
call sfdx force:data:soql:query -f ../../helper/profileQuery.txt -u ckaroonyavanich@salesforce.com.situat -r csv > profileCompare/profile_sitRetrieve.csv
call sfdx force:data:soql:query -f ../../helper/profileQuery.txt -u ckaroonyavanich@salesforce.com.tcb.sfdev -r csv > profileCompare/profile_devRetrieve.csv




