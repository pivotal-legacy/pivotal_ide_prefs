require "ide_prefs/commands/uninstall_prefs"

module Cli
  module Logging
    class LogRestoreBackups
      def klass
        IdePrefs::Commands::UninstallPrefs
      end

      def method_to_log
        :restore_backed_up_prefs
      end

      def before(logger: nil, args: nil)
        logger.info "Restoring Backed Up Preferences"
      end
    end
  end
end
