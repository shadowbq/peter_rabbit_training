#!/usr/bin/env node

var rabbitHub = require('rabbitmq-nodejs-client');

//topic based non-Durable (using pub adapter)
var pubHub = rabbitHub.create( { host: '10.5.0.10', task: 'pub', channel: 'hello' } );
pubHub.on('connection', function(hub) {

    //hub.send(msg, routingKey[optional])
    hub.send('Hello World!');

});
pubHub.connect();
