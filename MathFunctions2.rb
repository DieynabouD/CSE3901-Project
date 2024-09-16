# factorial(n): Returns the factorial of a non-negative integer n.
def factorial(n)
    if n == 0
        return 1
    else
        return n * factorial(n - 1)
    end
    end

#percentage (a, b) : Calculates what percentage a is of b.
def percentage(a, b)
    return (a / b.to_f) * 100
end

#median(data): Calculates the median of a dataset.
def median(data)
    sorted_data = data.sort
    n = data.length
    if n % 2 == 1
        return sorted_data[n / 2]
    else
        return (sorted_data[n / 2 - 1] + sorted_data[n / 2]) / 2.0
    end
end

#Generate all prime numbers less than a given number and save them to a file.
def generate_primes(n, file_path)
    File.open(file_path, 'w') do |file|
        (2..n).each do |num|
            prime = true
            (2..Math.sqrt(num)).each do |i|
                if num % i == 0
                    prime = false
                    break
                end
            end
            file.puts(num) if prime
        end
    end
end
