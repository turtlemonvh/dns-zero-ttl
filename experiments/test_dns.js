var http = require('http');

var httpOptions = {
  host: 'web.service.consul',
  port: '8080'
};
nrequests = 100;

function issueRequest() {
    if (nrequests > 0) {
        nrequests = nrequests-1;
        http.request(httpOptions, callback).end();
    }
}

function callback(response) {
    issueRequest();
}

issueRequest();
