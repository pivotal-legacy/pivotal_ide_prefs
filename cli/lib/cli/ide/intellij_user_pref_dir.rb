require "cli/ide/jet_brains_ide_user_pref_dir"

module Cli
  module Ide
    class IntellijUserPrefDir < JetBrainsIdeUserPrefDir
      def ide_pref_dir_name_without_version
        "IntelliJIdea"
      end

      def match_pattern
        /IntelliJIdea.*/
      end

      def default_ide_pref_dir_version
        "13"
      end
    end
  end
end
