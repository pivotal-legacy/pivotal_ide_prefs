require "cli/ide/preferences_directory"

module Cli
  module Ide
    class RubymineUserPrefDir < JetBrainsIdeUserPrefDir
      def ide_pref_dir_name_without_version
        "RubyMine"
      end

      def default_ide_pref_dir_version
        "80"
      end
    end
  end
end
