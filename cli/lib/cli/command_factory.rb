require "cli"

class Cli::CommandFactory
  def initialize(command_name)
    @command_name = command_name
  end

  def command
    begin
      Module.const_get(command_string)
    rescue
      Cli::CommandNotFound
    end
  end

  private
  def command_string
    if @command_name
      "IdePrefs::Commands::#{@command_name.capitalize}Prefs"
    else
      "Cli::CommandNotSpecified"
    end
  end
end
