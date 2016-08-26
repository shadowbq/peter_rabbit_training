#!/usr/bin/env node

var rabbitHub = require('rabbitmq-nodejs-client');

//topic based non-Durable 
var subHub = rabbitHub.create( { host: '10.5.0.10', task: 'sub', channel: 'hello' } );
subHub.on('connection', function(hub) {

    hub.on('message', function(msg) {
        console.log(msg);
    }.bind(this));

});
subHub.connect();

