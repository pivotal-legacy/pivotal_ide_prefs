require "cli/ide/jet_brains_ide_user_pref_dir"

module Cli
  module Ide
    class AndroidstudioUserPrefDir < JetBrainsIdeUserPrefDir
      def ide_pref_dir_name_without_version
        "AndroidStudio"
      end

      def default_ide_pref_dir_version
        ""
      end
    end
  end
end
