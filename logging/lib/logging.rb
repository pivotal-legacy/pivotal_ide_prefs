require "logger"

class Logging
  def initialize(logger: Logger.new(STDOUT), logs: [])
    @logger = logger
    @logs = logs
  end

  def start
    @logs.each do |log|
      log = log.new

      logger = @logger

      log.klass.instance_eval do
        define_method("logged_#{log.method_to_log}") do |*args|
          log.before(logger: logger, args: args) if log.respond_to?(:before)
          return_value = send("original_#{log.method_to_log}", *args)
          log.after(logger: logger, args: args) if log.respond_to?(:after)
          return_value
        end

        alias_method "original_#{log.method_to_log}", log.method_to_log
        alias_method log.method_to_log, "logged_#{log.method_to_log}"
      end
    end
  end
end
