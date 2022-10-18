# DeployTool
### Deploy Tool for TCB Project

## Pre-Requisitites:
   * Node.js installed
   * SFDX installed
   * sfdx authenticated to both SIT enviroment and SFDEV enviroment
        * Mac: Store Username in `DeployTool/macCredentials.env`
        * Windows: Store Username in `DeployTool/winCredentials.bat`
    
# Standard (Non-Profile/PermissionSet) MetaData Deploy:

### 1. Fill out `DeployTool\sourcePackage.xml` according to deploy sheet

### 2. To Retrieve and Validate: 

Mac: `.\macRetrieveDev.sh -validate` 

Windows: `.\winRetrieveDev.bat -validate`

# Profile/PermissionSet Deploy Instructions:
##  1. Check if deploy package contains new layout or new custom object
 
If yes, update `profileSourcePackage.xml` with the new layout or Custom object. (For existing layouts / objects no need to update package.)<br /><br />


## 2. Check Custom Fields being deployed
There are some custom fields that exist in SFDEV, and do not exist in SIT, **but are not supposed to be pushed to SIT**.

 Sometimes it is because these fields are work in progress so developer doesn't want it pushed.
 Since full profile retreive will pull every custom field, these unwanted fields will also be pulled with it.<br /><br />These will cause profile deployment to error as it will try to deploy profiles containing field-permissions for a field that doesn't exist in SIT <br /><br />
Json File:  `DeployTool/helper/fixConfig/CustomFieldsNotInSit.json` 

contains work-in-progress fields that are in SFDEV but not in SIT, and not planned for Deployment to SIT. 

Any custom field listed here will be removed from all profile.xml files in retrieved folder. 

If one of these fields are in deploy list, make sure to remove it from the `CustomFieldsNotInSit` Json File before retrieving profiles. 

Also, if a new field is added to SFDEV but not planned for deployment to SIT, `CustomFieldsNotInSit` needs to be updated with that field or else it will cause profile deployment error. 

## 3. To retrieve Full Profile Package, run: 

Mac: `.\macRetrieveProfileDev.sh` 
    
Windows: `.\winRetrieveProfileDev.bat`


# Full Deployment:
### 1. Create and Validate Profile/permissionset package 
### 2. Create and Validate Standard package
### 3. In the validated Profile/Permissionset package, copy the folders:
1. > `ProfileRetrieve-xxxx/force-app/default/main/profiles`
2. > `ProfileRetrieve-xxxx/force-app/default/main/permissionsets`
3. > `ProfileRetrieve-xxxx/force-app/default/main/permissionsetgroups`
### and paste the folders into the Validated Standard Retrieve package: 
1. > `StandardRetrieve-xxxx/force-app/default/main/`
### 4. Update the combined package's `destinationPackage.xml` to contain both Profile and Standard deployment's `destinationPackage.xml` (Don't replace).

### 5. Run Validate Sit on the new combined package.xml + components 

Mac: `.\macValidateSit.sh -.\retrieves\StandardRetrieve-xxxx` 

Windows: `.\winValidateSit.sh -.\retrieves\StandardRetrieve-xxxx`

### 6. When pass validation, zip the folder and now full package deploy is ready. 