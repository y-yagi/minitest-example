require "method_source"
require "rgot"
require "minitest"

module Minitest
  class Example < Test
    class << self
      def runnable_methods
        methods_matching(/^example_/)
      end
    end

    def run
      code = self.class.instance_method(self.name).source
      parser = Rgot::ExampleParser.new(code)
      parser.parse
      example = parser.examples.first

      with_info_handler do
        time_it do
          capture_exceptions do
            before_setup; setup; after_setup

            out = capture_stdout do
              self.send self.name
            end

            assert_equal example.output.strip, out.strip
          end

          TEARDOWN_METHODS.each do |hook|
            capture_exceptions do
              self.send hook
            end
          end
        end
      end

      Result.from self # per contract
    end

    def capture_stdout
      original_out = $stdout
      out = StringIO.new
      $stdout = out
      yield
      out.string
    ensure
      $stdout = original_out
    end
  end
end
