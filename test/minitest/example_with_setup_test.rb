require "test_helper"

class Minitest::ExampleWithSetupTest < Minitest::Example
  def setup
    @name = "Bob"
  end

  def example_output
    puts "Hello, #{@name}"

    # Output:
    # Hello, Bob
  end
end
