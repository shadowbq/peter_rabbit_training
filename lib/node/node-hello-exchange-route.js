#!/usr/bin/env node

var rabbitHub = require('rabbitmq-nodejs-client');

//topic based non-Durable (using pub adapter)
// Hello is the exchange.. 
var pubHub = rabbitHub.create( { host: '10.5.0.10', task: 'pubDir', channel: 'helloRoutable' } );
pubHub.on('connection', function(hub) {

    //hub.send(msg, routingKey[optional])
    hub.send('Hello World!');
    hub.send('Hello World! 2', 'hell22');

});
pubHub.connect();
