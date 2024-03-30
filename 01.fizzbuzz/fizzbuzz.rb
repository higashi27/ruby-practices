# 3の倍数のときは数の代わりに｢Fizz｣
# 5の倍数のときは｢Buzz｣
# 3と5両方の倍数の場合には｢FizzBuzz｣とプリントすること。

x = 1
20.times.each do |x|
    if x % 15 ==0
        puts "FizzBuzz"
    elsif x % 3 == 0
        puts "Fizz"
    elsif x % 5 == 0
        puts "Buzz"
    else 
        puts x
    end
end
