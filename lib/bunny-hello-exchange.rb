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

msg = "Hello World!  => #{SecureRandom.base64.delete('/+=')[0, 8]}"
emsg = "Hello World! (hello exchange) => #{SecureRandom.base64.delete('/+=')[0, 8]}"

channel.default_exchange.publish(msg)
x.publish(emsg)

puts " [x] Sent '#{msg}'"
puts " [Ex] Sent '#{emsg}'"

conn.close
