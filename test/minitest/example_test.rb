require "test_helper"

class Minitest::ExampleTest < Minitest::Example
  def example_output
    puts "Hello"

    # Output:
    # Hello
  end

  def example_multiple_output
    puts "Hello"
    puts "World"

    # Output:
    # Hello
    # World
  end
end
