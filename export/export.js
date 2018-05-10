let fs = require('fs');
let request = require('request-promise')
let openwhisk = require('openwhisk')
let wsk = openwhisk({ignore_certs: true})
let jsesc = require('jsesc');

let pkgName = process.argv[2]
let actionName = process.argv[3]
let contentType = process.argv[4]
let fileContent = fs.readFileSync(process.argv[5])
let content = jsesc(`${fileContent}`)

let install = wsk.packages
    .update({packageName: pkgName})
    .then(pkg => {
        console.log(pkg)
        let action = {
            exec: {
                kind: 'nodejs:6',
                code: `function main() { return { headers: { 'content-type': '${contentType}'}, body: \`${content}\` } }`
            },
            annotations: [{ key: 'web-export', value: true }]
        }
        return wsk.actions.update({actionName: `${pkgName}/${actionName}`, action: action})
    })

Promise
    .all([install])
    .then(r => console.log(r))
    .catch(e => console.log(e))
