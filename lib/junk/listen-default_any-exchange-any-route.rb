#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"

conn = Bunny.new(:hostname => '10.5.0.10', :automatically_recover => false)
conn.start

ch   = conn.create_channel
q    = ch.queue("hellorb")

begin
  puts " [*] Waiting for messages. To exit press CTRL+C"
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] Received #{body}"
    puts "    [i] Exchange: #{delivery_info.exchange}"
    puts "    [i] Routing Key: #{delivery_info.routing_key}"
  end
rescue Interrupt => _
  conn.close

  exit(0)
end
