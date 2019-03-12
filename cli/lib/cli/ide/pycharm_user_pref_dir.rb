require "cli/ide/jet_brains_ide_user_pref_dir"

module Cli
  module Ide
    class PycharmUserPrefDir < JetBrainsIdeUserPrefDir
      def ide_pref_dir_name_without_version
        "PyCharm"
      end

      def default_ide_pref_dir_version
        "2018.3"
      end
    end
  end
end
