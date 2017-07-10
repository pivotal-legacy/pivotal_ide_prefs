require "cli/ide/jet_brains_ide_user_pref_dir"

module Cli
  module Ide
    class IntellijcommunityUserPrefDir < JetBrainsIdeUserPrefDir
      def ide_pref_dir_name_without_version
        "IdeaIC"
      end

      def default_ide_pref_dir_version
        "2017.1"
      end
    end
  end
end
