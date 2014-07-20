require "persistence/repos/user_prefs_repo"

module Cli
  module Logging
    class LogUserPrefsRepoDestroyInstalledPrefs
      def klass
        Persistence::Repos::UserPrefsRepo
      end

      def method_to_log
        :destroy_installed_prefs
      end

      def before(logger: nil, args: nil)
        logger.info "Removing Installed Pivotal Prefs"
      end
    end
  end
end
