require "log"

logs = []

Dir[File.expand_path(File.join(__dir__, "logging", "*.rb"))].each do |log_file|
  require log_file
  logs << Module.const_get("Cli::Logging::#{File.basename(log_file).gsub(".rb", "").split("_").map(&:capitalize).join("")}")
end

logger = Logger.new(STDOUT)
logger.progname = "pivotal_ide_prefs"
logger.level = Logger::Severity::INFO
logger.formatter = proc do |severity, datetime, progname, msg|
  "#{progname} #{datetime}: #{severity} - #{msg}\n"
end

Log.new(logs: logs, logger: logger).start
