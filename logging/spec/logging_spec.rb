require "logging"

describe Logging do
  it "hooks into methods before and after they're run" do
    run_order = []

    klass_to_log = Class.new do
      define_method(:some_method) do |*args|
        run_order << [:some_method, args]
      end
    end

    log = Class.new do
      define_method(:klass) do
        klass_to_log
      end

      def method_to_log
        :some_method
      end

      define_method(:before) do |logger: nil, args: []|
        run_order << [:before, logger, args]
      end

      define_method(:after) do |logger: nil, args: []|
        run_order << [:after, logger, args]
      end
    end

    logger = double(:logger)
    Logging.new(logger: logger, logs: [log]).start

    arg = double(:arg)
    klass_to_log.new.some_method(arg)

    expect(run_order).to eq [
      [:before, logger, [arg]],
      [:some_method, [arg]],
      [:after, logger, [arg]],
    ]
  end
end
