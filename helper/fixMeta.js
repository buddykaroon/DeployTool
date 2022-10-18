var fs = require('fs');
var path = require('path');
var jsonData = require("./fixConfigs/MetaConfig.json");
const myArgs = process.argv.slice(2);
jsonData.forEach(config=>{
  replaceAllinType(config.type,config.replaceConfig,config.isFile);
});

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
    replaceArray.forEach(replaceConfig =>{
      console.log('\t\t Replace From : ' + replaceConfig.from + '  Replace To : ' + replaceConfig.to);
      var replacer = new RegExp(replaceConfig.from,"g");
      result = result.replace(replacer,replaceConfig.to );
    });          
    fs.writeFileSync(filepath, result, {encoding:'utf8',flag:'w'});
});
}


