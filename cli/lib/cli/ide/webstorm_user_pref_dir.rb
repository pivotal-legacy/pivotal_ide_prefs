require "cli/ide/jet_brains_ide_user_pref_dir"

module Cli
  module Ide
    class WebstormUserPrefDir < JetBrainsIdeUserPrefDir
      def ide_pref_dir_name_without_version
        "WebStorm"
      end

      def default_ide_pref_dir_version
        "10"
      end
    end
  end
end
