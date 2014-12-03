require "cli/ide/jet_brains_ide"

module Cli
  module Ide
    class Webstorm < JetBrainsIde
      def ide_pref_dir_name_without_version
        "WebStorm"
      end

      def default_ide_pref_dir_version
        "9"
      end
    end
  end
end
