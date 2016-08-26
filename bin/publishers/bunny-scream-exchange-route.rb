#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"

conn = Bunny.new(:hostname => "10.5.0.10")
conn.start

ch = conn.create_channel
x = ch.direct("helloRoutable", :auto_delete => true)
q = ch.queue("hell22")

msg = "Hello World!"

1.upto 100 do |i|
  print "."
  x.publish("#{msg} =>  #{i}", :routing_key => q.name)
  #channel.default_exchange.publish("#{msg} =>  #{i}", :routing_key => queue.name)
end
puts " [x] Sent 100 '#{msg}'"

ch.close
conn.close
