require 'shoes'
require_relative 'BuiltMathFunctions'
require_relative 'MathFunctions'
require_relative 'Arithmetic'

Shoes.app(title: "Arithmetic Calculator", width: 300, height: 400) do
  # GUI code here
  stack(margin: 10) do
    @num1 = edit_line width: 200
    @num2 = edit_line width: 200
    @result = para "Result: "


    #Arithemetic Operations
    button "+" do
      result = addition(@num1.text.to_f, @num2.text.to_f)
      @result.replace "Result: #{result}"
    end

    button "-" do
      result = subtraction(@num1.text.to_f, @num2.text.to_f)
      @result.replace "Result: #{result}"
    end

    button "*" do
      result = multiply(@num1.text.to_f, @num2.text.to_f)
      @result.replace "Result: #{result}"
    end

    button "/" do
      begin
        result = division(@num1.text.to_f, @num2.text.to_f)
        @result.replace = "Result: #{result}"
      rescue => e
        @result.replace = "Error: #{e.message}"
      end
    end

    button "%" do
      result = modulo(@num1.text.to_f, @num2.text.to_f)
      @result.replace "Result: #{result}"
    end

    # Trigonometric Operations
    # sin, cos, tan
    
    @num3 = edit_line placeholder: "Enter angle for trig functions"
    button "sin" do
      result = sin(@num3.text.to_f)
      @result.replace "Result: #{result}"
    end

    button "cos" do
      result = cos(@num3.text.to_f)
      @result.replace "Result: #{result}"
    end

    button "tan" do
      result = tan(@num3.text.to_f)
      @result.replace "Result: #{result}"
    end
  


    # File Operations
    # generate_square_numbers, generate_even_numbers
    
    @start = edit_line placeholder: "Start number"
    @stop = edit_line placeholder: "Stop number"
    @file_path = edit_line placeholder: "File path"

    button "Generate Square Numbers" do
      generate_square_numbers(@start.text.to_i, @stop.text.to_i, @file_path.text)
      @result.replace "Generated square numbers"
    end

    button "Generate Even Numbers" do
      generate_even_numbers(@start.text.to_i, @stop.text.to_i, @file_path.text)
      @result.replace "Generated even numbers"
    end
  end
end
