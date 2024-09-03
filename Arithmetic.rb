def addition(a, b)
  a + b
end

def subtraction(a, b)
  a - b
end

def division(a, b)
  raise "Division by zero" if b == 0
  a / b
end

def multiply(a, b)
  a * b
end

def modulo(a, b)
  a % b
end

