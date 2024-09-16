require 'tk'
require_relative 'MathFunctions'
require_relative 'Arithmetic'
require_relative 'BuiltMathFunctions'
require_relative 'MathFunctions2'

# Create the main window
root = TkRoot.new { title "Advanced Calculator" }
root.minsize(600, 800)

# Create a text variable to hold the expression entered by the user
input_var = TkVariable.new

# Create a label to display the result
result_var = TkVariable.new("Result: ")

# Entry field where the user enters the expression
TkEntry.new(root, 'textvariable' => input_var, 'font' => 'Arial 20', 'justify' => 'right').pack('side' => 'top', 'fill' => 'x')

# Label to show the result
TkLabel.new(root, 'textvariable' => result_var, 'font' => 'Arial 20').pack('side' => 'top')

# evaluate basic arithmetic expressions 
def evaluate_expression(input_var, result_var)
  expression = input_var.value
  numbers = expression.scan(/\d+\.?\d*/).map(&:to_f)  # Extract numbers as floats
  operators = expression.scan(/[\+\-\*\/\^\%]/)  # Extract operators, including ^ and %
  result = numbers.shift  # Initialize the result with the first number
  
  operators.each_with_index do |op, i|
    case op
    when '+'
      result = addition(result, numbers[i])
    when '-'
      result = subtraction(result, numbers[i])
    when '*'
      result = multiply(result, numbers[i])
    when '/'
      result = division(result, numbers[i])
    when '^'
      result = exponent(result, numbers[i])
    when '%'
      result = modulo(result, numbers[i])
    end
  end

  # Display the result
  result_var.value = "Result: #{result}"
end

# append to the expression when a button is pressed
def append_expression(input_var, value)
  input_var.value = input_var.value + value
end

# clear the expression
def clear_expression(input_var, result_var)
  input_var.value = ""
  result_var.value = "Result: "
end

button_width = 6
button_height = 3

# Create the buttons for the calculator (numbers and operations)
button_frame = TkFrame.new(root).pack('side' => 'top', 'fill' => 'x')

# Buttons for digits 1-9, 0, and operators
buttons = [
  ['7', '8', '9', '/'],
  ['4', '5', '6', '*'],
  ['1', '2', '3', '-'],
  ['0', '.', '=', '+'],
  ['^', 'sin', 'cos', 'tan'],
  ['|x|', '%', 'C', 'Even'],
  ['Squares', 'Primes', 'Binary', 'Octal', 'Hexadecimal'],
  ['Median'] 
]

buttons.each do |row|
  row_frame = TkFrame.new(button_frame).pack('side' => 'top', 'fill' => 'x')
  row.each do |char|
    TkButton.new(row_frame) do
      text char
      width button_width
      height button_height
      font 'Arial 20'

      case char
      when '='
        command { evaluate_expression(input_var, result_var) }
      when 'C'
        command { clear_expression(input_var, result_var) }
      when 'sin', 'cos', 'tan', '|x|', 'Square', 'Even'
        command do
          case char
          when 'sin'
            result_var.value = "Result: #{sin(input_var.value.to_f)}"
          when 'cos'
            result_var.value = "Result: #{cos(input_var.value.to_f)}"
          when 'tan'
            result_var.value = "Result: #{tan(input_var.value.to_f)}"
          when '|x|'
            result_var.value = "Result: #{absolute(input_var.value.to_f)}"
          end
        end
      when 'Squares'
        command do
          dialog = TkToplevel.new
          dialog.title = "Generate Squares"

          TkLabel.new(dialog) { text "Enter Starting Number" }.pack
          start_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => start_num_var).pack

          TkLabel.new(dialog) { text "Enter Ending Number" }.pack
          end_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => end_num_var).pack

          TkButton.new(dialog) do
            text "Save and Generate Squares"
            command do
              file_path = Tk.getSaveFile(
                'title' => 'Save squares to file',
                'defaultextension' => '.txt',
                'filetypes' => [['Text Files', '*.txt'], ['All Files', '*']]
              )

              if file_path
                generate_square_numbers(start_num_var.value.to_i, end_num_var.value.to_i, file_path)
                result_var.value = "Square numbers generated and saved to #{file_path}"
              end
              dialog.destroy
            end
          end.pack
        end
      when 'Primes'
        command do
          dialog = TkToplevel.new
          dialog.title = "Generate Primes"

          TkLabel.new(dialog) { text "Enter Maximum Number" }.pack
          max_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => max_num_var).pack

          TkButton.new(dialog) do
            text "Save and Generate Primes"
            command do
              file_path = Tk.getSaveFile(
                'title' => 'Save primes to file',
                'defaultextension' => '.txt',
                'filetypes' => [['Text Files', '*.txt'], ['All Files', '*']]
              )

              if file_path
                generate_primes(max_num_var.value.to_i, file_path)
                result_var.value = "Prime numbers generated and saved to #{file_path}"
              end
              dialog.destroy
            end
          end.pack
        end
      when 'Binary'
        command do
          result_var.value = "Binary: #{to_binary(input_var.value.to_i)}"
        end
      when 'Octal'
        command do
          result_var.value = "Octal: #{to_octal(input_var.value.to_i)}"
        end
      when 'Hexadecimal'
        command do
          result_var.value = "Hexadecimal: #{to_hexadecimal(input_var.value.to_i)}"
        end
      when 'Median' # Median button command
        command do
          dialog = TkToplevel.new
          dialog.title = "Calculate Median"

          TkLabel.new(dialog) { text "Enter Dataset (comma-separated)" }.pack
          data_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => data_var).pack

          TkButton.new(dialog) do
            text "Calculate Median"
            command do
              data = data_var.value.split(',').map(&:to_f)
              median_value = median(data)
              result_var.value = "Median: #{median_value}"
              dialog.destroy
            end
          end.pack
        end
      else
        command { append_expression(input_var, char) }
      end
    end.pack('side' => 'left')
  end
end

# Start the Tk main loop
Tk.mainloop
