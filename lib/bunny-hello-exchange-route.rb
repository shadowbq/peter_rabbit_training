#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"
require 'securerandom'
SecureRandom.base64.delete('/+=')[0, 8]

conn = Bunny.new(:hostname => "10.5.0.10")
conn.start
ch = conn.create_channel

x = ch.direct("helloRoutable", :auto_delete => true)
q = ch.queue("hell22")

emsg = "Hello World! (hello exchange) => #{SecureRandom.base64.delete('/+=')[0, 8]}"
ermsg = "Hello World! Routed (hello exchange)=> #{SecureRandom.base64.delete('/+=')[0, 8]}"

x.publish(emsg)
x.publish(ermsg, :routing_key => q.name)

puts " [Ex] Sent '#{emsg}'"
puts " [Ex] Route Sent '#{ermsg}'"

ch.close
conn.close
