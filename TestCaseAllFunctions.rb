require_relative 'MathFunctions'
require_relative 'MathFunctions2'
require_relative 'MathFunction3'
require_relative 'MathFunctions4'
require_relative 'Arithmetic'
require_relative 'SquareAndCubeRoots'
require_relative 'BuiltMathFunctions'

methods1 = MathFunctions.new
methods3 = MathFunction3.new
methodsX = BuiltMathFunctions.new
methods2 = MathFunctions2.new
methods4 = MathFunctions4.new

# Test Cases for sin
puts "Test Case for sin:"
puts methodsX.sin(0) == 0.0         # sin(0) should return 0.0
puts methodsX.sin(Math::PI/2) == 1  # sin(pi/2) should return 1.0

# Test Cases for cos
puts "Test Case for cos:"
puts methodsX.cos(0) == 1.0         # cos(0) should return 1.0
puts methodsX.cos(Math::PI) == -1.0 # cos(pi) should return -1.0

# Test Cases for tan
puts "Test Case for tan:"
puts methodsX.tan(0) == 0.0         # tan(0) should return 0.0
puts methodsX.tan(Math::PI/4).round(4) == 1.0 # tan(pi/4) should return 1.0 (approximate)

# Test Cases for isPrime?
puts "Test Case for isPrime:"
puts methods3.isPrime(2) == true   # 2 is prime
puts methods3.isPrime(3) == true   # 3 is prime
puts methods3.isPrime(4) == false  # 4 is not prime
puts methods3.isPrime(17) == true  # 17 is prime
puts methods3.isPrime(18) == false # 18 is not prime

# Test Cases for minimum
puts "Test Case for minimum:"
puts methods3.minimum([3, 1, 4, 1, 5, 9]) == 1   # min in the list is 1
puts methods3.minimum([10, 20, 30]) == 10        # min is 10
puts methods3.minimum([10]) == 10                # single element
puts methods3.minimum([]).nil?                   # empty array should return nil

# Test Cases for generateOddToFile
puts "Test Case for generateOddNumbers:"
methods3.generateOddNumbers(1,10,'test_odd.txt')  # Should generate a file with odd numbers from 1 to 10
odd_file_content = File.read('test_odd.txt').strip
puts odd_file_content == "1 3 5 7 9"    # Test the content of the file

# Test Cases for mode
puts "Test Case for mode:"
puts methods3.mode([1, 2, 3, 3, 4]) == 3  # mode is 3
puts methods3.mode([4, 4, 2, 2, 1]) == 4  # both 4 and 2 appear twice, but 4 comes first
puts methods3.mode([1, 1, 2, 2, 3, 3]) == 1  # all elements have equal frequency, returns the first one
puts methods3.mode([]).nil?              # empty array should return nil


# Test Cases for minimum
puts "Test Case for maximum:"
puts methods4.maximum([3, 1, 4, 1, 5, 9]) == 9   # min in the list is 1
puts methods4.maximum([10, 20, 30]) == 30       # min is 10
puts methods4.maximum([10]) == 10                # single element
puts methods4.maximum([]).nil?                   # empty array should return nil

# Test Cases for mode
puts "Test Case for mean:"
puts methods4.mean([9, 10, 12, 13, 13]) == 11.4 # mode is 3
puts methods4.mean([1, 3, 6, 7]) == 4.25  # both 4 and 2 appear twice, but 4 comes first
puts methods4.mean([1, 1, 6, 7, 8]) == 4.6 # all elements have equal frequency, returns the first one
puts methods4.mean([]).nil?  

puts "Test Case for fToC:"
puts methods4.fahrenheit_to_celsius(32) == 0.0 # 32°F is 0°C
puts methods4.fahrenheit_to_celsius(212) == 100.0 # 212°F is 100°C
puts methods4.fahrenheit_to_celsius(98.6) == 37.0 # 98.6°F is 37°C
puts methods4.fahrenheit_to_celsius(68) == 20.0 # 68°F is 20°C

puts "Test Case for hexadecimal:"
puts methods2.to_hexadecimal(10) == "a" # 10 in hexadecimal is a
puts methods2.to_hexadecimal(15) == "f" # 15 in hexadecimal is f
puts methods2.to_hexadecimal(16) == "10" # 16 in hexadecimal is 10
puts methods2.to_hexadecimal(255) == "FF" # 255 in hexadecimal is FF

puts "Test Case for octal:"
puts methods2.to_octal(10) == "12" # 10 in octal is 12
puts methods2.to_octal(15) == "17" # 15 in octal is 17
puts methods2.to_octal(16) == "20" # 16 in octal is 20
puts methods2.to_octal(255) == "377" # 255 in octal is 377

puts "Test Case for binary:"
puts methods2.to_binary(10) == "1010" # 10 in binary is 1010
puts methods2.to_binary(15) == "1111" # 15 in binary is 1111
puts methods2.to_binary(16) == "10000" # 16 in binary is 10000
puts methods2.to_binary(255) == "11111111" # 255 in binary is 11111111

puts "Test Case for generate_primes:"
puts methods2.generate_primes(10, 'test_primes.txt') # Should generate a file with prime numbers less than 10
prime_file_content = File.read('test_primes.txt').strip
puts prime_file_content == "2\n3\n5\n7" # Test the content of the file
puts methods2.generate_primes(1, 'test_primes.txt') # Should generate a file with prime numbers less than 1

puts "Test Case for generate_even_numbers"
puts methods1.generate_even_numbers(1, 10, 'test_even.txt') # Should generate a file with even numbers from 1 to 10
even_file_content = File.read('test_even.txt').strip
puts even_file_content == "2\n4\n6\n8\n10" # Test the content of the file
