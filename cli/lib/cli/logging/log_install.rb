require "ide_prefs/commands/install_prefs"

module Cli
  module Logging
    class LogInstall
      def klass
        IdePrefs::Commands::InstallPrefs
      end

      def method_to_log
        :execute
      end

      def before(logger: nil, args: nil)
        logger.info "Install command initiated"
      end

      def after(logger: nil, args: nil)
        logger.info "Install complete!"
      end
    end
  end
end
