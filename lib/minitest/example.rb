require "method_source"
require "rgot"
require "minitest"

module Minitest
  class Example < Test
    class << self
      def runnable_methods
        methods_matching(/^example_/)
      end

      def run_one_method klass, method_name, reporter
        code = klass.instance_method(method_name).source
        parser = Rgot::ExampleParser.new(code)
        parser.parse
        example = parser.examples.first

        reporter.prerecord klass, method_name
        out = capture_stdout { reporter.record Minitest.run_one_method(klass, method_name) }

        klass.new(method_name).assert_equal example.output.strip, out.strip
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
end
