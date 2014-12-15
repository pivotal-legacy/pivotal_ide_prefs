require "cli/ide/preferences_directory"

module Cli
  module Ide
    class JetBrainsIdeUserPrefDir
      def path
        preferences_directory = File.expand_path(File.join("~", "Library", "Preferences"))

        PreferencesDirectory.new(
          directories:    Dir.glob(File.join(preferences_directory, "#{ide_pref_dir_name_without_version}*")),
          match_pattern:  match_pattern,
          default: File.join(preferences_directory, "#{ide_pref_dir_name_without_version}#{default_ide_pref_dir_version}"),
        ).to_s
      end

      def match_pattern
        Regexp.new("#{ide_pref_dir_name_without_version}.*")
      end
    end
  end
end

