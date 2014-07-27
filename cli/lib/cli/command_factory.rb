require "cli"

class Cli::CommandFactory
  def initialize(command_name)
    @command_name = command_name
  end

  def command
    Module.const_get(command_string)
  end

  private
  def command_string
    if @command_name
      "IdePrefs::Commands::#{@command_name.capitalize}Prefs"
    else
      "Cli::DoesNotExistCommand"
    end
  end
end
