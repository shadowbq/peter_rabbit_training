#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

conn = Bunny.new(:automatically_recover => false)
conn.start

ch   = conn.create_channel
# Message durability to disk
# This :durable option change needs to be applied to both the producer and consumer code.
q    = ch.queue("task_queue", :durable => true)

msg  = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

# Message durability to disk requires pusblished persistent
q.publish(msg, :persistent => true)
puts " [x] Sent #{msg}"

conn.close
