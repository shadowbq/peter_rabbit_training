#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"

conn = Bunny.new(:hostname => "10.5.0.10")
conn.start

channel = conn.create_channel

queue = channel.queue("hello")

msg = "Hello World!"

1.upto 100 do |x|
  print "."
  channel.default_exchange.publish("#{msg} =>  #{x}", :routing_key => queue.name)
end
puts " [x] Sent 100 '#{msg}'"

conn.close
