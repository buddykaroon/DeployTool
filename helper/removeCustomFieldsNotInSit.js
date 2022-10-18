var fs = require('fs');
var path = require('path');
var jsonData = require("./fixConfigs/CustomFieldsNotInSit.json");
const myArgs = process.argv.slice(2);
jsonData.forEach(config=>{
  replaceAllinType("profiles",config.ignoreFields,config.isFile);
  replaceAllinType("permissionsets",config.ignoreFields,config.isFile);
});

const xmlPrefix = "(\\s*)<fieldPermissions>\n(\\s*)<editable>(true|false)</editable>\n(\\s*)<field>";
const xmlSuffix = "</field>\n(\\s*)<readable>(true|false)</readable>\n(\\s*)</fieldPermissions>";


function replaceAllinType(type,replaceArray,isFile)
{
    var spath = myArgs[0] + "/force-app/main/default/"+ type ;

    console.log('===== Start Process : '+ type +' in ' + spath + '===');
    if(isFile)
    {
       handlefile(spath,replaceArray);
    }
    else
    {
      spath += "/";
      try {
        files = fs.readdirSync(spath, { withFileTypes: true });   
        files.forEach(file => {
          handlefile(spath + file.name,replaceArray);
        });  
      } catch (err) { 
        console.log(err);
        console.log("No File specified at " + spath);
      }
    }
}

function handlefile(filepath,replaceArray)
{
  fs.readFile(filepath, 'utf8', function (err,data) {
    console.log('\t Processing file : ' + filepath);
    if (err) {
      return;
    }
    var result =data;

    replaceArray.forEach(ignoreFields =>{
      console.log('\t\t Removing field from profiles: ' + ignoreFields);
      var replacer = new RegExp(xmlPrefix + ignoreFields + xmlSuffix,"g");
      result = result.replace(replacer,'');
    });          
    fs.writeFileSync(filepath, result, {encoding:'utf8',flag:'w'});
});
}


