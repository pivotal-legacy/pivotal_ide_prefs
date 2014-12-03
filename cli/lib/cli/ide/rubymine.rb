require "cli/ide/preferences_directory"

module Cli
  module Ide
    class Rubymine
      def user_prefs_repo_location
        preferences_directory = File.expand_path(File.join("~", "Library", "Preferences"))

        PreferencesDirectory.new(
          directories:    Dir.glob(File.join(preferences_directory, "*")),
          match_pattern:  /RubyMine.*/,
          default: File.join(preferences_directory, "RubyMine70"),
        ).to_s
      end
    end
  end
end
