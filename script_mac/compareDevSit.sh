#compareDevSit
../ constants.env
SUBFILENAME=StandardRetrieve-$(date +%Y%m%d%H%M%S)

sfdx auth:list
echo on
cd ./compare
mkdir $SUBFILENAME
cd $SUBFILENAME
mkdir objectCompare
mkdir permissionCompare
mkdir profileCompare
echo "Retrieving Object"
sfdx force:data:soql:query -f ../../helper/objectQuery.txt -u $SITUSERNAME -r csv > objectCompare/object_sitRetrieve.csv
sfdx force:data:soql:query -f ../../helper/objectQuery.txt -u $DEVUSERNAME -r csv > objectCompare/object_devRetrieve.csv

echo "Retrieving Permissionsets"
sfdx force:data:soql:query -f ../../helper/permissionQuery.txt -u $SITUSERNAME -r csv > permissionCompare/permission_sitRetrieve.csv
sfdx force:data:soql:query -f ../../helper/permissionQuery.txt -u $DEVUSERNAME -r csv > permissionCompare/permission_devRetrieve.csv

echo "Retrieving Profiles"
sfdx force:data:soql:query -f ../../helper/profileQuery.txt -u $SITUSERNAME -r csv > profileCompare/profile_sitRetrieve.csv
sfdx force:data:soql:query -f ../../helper/profileQuery.txt -u $DEVUSERNAME -r csv > profileCompare/profile_devRetrieve.csv
