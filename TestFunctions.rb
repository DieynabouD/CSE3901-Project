require_relative 'MathFunctions'
require_relative 'MathFunctions2'
require_relative 'MathFunction3'
require_relative 'MathFunctions4'
require_relative 'Arithmetic'
require_relative 'SquareAndCubeRoots'
require_relative 'BuiltMathFunctions'



# Test Cases for sin
puts "Test Case for sin:"
puts sin(0) == 0.0         # sin(0) should return 0.0
puts sin(Math::PI/2) == 1  # sin(pi/2) should return 1.0

# Test Cases for cos
puts "Test Case for cos:"
puts cos(0) == 1.0         # cos(0) should return 1.0
puts cos(Math::PI) == -1.0 # cos(pi) should return -1.0

# Test Cases for tan
puts "Test Case for tan:"
puts tan(0) == 0.0         # tan(0) should return 0.0
puts tan(Math::PI/4).round(4) == 1.0 # tan(pi/4) should return 1.0 (approximate)

# Test Cases for isPrime?
puts "Test Case for isPrime:"
puts isPrime(2) == true   # 2 is prime
puts isPrime(3) == true   # 3 is prime
puts isPrime(4) == false  # 4 is not prime
puts isPrime(17) == true  # 17 is prime
puts isPrime(18) == false # 18 is not prime

# Test Cases for minimum
puts "Test Case for minimum:"
puts minimum([3, 1, 4, 1, 5, 9]) == 1   # min in the list is 1
puts minimum([10, 20, 30]) == 10        # min is 10
puts minimum([10]) == 10                # single element
puts minimum([]).nil?                   # empty array should return nil

# Test Cases for generateOddToFile
puts "Test Case for generateOddNumbers:"
generateOddNumbers(1,10,'test_odd.txt')  # Should generate a file with odd numbers from 1 to 10
odd_file_content = File.read('test_odd.txt').strip
puts odd_file_content == "1 3 5 7 9"    # Test the content of the file

# Test Cases for mode
puts "Test Case for mode:"
puts mode([1, 2, 3, 3, 4]) == 3  # mode is 3
puts mode([4, 4, 2, 2, 1]) == 4  # both 4 and 2 appear twice, but 4 comes first
puts mode([1, 1, 2, 2, 3, 3]) == 1  # all elements have equal frequency, returns the first one
puts mode([]).nil?              # empty array should return nil


# Test Cases for minimum
puts "Test Case for maximum:"
puts maximum([3, 1, 4, 1, 5, 9]) == 9   # min in the list is 1
puts maximum([10, 20, 30]) == 30       # min is 10
puts maximum([10]) == 10                # single element
puts maximum([]).nil?                   # empty array should return nil

# Test Cases for mode
puts "Test Case for mean:"
puts mean([9, 10, 12, 13, 13]) == 11.4 # mode is 3
puts mean([1, 3, 6, 7]) == 4.25  # both 4 and 2 appear twice, but 4 comes first
puts mean([1, 1, 6, 7, 8]) == 4.6 # all elements have equal frequency, returns the first one
puts mean([]).nil?  

puts "Test Case for fToC:"
puts fahrenheit_to_celsius(32) == 0.0 # 32°F is 0°C
puts fahrenheit_to_celsius(212) == 100.0 # 212°F is 100°C
puts fahrenheit_to_celsius(98.6) == 37.0 # 98.6°F is 37°C
puts fahrenheit_to_celsius(68) == 20.0 # 68°F is 20°C

puts "Test Case for hexadecimal:"
puts to_hexadecimal(10) == "a" # 10 in hexadecimal is a
puts to_hexadecimal(15) == "f" # 15 in hexadecimal is f
puts to_hexadecimal(16) == "10" # 16 in hexadecimal is 10
puts to_hexadecimal(255) == "FF" # 255 in hexadecimal is FF

puts "Test Case for octal:"
puts to_octal(10) == "12" # 10 in octal is 12
puts to_octal(15) == "17" # 15 in octal is 17
puts to_octal(16) == "20" # 16 in octal is 20
puts to_octal(255) == "377" # 255 in octal is 377

puts "Test Case for binary:"
puts to_binary(10) == "1010" # 10 in binary is 1010
puts to_binary(15) == "1111" # 15 in binary is 1111
puts to_binary(16) == "10000" # 16 in binary is 10000
puts to_binary(255) == "11111111" # 255 in binary is 11111111

puts "Test Case for generate_primes:"
puts generate_primes(10, 'test_primes.txt') # Should generate a file with prime numbers less than 10
prime_file_content = File.read('test_primes.txt').strip
puts prime_file_content == "2\n3\n5\n7" # Test the content of the file

puts "Test Case for generate_even_numbers"
puts generate_even_numbers(1, 10, 'test_even.txt') # Should generate a file with even numbers from 1 to 10
even_file_content = File.read('test_even.txt').strip
puts even_file_content == "2\n4\n6\n8\n10" # Test the content of the file

puts "Test Case for generate_square_numbers"
puts generate_square_numbers(1, 5, 'test_square.txt') # Should generate a file with square numbers from 1 to 5
square_file_content = File.read('test_square.txt').strip
puts square_file_content == "1\n4\n9\n16\n25" # Test the content of the file

puts "Test Case for exponent"
puts exponent(2, 3) == 8 # 2^3 is 8
puts exponent(3, 2) == 9 # 3^2 is 9
puts exponent(4, 0) == 1 # 4^0 is 1
puts exponent(0, 4) == 0 # 0^4 is 0

puts "Test Case for quotient"
puts quotient(10, 2) == 5 # 10/2 is 5
puts quotient(15, 3) == 5 # 15/3 is 5
puts quotient(20, 4) == 5 # 20/4 is 5
puts quotient(0, 5) == 0 # 0/5 is 0

puts "Test Case for product"
puts product(2, 3) == 6 # 2*3 is 6
puts product(4, 5) == 20 # 4*5 is 20
puts product(6, 7) == 42 # 6*7 is 42
puts product(0, 8) == 0 # 0*8 is 0

puts "Test Case for difference"
puts difference(10, 2) == 8 # 10-2 is 8
puts difference(15, 3) == 12 # 15-3 is 12
puts difference(20, 4) == 16 # 20-4 is 16
puts difference(0, 5) == -5 # 0-5 is -5

puts "Test Case for sum"
puts sum(2, 3) == 5 # 2+3 is 5
puts sum(4, 5) == 9 # 4+5 is 9
puts sum(6, 7) == 13 # 6+7 is 13
puts sum(0, 8) == 8 # 0+8 is 8

puts "Test Case for cube"
puts cubeRoot(2) == 8 # 2^3 is 8
puts cubeRoot(3) == 27 # 3^3 is 27
puts cubeRoot(4) == 64 # 4^3 is 64
puts cubeRoot(0) == 0 # 0^3

puts "Test Case for square"
puts squareRoot(2) == 1.4142135623730951 # sqrt(2) is 1.4142135623730951
puts squareRoot(3) == 1.7320508075688772 # sqrt(3) is 1.7320508075688772
puts squareRoot(4) == 2.0 # sqrt(4) is 2.0
puts squareRoot(0) == 0.0 # sqrt(0) is 0.0

puts "Test Case for median"
puts median([1, 2, 3, 4, 5]) == 3 # median is 3
puts median([1, 2, 3, 4, 5, 6]) == 3.5 # median is 3.5
puts median([1, 2, 3, 4, 5, 6, 7]) == 4 # median is 4
puts median([1, 2, 3, 4, 5, 6, 7, 8]) == 4.5 # median is 4.5

puts "Test Case for Fibonacci"
puts fibonacci(10, 'test_fib.txt') # Should generate a file with first 10 Fibonacci numbers
fib_file_content = File.read('test_fib.txt').strip
puts fib_file_content == "0\n1\n1\n2\n3\n5\n8\n13\n21\n34" # Test the content of the file