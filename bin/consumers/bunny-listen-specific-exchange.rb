#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"

conn = Bunny.new(:hostname => '127.0.0.1', :automatically_recover => false)
conn.start

ch   = conn.create_channel
x    = ch.fanout("hello", :auto_delete => true)
q    = ch.queue("", :exclusive => true)

q.bind(x)

begin
  puts " [*] Waiting for messages. To exit press CTRL+C"
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] Received #{body}"
    puts "    [i] Exchange: #{delivery_info.exchange}"
    puts "    [i] Routing Key: #{delivery_info.routing_key}"
    # puts " [x] Delivery #{properties}"
  end
rescue Interrupt => _
  ch.close
  conn.close

  exit(0)
end
