require "cli/ide/jet_brains_ide_user_pref_dir"

module Cli
  module Ide
    class GoglandUserPrefDir < JetBrainsIdeUserPrefDir
      def ide_pref_dir_name_without_version
        "Gogland"
      end

      def default_ide_pref_dir_version
        "1.0"
      end
    end
  end
end
