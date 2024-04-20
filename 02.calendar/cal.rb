#!/usr/bin/env ruby

require "date"
require 'optparse'

today = Date.today
params = {m:today.mon, y:today.year}

opt = OptionParser.new
opt.on('-m VALUE') {|v| params[:m] = v }
opt.on('-y VALUE') {|v| params[:y] = v }
opt.parse!(ARGV)

month = params[:m].to_i
year = params[:y].to_i
puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"

first_date = Date.new(year, month, 1)
print '   ' * first_date.wday

last_date = Date.new(year, month, -1)
(1..last_date.day).each do |x|
  printf('%2d', x)
  print " "
  if (x + first_date.wday) % 7 == 0
    puts "\n"
  end
  print 
end
puts "\n"

