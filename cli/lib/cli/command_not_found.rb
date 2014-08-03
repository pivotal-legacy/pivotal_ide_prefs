require "cli"

class Cli::CommandNotFound
  def initialize(*)
  end

  def execute
    puts "Unknown command."
    exit 1
  end
end
