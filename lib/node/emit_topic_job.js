#!/usr/bin/env node
var rabbitHub = require('rabbitmq-nodejs-client');

var taskHub = rabbitHub.create( { task: 'task', channel: 'topic_logs' } );
taskHub.on('connection', function(hub) {

  var i = 0;
  setInterval(function() {
    hub.send('Hello World! ' + i);
    i++;
  }, 1000);

});
taskHub.connect();
