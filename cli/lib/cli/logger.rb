require "logging"
require "cli"

class Cli::Logger
  LOGS = []

  Dir[File.expand_path(File.join(__dir__, "logging", "*.rb"))].each do |log_file|
    require log_file
    LOGS.unshift Module.const_get("Cli::Logging::#{File.basename(log_file).gsub(".rb", "").split("_").map(&:capitalize).join("")}")
  end

  def initialize(log_level: :info)
    @log_level = log_level
  end

  def start
    Logging.new(logs: LOGS, logger: logger).start
  end

  private
  def logger
    @logger ||= begin
      logger = Logger.new(STDOUT)
      logger.progname = "pivotal_ide_prefs"
      logger.level = Module.const_get("Logger::Severity::#{@log_level.upcase}")
      logger.formatter = proc do |severity, datetime, progname, msg|
        "#{progname} #{datetime}: #{severity} - #{msg}\n"
      end

      logger
    end
  end
end
