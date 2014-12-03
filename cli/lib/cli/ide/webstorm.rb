require "cli/ide/preferences_directory"

module Cli
  module Ide
    class Webstorm
      def user_prefs_repo_location
        preferences_directory = File.expand_path(File.join("~", "Library", "Preferences"))

        PreferencesDirectory.new(
          directories:    Dir.glob(File.join(preferences_directory, "WebStorm*")),
          match_pattern:  /IntelliJIdea.*/,
          default: File.join(preferences_directory, "WebStorm9"),
        ).to_s
      end
    end
  end
end
