var fs = require('fs');
var path = require('path');
var replaceArray = require("./fixConfigs/ProfileConfig.json");
const myArgs = process.argv.slice(2);

  
fs.readFile(myArgs[0], 'utf8', function (err,data) {
      if (err) {
              return console.log(err);
      }
      var result =data;
      replaceArray.forEach(replaceConfig =>{
        console.log('\t\t Replace From : ' + replaceConfig.from + '  Replace To : ' + replaceConfig.to);
        var replacer = new RegExp(replaceConfig.from,"g");
        result = result.replace(replacer,replaceConfig.to );
      });          
      fs.writeFileSync(myArgs[0], result, {encoding:'utf8',flag:'w'});
});


