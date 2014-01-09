#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"

conn = Bunny.new(:hostname => "10.5.0.10")
conn.start

channel = conn.create_channel
x = channel.fanout("hello", :auto_delete => true)
queue = channel.queue("hellorb")

msg = "Hello World!"

1.upto 100 do |i|
  print "."
  x.publish("#{msg} =>  #{i}", :routing_key => queue.name)
  #channel.default_exchange.publish("#{msg} =>  #{i}", :routing_key => queue.name)
end
puts " [x] Sent 100 '#{msg}'"

conn.close
