module Cli
  module Logging
    class LogUninstall
      def klass
        IdePrefs::Commands::UninstallPrefs
      end

      def method_to_log
        :execute
      end

      def before(logger: nil, args: nil)
        logger.info "Uninstall command initiated"
      end

      def after(logger: nil, args: nil)
        logger.info "Uninstall complete!"
      end
    end
  end
end
