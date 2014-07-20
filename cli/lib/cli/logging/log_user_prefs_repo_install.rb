require "persistence/repos/user_prefs_repo"

module Cli
  module Logging
    class LogUserPrefsRepoInstall
      def klass
        Persistence::Repos::UserPrefsRepo
      end

      def method_to_log
        :install_prefs
      end

      def before(logger: nil, args: nil)
        logger.info "Installing Pivotal Prefs"
      end
    end
  end
end
