#!/usr/bin/env node
//multiple instances of workers
var rabbitHub = require('rabbitmq-nodejs-client');

var workerHub = rabbitHub.create( { task: 'worker', channel: 'topic_logs' } );
workerHub.on('connection', function(hub) {

  hub.on('message', function(msg) {
    console.log(msg);

    setTimeout(function() {
      hub.ack();
    }, 2);
  }.bind(this));

});
workerHub.connect();
