#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = scores.map { |s| s == 'X' ? 10 : s.to_i }

frames = []
shots.each do |shot|
  if frames.size == 10 # 10フレーム目の場合
    frames.last << shot
  elsif frames.last&.sum == 10 # ストライクの場合
    frames << [shot]
  elsif frames.last&.size == 1 # 2投目だった場合
    frames.last << shot
  else
    frames << [shot]
  end
end

point = 0
count = 0
frames.each do |frame|
  count += 1 # 1フレーム後のフレームを指定するための変数
  point += if frame[0] == 10 # ストライクが出たとき
             if count <= 8 && frames[count][0] == 10 # 9,10フレーム目以外の場合かつ次のフレームもストライクの場合
               frame[0] + frames[count][0] + frames[count + 1][0]
             elsif count <= 9 # 9フレーム目の場合 or 9,10フレーム目以外の場合かつ次のフレームがストライク以外の場合
               frame[0] + frames[count][0] + frames[count][1]
             else # 10フレーム目の場合
               frame.sum
             end
           elsif frame.sum == 10 # スペアが出たとき
             if count <= 9 # 10フレーム目以外の場合
               frame.sum + frames[count][0]
             else # 10フレーム目の場合
               frame.sum
             end
           else # ストライクでもスペアでもないとき
             frame.sum
           end
end

puts point
