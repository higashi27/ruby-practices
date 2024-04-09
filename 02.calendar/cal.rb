#!/usr/bin/env ruby

# -mで月を、-yで年を指定できる
# 引数を指定しない場合は、今月・今年のカレンダーが表示される
require "date"
today = Date.today

params = {}
require 'optparse'
opt = OptionParser.new
opt.on('-m') {|v| params[:m] = v }
opt.on('-y') {|v| params[:y] = v }
opt.parse!(ARGV)

# 引数の指定がなかった時、今年月を表示
if params == {}
    ARGV.push today.mon,today.year
# -m（月）の入力がない時、今月を表示
elsif params[:m] == nil
    ARGV.unshift today.mon
# -y（年）の入力がない時、今年を表示
elsif params[:y] == nil
    ARGV.push today.year
end

# -mと-yの入力順が逆の時、正しく表示されるようにする
if params[:m] == true && params[:y] == true && ARGV[0] > "12"
    ARGV.reverse!
end

# カレンダーの月と年を表示する
month = ARGV[0].to_i
year = ARGV[1].to_i
puts "#{month}月 #{year}".center(20)

# 曜日を表示する
puts "日 月 火 水 木 金 土"

# はじめの空白部分を出力
first_date = Date.new(year, month, 1)
brank_number = first_date.wday
brank_number.times do |y|
    print "   "
end

# 日付を出力
last_date = Date.new(year, month, -1)
(1..last_date.day).each do |x|
    printf('%2d', x)
    print " "
    if (x + brank_number) % 7 == 0
        puts "\n"
    end
    print 
end
puts "\n"

