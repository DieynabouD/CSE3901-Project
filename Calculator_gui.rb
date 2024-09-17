require 'tk'
require_relative 'MathFunctions'
require_relative 'Arithmetic'
require_relative 'BuiltMathFunctions'
require_relative 'MathFunctions2'
require_relative 'MathFunctions4'
require_relative 'MathFunction3'
require_relative 'SquareAndCubeRoots'

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

button_width = 5
button_height = 1

# Create the buttons for the calculator (numbers and operations)
button_frame = TkFrame.new(root).pack('side' => 'top', 'fill' => 'x')

# Buttons for digits 1-9, 0, and operators
buttons = [
  ['7', '8', '9', '/', 'sin'],
  ['4', '5', '6', '*', 'cos'],
  ['1', '2', '3', '-', 'tan'],
  ['0', '.', '=', '+', 'C'],
  ['|x|', '%', '^', 'Evens', 'Odds'],
  ['Squares', 'Primes', 'Binary', 'Octal', 'Hexadecimal'], 
  ['FtoC', 'isPrime', 'Fibonacci', 'log(base,a)', 'Factorial'],
  ['Mean', 'Min', 'Max', 'Mode', 'Median'],
  ['SquareRoot', 'CubeRoot', '(', ')']
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
      when 'sin', 'cos', 'tan', '|x|', 'FtoC', 'SquareRoot', 'CubeRoot'
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
          when 'FtoC'
            result_var.value = "Result: #{fahrenheit_to_celsius(input_var.value.to_f)}"
          when 'SquareRoot'
            result_var.value = "Result: #{squareRoot(input_var.value.to_f)}"
          when 'CubeRoot'
            result_var.value = "Result: #{cubeRoot(input_var.value.to_f)}"
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
      when 'Evens'
        command do
          dialog = TkToplevel.new
          dialog.title = "Generate Even Numbers"

          TkLabel.new(dialog) { text "Enter Starting Number" }.pack
          start_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => start_num_var).pack

          TkLabel.new(dialog) { text "Enter Ending Number" }.pack
          end_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => end_num_var).pack

          TkButton.new(dialog) do
            text "Save and Generate Evens"
            command do
              file_path = Tk.getSaveFile(
                'title' => 'Save evens to file',
                'defaultextension' => '.txt',
                'filetypes' => [['Text Files', '*.txt'], ['All Files', '*']]
              )

              if file_path
                generate_even_numbers(start_num_var.value.to_i, end_num_var.value.to_i, file_path)
                result_var.value = "Even numbers generated and saved to #{file_path}"
              end
              dialog.destroy
            end
          end.pack
        end
      when 'Odds' 
        command do
          dialog = TkToplevel.new
          dialog.title = "Generate Odd Numbers"

          TkLabel.new(dialog) { text "Enter Starting Number" }.pack
          start_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => start_num_var).pack

          TkLabel.new(dialog) { text "Enter Ending Number" }.pack
          end_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => end_num_var).pack

          TkButton.new(dialog) do
            text "Save and Generate Odds"
            command do
              file_path = Tk.getSaveFile(
                'title' => 'Save odds to file',
                'defaultextension' => '.txt',
                'filetypes' => [['Text Files', '*.txt'], ['All Files', '*']]
              )

              if file_path
                generateOddNumbers(start_num_var.value.to_i, end_num_var.value.to_i, file_path)
                result_var.value = "Odd numbers generated and saved to #{file_path}"
              end
              dialog.destroy
            end
          end.pack
        end
      when 'Min'
        command do
          # Create a new dialog to prompt for dataset input
          dialog = TkToplevel.new
          dialog.title = "Enter your dataset"
          # Label and entry for dataset input
          TkLabel.new(dialog) { text "Enter numbers separated by commas:" }.pack
          dataset_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => dataset_var).pack
          # "Next" button to calculate the mode
          TkButton.new(dialog) do
            text "Next"
            command do
              dataset = dataset_var.value.split(',').map(&:to_i)
              min_value = minimum(dataset)
              # Show the result in a message box
              Tk.messageBox(
                'type'    => "ok",
                'icon'    => "info",
                'title'   => "Minimum",
                'message' => "The minimum of the dataset is: #{min_value}"
              )
            end
          end.pack
        end
      when 'Max' # Max button command
        command do
          dialog = TkToplevel.new
          dialog.title = "Find Maximum"
          TkLabel.new(dialog) { text "Enter Dataset (comma-separated)" }.pack
          data_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => data_var).pack

          TkButton.new(dialog) do
            text "Find Maximum"
            command do
              data = data_var.value.split(',').map(&:to_f)
              max_value = maximum(data)
              result_var.value = "Maximum: #{max_value}"
              dialog.destroy
            end
          end.pack
        end
      when 'Mode'
        command do
          # Create a new dialog to prompt for dataset input
          dialog = TkToplevel.new
          dialog.title = "Enter your dataset"
          # Label and entry for dataset input
          TkLabel.new(dialog) { text "Enter numbers separated by commas:" }.pack
          dataset_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => dataset_var).pack
          # "Next" button to calculate the mode
          TkButton.new(dialog) do
            text "Next"
            command do
              dataset = dataset_var.value.split(',').map(&:to_i)
              mode_value = mode(dataset)
              # Show the result in a message box
              Tk.messageBox(
                'type'    => "ok",
                'icon'    => "info",
                'title'   => "Mode Result",
                'message' => "The mode of the dataset is: #{mode_value}"
              )
            end
          end.pack
        end
      when 'isPrime'
        command do
          result_var.value = "Check is Prime: #{isPrime(input_var.value.to_i)}"
        end
      when 'log(base,a)'
        command do
          dialog = TkToplevel.new
          dialog.title = "Calculate log with base"

          TkLabel.new(dialog) { text "Enter Base Number" }.pack
          start_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => start_num_var).pack

          TkLabel.new(dialog) { text "Enter Second Number" }.pack
          end_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => end_num_var).pack

          TkButton.new(dialog) do
            text "Calculate"
            command do
                result_var.value = "#{log_with_base(end_num_var.value.to_f, start_num_var.value.to_f)}"

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
      when 'Fibonacci'
        command do
          dialog = TkToplevel.new
          dialog.title = "Generate Fibonacci sequence up to limit"
      
          TkLabel.new(dialog) { text "Enter Limit Number" }.pack
          lim_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => lim_num_var).pack
      
          TkButton.new(dialog) do
            text "Save and Generate Fibonacci"
            command do
              file_path = Tk.getSaveFile(
                'title' => 'Save Fibonacci to file',
                'defaultextension' => '.txt',
                'filetypes' => [['Text Files', '*.txt'], ['All Files', '*']]
              )
      
              if file_path
                fibonacci(lim_num_var.value.to_i, file_path)
                result_var.value = "Fibonacci sequence generated and saved to #{file_path}"
              end
              dialog.destroy
            end
          end.pack
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
      when 'Mean' # Mean button command
        command do
          dialog = TkToplevel.new
          dialog.title = "Calculate Mean"

          TkLabel.new(dialog) { text "Enter Dataset (comma-separated)" }.pack
          data_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => data_var).pack

          TkButton.new(dialog) do
            text "Calculate Mean"
            command do
              data = data_var.value.split(',').map(&:to_f)
              mean_value = mean(data)
              result_var.value = "Mean: #{mean_value}"
              dialog.destroy
            end
          end.pack
        end
      when 'Factorial' 
        command do
          dialog = TkToplevel.new
          dialog.title = "Calculate Factorial"

          TkLabel.new(dialog) { text "Enter a Non-Negative Integer" }.pack
          n_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => n_var).pack

          TkButton.new(dialog) do
            text "Calculate Factorial"
            command do
              n = n_var.value.to_i
              result_var.value = "Factorial: #{factorial(n)}"
              dialog.destroy
            end
          end.pack
        end
      when '%'
        command do
          dialog = TkToplevel.new
          dialog.title = "Calculate Percentage"

          TkLabel.new(dialog) { text "Enter Value (a)" }.pack
          a_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => a_var).pack

          TkLabel.new(dialog) { text "Enter Value (b)" }.pack
          b_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => b_var).pack

          TkButton.new(dialog) do
            text "Calculate Percentage"
            command do
              a = a_var.value.to_f
              b = b_var.value.to_f
              result_var.value = "Percentage: #{percentage(a, b)}%"
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
