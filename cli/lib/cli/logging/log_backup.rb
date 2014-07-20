require "persistence/repos/backup_prefs_repo"

module Cli
  module Logging
    class LogBackup
      def klass
        Persistence::Repos::BackupPrefsRepo
      end

      def method_to_log
        :back_up_prefs
      end

      def before(logger: nil, args: nil)
        logger.info "Backing up existing prefs"
      end
    end
  end
end
