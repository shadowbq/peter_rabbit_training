#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"
require 'securerandom'
SecureRandom.base64.delete('/+=')[0, 8]

conn = Bunny.new(:hostname => "10.5.0.10")
conn.start

channel = conn.create_channel

queue = channel.queue("hello")

msg = "Hello World! => #{SecureRandom.base64.delete('/+=')[0, 8]}"

channel.default_exchange.publish(msg, :routing_key => queue.name)
puts " [x] Sent '#{msg}'"

conn.close
