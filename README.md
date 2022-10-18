# DeployTool
 Deploy Tool for TCB

Pre-Requisitites:
    Node.js installed
    SFDX installed
    sfdx authenticated to both SIT enviroment and SFDEV enviroment

    sfdx auth:list
        Store in constants.env
    

Full Profile/PermissionSet Deploy:
       1) Check if deploy package contains new LAYOUT or new CUSTOM OBJECT, 
        ensure that 
        profileSourcePackage.xml is updated with the new page layout or Custom object. 
        Not doing this will result in deployed Profiles not containing 

       2) Check Config file: helper/fixConfigs/CustomFieldsNotInSit.json
       This represents the custom fields that are in SFDEV, but not in SIT. Often this means the fields are work in progress so developer doesn't want it pushed. 

       cmd:
           script_mac/retrieveProfileDev.sh

Non-Profile/PermissionSet MetaData Deploy:
     1) 


Full MetaData Deploy
