#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"
require 'securerandom'
SecureRandom.base64.delete('/+=')[0, 8]

conn = Bunny.new(:hostname => "10.5.0.10")
conn.start
channel = conn.create_channel
x = channel.fanout("hello", :auto_delete => true)

queue = channel.queue("hellorb")

msg = "Hello World!  => #{SecureRandom.base64.delete('/+=')[0, 8]}"
rmsg = "Hello World! Routed => #{SecureRandom.base64.delete('/+=')[0, 8]}"
emsg = "Hello World! (hello exchange) => #{SecureRandom.base64.delete('/+=')[0, 8]}"
ermsg = "Hello World! Routed (hello exchange)=> #{SecureRandom.base64.delete('/+=')[0, 8]}"

channel.default_exchange.publish(msg)
channel.default_exchange.publish(rmsg, :routing_key => queue.name)
x.publish(emsg)
x.publish(ermsg, :routing_key => queue.name)

puts " [x] Sent '#{msg}'"
puts " [x] Route Sent '#{rmsg}'"
puts " [Ex] Sent '#{emsg}'"
puts " [Ex] Routed Sent '#{ermsg}'"

conn.close
