#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"
require 'securerandom'
SecureRandom.base64.delete('/+=')[0, 8]

conn = Bunny.new(:hostname => "10.5.0.10")
conn.start
channel = conn.create_channel
x = channel.fanout("hello")

queue = channel.queue("hellorb")

rmsg = "Hello World! Routed => #{SecureRandom.base64.delete('/+=')[0, 8]}"
msg = "Hello World! => #{SecureRandom.base64.delete('/+=')[0, 8]}"

x.publish(msg)
x.publish(rmsg, :routing_key => queue.name)
puts " [x] Route Sent '#{rmsg}'"
puts " [x] Sent '#{msg}'"

conn.close
