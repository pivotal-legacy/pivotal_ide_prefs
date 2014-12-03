require "cli/ide/preferences_directory"

module Cli
  module Ide
    class JetBrainsIde
      def user_prefs_repo_location
        preferences_directory = File.expand_path(File.join("~", "Library", "Preferences"))

        PreferencesDirectory.new(
          directories:    Dir.glob(File.join(preferences_directory, "#{ide_pref_dir_name_without_version}*")),
          match_pattern:  /RubyMine.*/,
          default: File.join(preferences_directory, "#{ide_pref_dir_name_without_version}#{default_ide_pref_dir_version}"),
        ).to_s
      end
    end
  end
end

