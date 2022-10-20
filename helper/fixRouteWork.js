var fs = require('fs');
var path = require('path');
var source = require('../helper/queue-source.json').result.records;
var target = require('../helper/queue-target.json').result.records;

//console.log(process)

var prefix = process.argv[2];
var flows = process.argv.slice(3);

//console.log(prefix);
//console.log(flows);

var _target = target.reduce((r, e) => {
    r[e.DeveloperName] = e;
    return r;
}, {});

var transform = source.map(e => Object.assign(e, {_target: _target[e.DeveloperName]}));
transform.filter(e => !e._target).forEach(e => console.warn(`MISSING Queue -> ${e.DeveloperName}`));

flows.forEach(flow => {

    console.log('-> FLOW', flow);
    try{
        var xml = fs.readFileSync(`../../force-app/main/default/flows/${flow}.flow-meta.xml`, 'utf8');

        var fixed = transform.filter(e => !!e._target).reduce((r, e) => r.replaceAll(`>${e.Id}<`, `>${e._target.Id}<`), xml);
        
        if(xml != fixed){
            fs.writeFileSync(`../.${prefix}/force-app/main/default/flows/${flow}.flow-meta.xml`, fixed, {encoding: 'utf8', flag: 'w'});
        }
    }
    catch(e)
    {
        console.log("Flow not included: " + flow);
    }
})

