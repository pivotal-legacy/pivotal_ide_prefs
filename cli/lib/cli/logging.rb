require "log"

logs = []

Dir[File.expand_path(File.join(__dir__, "logging", "*.rb"))].each do |log_file|
  require log_file
  logs << Module.const_get("Cli::Logging::#{File.basename(log_file).gsub(".rb", "").split("_").map(&:capitalize).join("")}")
end

require "cli"

Cli::Logger = Class.new do
  LOGS = logs

  def initialize(log_level: :info)
    @log_level = log_level
  end

  def start
    logger = Logger.new(STDOUT)
    logger.progname = "pivotal_ide_prefs"
    logger.level = Module.const_get("Logger::Severity::#{@log_level.upcase}")
    logger.formatter = proc do |severity, datetime, progname, msg|
      "#{progname} #{datetime}: #{severity} - #{msg}\n"
    end

    Log.new(logs: LOGS, logger: logger).start
  end
end
