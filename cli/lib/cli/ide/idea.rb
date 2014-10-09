require "cli/ide/preferences_directory"

module Cli
  module Ide
    class Idea
      def user_prefs_repo_location
        preferences_directory = File.expand_path(File.join("~", "Library", "Preferences"))

        PreferencesDirectory.new(
            directories:    Dir.glob(File.join(preferences_directory, "IdeaIC*")),
            match_pattern:  /IdeaIC.*/,
            default:        File.join(preferences_directory, "IdeaIC13"),
        ).to_s
      end
    end
  end
end
