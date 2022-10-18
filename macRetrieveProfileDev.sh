#retrieveProfileDev
sfdx auth:list
. constants.env

SUBFILENAME=ProfileRetrieve-$(date +%Y%m%d-%H%M%S)
echo "Creating Project"  

echo on
cd ./retrieves
sfdx force:project:create -n $SUBFILENAME 
cd $SUBFILENAME
mkdir manifest
cp ../../packages/profileSourcePackage.xml ./manifest/sourcePackage.xml
cp ../../packages/profileDestinationPackage.xml ./manifest/destinationPackage.xml
node ../../helper/fixProfile.js ./manifest/sourcePackage.xml
sfdx force:source:retrieve -x ./manifest/sourcePackage.xml -u $SFDEV_USERNAME > sfdxDevRetrieveLogs.txt
cd ../..
node ./helper/removeCustomFieldsNotInSit.js ./retrieves/$SUBFILENAME
./macValidateSit.sh ./retrieves/$SUBFILENAME
