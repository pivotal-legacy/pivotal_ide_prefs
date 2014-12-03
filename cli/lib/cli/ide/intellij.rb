require "cli/ide/jet_brains_ide"

module Cli
  module Ide
    class Intellij < JetBrainsIde
      def ide_pref_dir_name_without_version
        "IntelliJIdea"
      end

      def default_ide_pref_dir_version
        "13"
      end
    end
  end
end
