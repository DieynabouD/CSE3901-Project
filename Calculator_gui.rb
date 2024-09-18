require 'tk'
require_relative 'MathFunctions'
require_relative 'Arithmetic'
require_relative 'BuiltMathFunctions'
require_relative 'MathFunctions2'
require_relative 'MathFunctions4'
require_relative 'SquareAndCubeRoots'
require_relative 'MathFunction3'
# Create the main window

root = TkRoot.new { title "Advanced Calculator" 
background "pink" }
root.minsize(600, 800)

# Create a text variable to hold the expression entered by the user
input_var = TkVariable.new

# Create a label to display the result
result_var = TkVariable.new("Result: ") 

# Entry field where the user enters the expression
TkEntry.new(root, 'textvariable' => input_var, 'font' => 'Arial 15 bold', 'justify' => 'right').pack('side' => 'top', 'fill' => 'x')

# Label to show the result
TkLabel.new(root, 'textvariable' => result_var, 'font' => 'Arial 15 bold', 'background' => 'pink' ).pack('side' => 'top')

# Evaluate expressions, including handling parentheses and operator precedence
def evaluate_expression(input_var, result_var)
  expression = input_var.value

  # Function to perform basic arithmetic
  def apply_operator(operator, a, b)
    case operator
    when '+'
      return addition(a, b)
    when '-'
      return subtraction(a, b)
    when '*'
      return multiply(a, b)
    when '/'
      if b == 0
        raise "Division by zero"
      else
      return division(a, b)
      end
    when '^'
      return exponent(a, b)
    when '%'
      return modulo(a, b)
    else
      raise "Unsupported operator #{operator}"
    end
  end

  # Function to handle parentheses recursively
  def evaluate_parentheses(expression)
    while expression.include?('(')
      expression.sub!(/\([^()]*\)/) do |sub_expr|
        evaluate_basic(sub_expr[1..-2])  # Remove parentheses and evaluate
      end
    end
    evaluate_basic(expression)  # Evaluate the remaining expression
  end

  # Function to evaluate expressions without parentheses, considering operator precedence
  def evaluate_basic(expression)
    # Handle multiplication, division, exponentiation, and modulus first (operator precedence)
    while expression =~ /[\*\^\/%]/
      expression.gsub!(/(-?\d+\.?\d*)([\*\^\/%])(-?\d+\.?\d*)/) do
        a = $1.to_f
        op = $2
        b = $3.to_f
        apply_operator(op, a, b)
      end
    end

    # Handle arithmetic addition and subtraction
    while expression =~ /(-?\d+\.?\d*)([\+\-])(-?\d+\.?\d*)/
      expression.gsub!(/(-?\d+\.?\d*)([\+\-])(-?\d+\.?\d*)/) do
        a = $1.to_f
        op = $2
        b = $3.to_f
        apply_operator(op, a, b)
      end
    end

    expression.to_f
  end

  # Start by evaluating parentheses, then the rest
  result = evaluate_parentheses(expression)
  result_var.value = "Result: #{result}"
end

# Append to the expression when a button is pressed
def append_expression(input_var, value)
  input_var.value = input_var.value + value
end

# Clear the expression
def clear_expression(input_var, result_var)
  input_var.value = ""
  result_var.value = "Result: "
end

button_width = 6
button_height = 3

# Create the buttons for the calculator (numbers and operations)
button_frame = TkFrame.new(root, 'background' => 'pink').pack('side' => 'top', 'fill' => 'x')


# Buttons for digits 1-9, 0, and operators
buttons = [
  ['7', '8', '9', '/', 'sin'],
  ['4', '5', '6', '*', 'cos'],
  ['1', '2', '3', '-', 'tan'],
  ['0', '.', '=', '+', 'C'],
  ['|x|', '%', '^', 'Evens', 'Odds'],
  ['Squares', 'Primes', 'Binary', 'Octal', 'Hexadecimal'], 
  ['FtoC', 'isPrime', 'Fibonacci', 'log(base,a)'],
  ['Mean', 'Min', 'Max', 'Modes', 'Median'],
  ['SquareRoot', 'CubeRoot', '(', ')']
]

buttons.each do |row|
  row_frame = TkFrame.new(button_frame, 'background' => 'pink').pack('side' => 'top', 'fill' => 'x')
  row.each do |char|
    TkButton.new(row_frame) do
      text char
      width button_width
      height button_height
      font 'Arial 15'
      background 'light pink'

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
      #when odd button is clicked
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
      when 'Modes'
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
              # Show the result in a message box
              Tk.messageBox(
                'type'    => "ok",
                'icon'    => "info",
                'title'   => "Mode Result",
                'message' => "The mode of the dataset is: #{mode(dataset)}"
              )
            end
          end.pack
        end
      # when 'Primes'
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
          # Button to save and generate prime numbers
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
      else
        command { append_expression(input_var, char) }
      end
    end.pack('side' => 'left')
  end
end

Tk.mainloop