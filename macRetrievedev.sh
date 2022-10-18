SUBFILENAME=StandardRetrieve-$(date +%Y%m%d-%H%M%S)
sfdx auth:list
. macCredentials.env
echo "Creating Project"
cd ./retrieves
sfdx force:project:create -n $SUBFILENAME
cd $SUBFILENAME
mkdir manifest
cp ../../packages/sourcePackage.xml ./manifest/sourcePackage.xml
cp ../../packages/sourcePackage.xml ./manifest/destinationPackage.xml
node ../../helper/fixProfile.js ./manifest/sourcePackage.xml
echo "$1"
sfdx force:source:retrieve -x ./manifest/sourcePackage.xml -u $SFDEV_USERNAME > sfdxDevRetrieveLogs.txt

cd ../..
if [ "$1" == "-validate" ]; then 
    ./macValidateSit.sh ./retrieves/$SUBFILENAME
fi
# xcopy $SUBFILENAME  $SUBFILENAME-raw  /h /i /c /k /e /r /y