module IdePrefs
  module Commands
    class InstallPrefs
      def initialize(user_prefs_repo: nil, pivotal_prefs_repo: nil, backup_prefs_repo: nil)
        @user_prefs_repo = user_prefs_repo
        @pivotal_prefs_repo = pivotal_prefs_repo
        @backup_prefs_repo = backup_prefs_repo
      end

      def execute
        backup_user_prefs
        install_pivotal_prefs
      end

      private
      attr_reader(
        :pivotal_prefs_repo,
        :user_prefs_repo,
        :backup_prefs_repo,
      )

      def backup_user_prefs
        backup_prefs_repo.back_up_prefs(matching_user_prefs)
      end

      def matching_user_prefs
        user_prefs_repo.find_matching_prefs(pivotal_prefs_repo.prefs)
      end

      def install_pivotal_prefs
        user_prefs_repo.install_prefs(pivotal_prefs_repo.prefs)
      end
    end
  end
end
